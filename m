From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: snd-usb: add quirks handler for DSD
	streams
Date: Thu, 28 Mar 2013 00:30:46 +0100
Message-ID: <1364427046-29944-2-git-send-email-zonque@gmail.com>
References: <1364427046-29944-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 14C2026533F
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:31:05 +0100 (CET)
In-Reply-To: <1364427046-29944-1-git-send-email-zonque@gmail.com>
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

If that quirks handler returns /true/, the PCM formats will be augmented
by SNDRV_PCM_FMTBIT_DSD_{U8_U16}, depending on the parsed sample_bytes.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/format.c | 19 +++++++++++++++++++
 sound/usb/quirks.c |  8 ++++++++
 sound/usb/quirks.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index a695caf..e4c8610 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -136,6 +136,25 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		snd_printk(KERN_INFO "%d:%u:%d : unsupported format bits %#x\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
 	}
+
+	/*
+	 * DSD has no designated specifiers in the USB audio spec, so we have
+	 * to rely on a quirks list.
+	 */
+	if (snd_usb_interface_is_dsd(chip->dev, fp->iface, fp->altsetting)) {
+	switch (sample_bytes) {
+	case 1:
+		pcm_formats |= SNDRV_PCM_FMTBIT_DSD_U8;
+		break;
+	case 2:
+		pcm_formats |= SNDRV_PCM_FMTBIT_DSD_U16;
+		break;
+	default:
+		snd_printk(KERN_INFO "%d:%u:%d : unsupported DSD sample bitwidth %d\n",
+			   chip->dev->devnum, fp->iface, fp->altsetting, sample_width);
+	}
+	}
+
 	return pcm_formats;
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a2ac004..9d7e95c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -905,3 +905,11 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 		mdelay(20);
 }
 
+bool snd_usb_interface_is_dsd(struct usb_device *dev,
+			      int interface, int alt_no)
+{
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x23ba) && alt_no > 1)
+		return true;
+
+	return false;
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 0ca9e91..a777ef0 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -30,4 +30,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
 
+bool snd_usb_interface_is_dsd(struct usb_device *dev,
+                              int interface, int alt_no);
+
 #endif /* __USBAUDIO_QUIRKS_H */
-- 
1.8.1.4
