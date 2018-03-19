From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 1/2] ALSA: usb-audio: move audioformat
	quirks to quirks.c
Date: Mon, 19 Mar 2018 03:46:02 +0200
Message-ID: <1521423963-24677-2-git-send-email-ruslan.bilovol@gmail.com>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A3A267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 02:46:07 +0100 (CET)
Received: by mail-lf0-f68.google.com with SMTP id t132-v6so23006909lfe.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 18:46:07 -0700 (PDT)
In-Reply-To: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

Offload USB audio interface parsing function by
moving quirks to a specially designed location (quirks.c)

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/quirks.c | 34 ++++++++++++++++++++++++++++++++++
 sound/usb/quirks.h |  4 ++++
 sound/usb/stream.c | 30 +-----------------------------
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea8f3de..eeea8e1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1403,3 +1403,37 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 
 	return 0;
 }
+
+void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
+					  struct audioformat *fp,
+					  int stream)
+{
+	switch (chip->usb_id) {
+	case USB_ID(0x0a92, 0x0053): /* AudioTrak Optoplay */
+		/* Optoplay sets the sample rate attribute although
+		 * it seems not supporting it in fact.
+		 */
+		fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
+		break;
+	case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
+	case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
+		/* doesn't set the sample rate attribute, but supports it */
+		fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
+		break;
+	case USB_ID(0x0763, 0x2001):  /* M-Audio Quattro USB */
+	case USB_ID(0x0763, 0x2012):  /* M-Audio Fast Track Pro USB */
+	case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
+	case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
+					an older model 77d:223) */
+	/*
+	 * plantronics headset and Griffin iMic have set adaptive-in
+	 * although it's really not...
+	 */
+		fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			fp->ep_attr |= USB_ENDPOINT_SYNC_ADAPTIVE;
+		else
+			fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
+		break;
+	}
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index b90c8b7..a80e0dd 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -42,4 +42,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 					struct audioformat *fp,
 					unsigned int sample_bytes);
 
+void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
+					  struct audioformat *fp,
+					  int stream);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d1776e5..dbbe854 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -678,35 +678,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		INIT_LIST_HEAD(&fp->list);
 
 		/* some quirks for attributes here */
-
-		switch (chip->usb_id) {
-		case USB_ID(0x0a92, 0x0053): /* AudioTrak Optoplay */
-			/* Optoplay sets the sample rate attribute although
-			 * it seems not supporting it in fact.
-			 */
-			fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
-			break;
-		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
-		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-			/* doesn't set the sample rate attribute, but supports it */
-			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
-			break;
-		case USB_ID(0x0763, 0x2001):  /* M-Audio Quattro USB */
-		case USB_ID(0x0763, 0x2012):  /* M-Audio Fast Track Pro USB */
-		case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
-		case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
-						an older model 77d:223) */
-		/*
-		 * plantronics headset and Griffin iMic have set adaptive-in
-		 * although it's really not...
-		 */
-			fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
-			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-				fp->ep_attr |= USB_ENDPOINT_SYNC_ADAPTIVE;
-			else
-				fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
-			break;
-		}
+		snd_usb_audioformat_attributes_quirk(chip, fp, stream);
 
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream) < 0) {
-- 
1.9.1
