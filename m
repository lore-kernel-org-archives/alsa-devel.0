From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: snd-usb: add quirks handler for DSD
	streams
Date: Sat,  6 Apr 2013 13:44:52 +0200
Message-ID: <1365248693-27867-2-git-send-email-zonque@gmail.com>
References: <1365248693-27867-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5717C2617A4
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 13:44:49 +0200 (CEST)
In-Reply-To: <1365248693-27867-1-git-send-email-zonque@gmail.com>
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
Cc: jussi@sonarnerd.net, tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Unfortunately, none of the UAC standards provides a way to identify DSD
(Direct Stream Digital) formats. Hence, this patch adds a quirks
handler to identify USB interfaces that are capable of handling DSD.

That quirks handler can augment the already parsed formats bit-field,
typically by any of the new SNDRV_PCM_FMTBIT_DSD_DOP_{U8_U16}, and it
currently does so for USB devices matching the 'Playback Design'
vendor id.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/format.c |  3 +++
 sound/usb/quirks.c | 23 +++++++++++++++++++++++
 sound/usb/quirks.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index a695caf..a73d67a 100644
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
index a2ac004..2fcc984 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -905,3 +905,26 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
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
+	if ((le16_to_cpu(chip->dev->descriptor.idVendor) == 0x23ba) &&
+	    fp->altsetting > 1) {
+		switch (sample_bytes) {
+		case 1:
+			return SNDRV_PCM_FMTBIT_DSD_DOP_U8;
+		case 2:
+			return SNDRV_PCM_FMTBIT_DSD_DOP_U16;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 0ca9e91..f10d00e 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -30,4 +30,8 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
 
+u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
+					struct audioformat *fp,
+					unsigned int sample_bytes);
+
 #endif /* __USBAUDIO_QUIRKS_H */
-- 
1.8.1.4
