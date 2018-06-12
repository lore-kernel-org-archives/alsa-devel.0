From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 1/2] ALSA: usb-audio: Add native DSD support
	for Mytek DACs
Date: Wed, 13 Jun 2018 01:43:01 +0300
Message-ID: <1528843382-15206-2-git-send-email-jussi@sonarnerd.net>
References: <1528843382-15206-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CCEF267253
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 00:43:38 +0200 (CEST)
In-Reply-To: <1528843382-15206-1-git-send-email-jussi@sonarnerd.net>
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
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Add new mostly generic code with Mytek VID to support native DSD mode.

This implementation should be easier to maintain when manufacturers
release new products.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/card.h   |  1 +
 sound/usb/format.c |  5 ++++-
 sound/usb/quirks.c | 12 ++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 1406292..9b41b7d 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -32,6 +32,7 @@ struct audioformat {
 	struct snd_pcm_chmap_elem *chmap; /* (optional) channel map */
 	bool dsd_dop;			/* add DOP headers in case of DSD samples */
 	bool dsd_bitrev;		/* reverse the bits of each DSD sample */
+	bool dsd_raw;			/* altsetting is raw DSD */
 };
 
 struct snd_usb_substream;
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 49e7ec6..0a2a27f 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -64,8 +64,11 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = fmt->bBitResolution;
 		sample_bytes = fmt->bSubslotSize;
 
-		if (format & UAC2_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC2_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			/* flag potentially raw DSD capable altsettings */
+			fp->dsd_raw = true;
+		}
 
 		format <<= 1;
 		break;
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f4b6917..cc7a623 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1443,6 +1443,18 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
+	/* Mostly generic method to detect many DSD-capable implementations -
+	 * from XMOS/Thesycon */
+	switch (USB_ID_VENDOR(chip->usb_id)) {
+	case 0x25ce:  /* Mytek devices */
+		if (fp->dsd_raw)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+		break;
+	default:
+		break;
+
+	}
+
 	return 0;
 }
 
-- 
2.7.4
