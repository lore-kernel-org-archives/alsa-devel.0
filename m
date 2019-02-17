From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: Expose sample resolution
	through proc interface
Date: Mon, 18 Feb 2019 00:17:21 +0200
Message-ID: <20190217221721.6396-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B036266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 09:55:44 +0100 (CET)
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

At least some USB devices use (MSB-aligned) audio format larger
than the actual resolution of the device. In order to expose the
actual device resolution (bBitResolution), add extra field to the
procfs stream info interface.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/card.h   | 1 +
 sound/usb/format.c | 2 ++
 sound/usb/proc.c   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index ac785d15ced4..d9bb2c4a3bd9 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -14,6 +14,7 @@ struct audioformat {
 	u64 formats;			/* ALSA format bits */
 	unsigned int channels;		/* # channels */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
+        unsigned int fmt_bits;          /* number of significant bits */
 	unsigned int frame_size;	/* samples per frame for non-audio */
 	int iface;			/* interface number */
 	unsigned char altsetting;	/* corresponding alternate setting */
diff --git a/sound/usb/format.c b/sound/usb/format.c
index fd13ac11b136..d5b7cbcc2956 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -87,6 +87,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 	}
 	}
 
+	fp->fmt_bits = (unsigned int) sample_width;
+
 	if ((pcm_formats == 0) &&
 	    (format == 0 || format == (1 << UAC_FORMAT_TYPE_I_UNDEFINED))) {
 		/* some devices don't define this correctly... */
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index e80c9d0749c9..ef9190530fd2 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -109,6 +109,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 		if (subs->speed != USB_SPEED_FULL)
 			snd_iprintf(buffer, "    Data packet interval: %d us\n",
 				    125 * (1 << fp->datainterval));
+		snd_iprintf(buffer, "    Bits: %d\n", fp->fmt_bits);
 		// snd_iprintf(buffer, "    Max Packet Size = %d\n", fp->maxpacksize);
 		// snd_iprintf(buffer, "    EP Attribute = %#x\n", fp->attributes);
 	}
-- 
2.17.1
