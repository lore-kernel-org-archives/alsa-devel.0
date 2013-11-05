From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: usb - Don't trust the channel config
	if the channel count changed
Date: Tue,  5 Nov 2013 04:41:08 +0100
Message-ID: <1383622868-2596-4-git-send-email-david.henningsson@canonical.com>
References: <1383622868-2596-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 79EF7264F47
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 04:41:12 +0100 (CET)
In-Reply-To: <1383622868-2596-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In case the channel count of the input terminal is not the same as
the channel count of the streaming descriptor, the channel config of
the input terminal can not be trusted. Instead fall back to a default
(guessed) channel map.

This was found on a Logitech USB Headset.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/stream.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index badd1d6d..d737d0e 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -662,7 +662,6 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 					* (fp->maxpacksize & 0x7ff);
 		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
 		fp->clock = clock;
-		fp->chmap = convert_chmap(num_channels, chconfig, protocol);
 
 		/* some quirks for attributes here */
 
@@ -698,12 +697,16 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream) < 0) {
 			kfree(fp->rate_table);
-			kfree(fp->chmap);
 			kfree(fp);
 			fp = NULL;
 			continue;
 		}
 
+		/* Create chmap */
+		if (fp->channels != num_channels)
+			chconfig = 0;
+		fp->chmap = convert_chmap(fp->channels, chconfig, protocol);
+
 		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint %#x\n", dev->devnum, iface_no, altno, fp->endpoint);
 		err = snd_usb_add_audio_stream(chip, stream, fp);
 		if (err < 0) {
-- 
1.7.9.5
