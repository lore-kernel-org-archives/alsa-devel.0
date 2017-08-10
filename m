From: Alexander Tsoy <alexander@tsoy.me>
Subject: [PATCH] ALSA: usb-audio: fix PCM device order
Date: Fri, 11 Aug 2017 02:36:14 +0300
Message-ID: <20170810233614.3184-1-alexander@tsoy.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from puleglot.ru (puleglot.ru [78.47.112.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C11A2675DB
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 01:36:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some cards have alternate setting with non-PCM format as the first
altsetting in the interface descriptors. This confuses userspace, since
alsa-lib uses device 0 by default. So lets parse interfaces in two steps:
 1. Parse altsettings with PCM formats.
 2. Parse altsettings with non-PCM formats.

This fixes at least following cards:
 - Audinst HUD-mx2
 - Audinst HUD-mini

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 sound/usb/stream.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8e9548bc1f1a..b2ebeae91396 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -477,7 +477,8 @@ static struct uac2_output_terminal_descriptor *
 	return NULL;
 }
 
-int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
+static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no,
+				           bool *has_non_pcm, bool non_pcm)
 {
 	struct usb_device *dev;
 	struct usb_interface *iface;
@@ -634,6 +635,10 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 				iface_no, altno);
 			continue;
 		}
+		if (fmt->bFormatType != UAC_FORMAT_TYPE_I)
+			*has_non_pcm = true;
+		if ((fmt->bFormatType == UAC_FORMAT_TYPE_I) == non_pcm)
+			continue;
 		if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8)) ||
 		    ((protocol == UAC_VERSION_2) && (fmt->bLength < 6))) {
 			dev_err(&dev->dev,
@@ -740,3 +745,23 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	return 0;
 }
 
+int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
+{
+	int err;
+	bool has_non_pcm = false;
+
+	/* parse PCM formats */
+	err = __snd_usb_parse_audio_interface(chip, iface_no, &has_non_pcm, false);
+	if (err < 0)
+		return err;
+
+	if (has_non_pcm) {
+		/* parse non-PCM formats */
+		err = __snd_usb_parse_audio_interface(chip, iface_no, &has_non_pcm, true);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
-- 
2.13.0
