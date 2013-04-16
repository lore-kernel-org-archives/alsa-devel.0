From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 5/5] ALSA: snd-usb: add quirks handler for
	DSD streams
Date: Wed, 17 Apr 2013 00:01:40 +0800
Message-ID: <1366128100-9778-6-git-send-email-zonque@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FEA2610CA
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:56 +0200 (CEST)
In-Reply-To: <1366128100-9778-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Unfortunately, none of the UAC standards provides a way to identify DSD
(Direct Stream Digital) formats. Hence, this patch adds a quirks
handler to identify USB interfaces that are capable of handling DSD.

That quirks handler can augment the already parsed formats bit-field,
by any of the new SNDRV_PCM_FMTBIT_DSD_{U8_U16} and setting the dsd_dop
flag in the audio format, if the driver should take care for the DOP
byte stuffing.

The only devices that are known to work with this are the ones with
a 'Playback Designs' vendor id.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/format.c |    3 +++
 sound/usb/quirks.c |   28 ++++++++++++++++++++++++++++
 sound/usb/quirks.h |    4 ++++
 3 files changed, 35 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 20c7751..020ede0 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -136,6 +136,9 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		snd_printk(KERN_INFO "%d:%u:%d : unsupported format bits %#x\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
 	}
+
+	pcm_formats |= snd_usb_interface_dsd_format_quirks(chip, fp, sample_bytes);
+
 	return pcm_formats;
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2927981..4c6366c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -915,3 +915,31 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 		mdelay(20);
 }
 
+/*
+ * snd_usb_interface_dsd_format_quirks() is called from format.c to
+ * augment the PCM format bit-field for DSD types. The UAC standards
+ * don't have a designated bit field to denote DSD-capable interfaces,
+ * hence all hardware that is known to support this format has to be
+ * listed here.
+ */
+u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
+					struct audioformat *fp,
+					unsigned int sample_bytes)
+{
+	/* Playback Designs */
+	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x23ba) {
+		switch (fp->altsetting) {
+		case 1:
+			fp->dsd_dop = true;
+			return SNDRV_PCM_FMTBIT_DSD_U16_LE;
+		case 2:
+			fp->dsd_bitrev = true;
+			return SNDRV_PCM_FMTBIT_DSD_U8;
+		case 3:
+			fp->dsd_bitrev = true;
+			return SNDRV_PCM_FMTBIT_DSD_U16_LE;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 7c3681f..665e972 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -31,4 +31,8 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
 
+u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
+					struct audioformat *fp,
+					unsigned int sample_bytes);
+
 #endif /* __USBAUDIO_QUIRKS_H */
-- 
1.7.10.4
