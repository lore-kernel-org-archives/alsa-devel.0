From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/3] ALSA: usb-audio: support multiple formats
 with audio class v2 devices
Date: Mon, 01 Mar 2010 12:27:54 +0100
Message-ID: <4B8BA4BA.8040609@ladisch.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<1267194883-6854-3-git-send-email-daniel@caiaq.de>
	<1267194883-6854-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D2ACF103865
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 12:27:55 +0100 (CET)
In-Reply-To: <1267194883-6854-4-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Change the parser to correctly handle v2 descriptors with multiple
format bits set.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux/sound/usb/format.c
+++ linux/sound/usb/format.c
@@ -37,19 +37,20 @@
  * @format: the format tag (wFormatTag)
  * @fmt: the format type descriptor
  */
-static int parse_audio_format_i_type(struct snd_usb_audio *chip,
+static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 				     struct audioformat *fp,
 				     int format, void *_fmt,
 				     int protocol)
 {
-	int pcm_format, i;
 	int sample_width, sample_bytes;
+	u64 pcm_formats;
 
 	switch (protocol) {
 	case UAC_VERSION_1: {
 		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
 		sample_width = fmt->bBitResolution;
 		sample_bytes = fmt->bSubframeSize;
+		format = 1 << format;
 		break;
 	}
 
@@ -57,24 +58,7 @@ static int parse_audio_format_i_type(str
 		struct uac_format_type_i_ext_descriptor *fmt = _fmt;
 		sample_width = fmt->bBitResolution;
 		sample_bytes = fmt->bSubslotSize;
-
-		/*
-		 * FIXME
-		 * USB audio class v2 devices specify a bitmap of possible
-		 * audio formats rather than one fix value. For now, we just
-		 * pick one of them and report that as the only possible
-		 * value for this setting.
-		 * The bit allocation map is in fact compatible to the
-		 * wFormatTag of the v1 AS streaming descriptors, which is why
-		 * we can simply map the matrix.
-		 */
-
-		for (i = 0; i < 5; i++)
-			if (format & (1UL << i)) {
-				format = i + 1;
-				break;
-			}
-
+		format <<= 1;
 		break;
 	}
 
@@ -82,15 +66,15 @@ static int parse_audio_format_i_type(str
 		return -EINVAL;
 	}
 
-	/* FIXME: correct endianess and sign? */
-	pcm_format = -1;
+	pcm_formats = 0;
 
-	switch (format) {
-	case UAC_FORMAT_TYPE_I_UNDEFINED: /* some devices don't define this correctly... */
+	if (format == 0 || format == (1 << UAC_FORMAT_TYPE_I_UNDEFINED)) {
+		/* some devices don't define this correctly... */
 		snd_printdd(KERN_INFO "%d:%u:%d : format type 0 is detected, processed as PCM\n",
 			    chip->dev->devnum, fp->iface, fp->altsetting);
-		/* fall-through */
-	case UAC_FORMAT_TYPE_I_PCM:
+		format = 1 << UAC_FORMAT_TYPE_I_PCM;
+	}
+	if (format & (1 << UAC_FORMAT_TYPE_I_PCM)) {
 		if (sample_width > sample_bytes * 8) {
 			snd_printk(KERN_INFO "%d:%u:%d : sample bitwidth %d in over sample bytes %d\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting,
@@ -99,22 +83,22 @@ static int parse_audio_format_i_type(str
 		/* check the format byte size */
 		switch (sample_bytes) {
 		case 1:
-			pcm_format = SNDRV_PCM_FORMAT_S8;
+			pcm_formats |= SNDRV_PCM_FMTBIT_S8;
 			break;
 		case 2:
 			if (snd_usb_is_big_endian_format(chip, fp))
-				pcm_format = SNDRV_PCM_FORMAT_S16_BE; /* grrr, big endian!! */
+				pcm_formats |= SNDRV_PCM_FMTBIT_S16_BE; /* grrr, big endian!! */
 			else
-				pcm_format = SNDRV_PCM_FORMAT_S16_LE;
+				pcm_formats |= SNDRV_PCM_FMTBIT_S16_LE;
 			break;
 		case 3:
 			if (snd_usb_is_big_endian_format(chip, fp))
-				pcm_format = SNDRV_PCM_FORMAT_S24_3BE; /* grrr, big endian!! */
+				pcm_formats |= SNDRV_PCM_FMTBIT_S24_3BE; /* grrr, big endian!! */
 			else
-				pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
+				pcm_formats |= SNDRV_PCM_FMTBIT_S24_3LE;
 			break;
 		case 4:
-			pcm_format = SNDRV_PCM_FORMAT_S32_LE;
+			pcm_formats |= SNDRV_PCM_FMTBIT_S32_LE;
 			break;
 		default:
 			snd_printk(KERN_INFO "%d:%u:%d : unsupported sample bitwidth %d in %d bytes\n",
@@ -122,30 +106,29 @@ static int parse_audio_format_i_type(str
 				   sample_width, sample_bytes);
 			break;
 		}
-		break;
-	case UAC_FORMAT_TYPE_I_PCM8:
-		pcm_format = SNDRV_PCM_FORMAT_U8;
-
+	}
+	if (format & (1 << UAC_FORMAT_TYPE_I_PCM8)) {
 		/* Dallas DS4201 workaround: it advertises U8 format, but really
 		   supports S8. */
 		if (chip->usb_id == USB_ID(0x04fa, 0x4201))
-			pcm_format = SNDRV_PCM_FORMAT_S8;
-		break;
-	case UAC_FORMAT_TYPE_I_IEEE_FLOAT:
-		pcm_format = SNDRV_PCM_FORMAT_FLOAT_LE;
-		break;
-	case UAC_FORMAT_TYPE_I_ALAW:
-		pcm_format = SNDRV_PCM_FORMAT_A_LAW;
-		break;
-	case UAC_FORMAT_TYPE_I_MULAW:
-		pcm_format = SNDRV_PCM_FORMAT_MU_LAW;
-		break;
-	default:
-		snd_printk(KERN_INFO "%d:%u:%d : unsupported format type %d\n",
+			pcm_formats |= SNDRV_PCM_FMTBIT_S8;
+		else
+			pcm_formats |= SNDRV_PCM_FMTBIT_U8;
+	}
+	if (format & (1 << UAC_FORMAT_TYPE_I_IEEE_FLOAT)) {
+		pcm_formats |= SNDRV_PCM_FMTBIT_FLOAT_LE;
+	}
+	if (format & (1 << UAC_FORMAT_TYPE_I_ALAW)) {
+		pcm_formats |= SNDRV_PCM_FMTBIT_A_LAW;
+	}
+	if (format & (1 << UAC_FORMAT_TYPE_I_MULAW)) {
+		pcm_formats |= SNDRV_PCM_FMTBIT_MU_LAW;
+	}
+	if (format & ~0x3f) {
+		snd_printk(KERN_INFO "%d:%u:%d : unsupported format bits %#x\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
-		break;
 	}
-	return pcm_format;
+	return pcm_formats;
 }
 
 
@@ -313,14 +296,14 @@ static int parse_audio_format_i(struct s
 		default:
 			pcm_format = SNDRV_PCM_FORMAT_S16_LE;
 		}
+		fp->formats = 1uLL << pcm_format;
 	} else {
-		pcm_format = parse_audio_format_i_type(chip, fp, format, fmt, protocol);
-		if (pcm_format < 0)
+		fp->formats = parse_audio_format_i_type(chip, fp, format,
+							fmt, protocol);
+		if (!fp->formats)
 			return -1;
 	}
 
-	fp->formats = 1uLL << pcm_format;
-
 	/* gather possible sample rates */
 	/* audio class v1 reports possible sample rates as part of the
 	 * proprietary class specific descriptor.
