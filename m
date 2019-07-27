From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/2] ALSA: usb-audio: fix PCM device order
Date: Sat, 27 Jul 2019 11:30:06 +0200
Message-ID: <20190727093006.9870-3-tiwai@suse.de>
References: <20190727093006.9870-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9BF9F802BD
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2019 11:30:15 +0200 (CEST)
In-Reply-To: <20190727093006.9870-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Tanu Kaskinen <tanuk@iki.fi>, Alexander Tsoy <alexander@tsoy.me>
List-Id: alsa-devel@alsa-project.org

From: Alexander Tsoy <alexander@tsoy.me>

Some cards have alternate setting with non-PCM format as the first
altsetting in the interface descriptors. This confuses userspace, since
alsa-lib uses device 0 by default. So lets parse interfaces in two steps:
 1. Parse altsettings with PCM formats.
 2. Parse altsettings with non-PCM formats.

This fixes at least following cards:
 - Audinst HUD-mx2
 - Audinst HUD-mini

[ Adapted 5.3 kernel by tiwai ]

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/stream.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 963d425004f8..fc3e9fcfbc38 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1077,7 +1077,9 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	return fp;
 }
 
-int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
+static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
+					   int iface_no,
+					   bool *has_non_pcm, bool non_pcm)
 {
 	struct usb_device *dev;
 	struct usb_interface *iface;
@@ -1178,6 +1180,16 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		else if (IS_ERR(fp))
 			return PTR_ERR(fp);
 
+		if (fp->fmt_type != UAC_FORMAT_TYPE_I)
+			*has_non_pcm = true;
+		if ((fp->fmt_type == UAC_FORMAT_TYPE_I) == non_pcm) {
+			audioformat_free(fp);
+			kfree(pd);
+			fp = NULL;
+			pd = NULL;
+			continue;
+		}
+
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
 		if (protocol == UAC_VERSION_3)
 			err = snd_usb_add_audio_stream_v3(chip, stream, fp, pd);
@@ -1197,3 +1209,23 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
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
2.16.4
