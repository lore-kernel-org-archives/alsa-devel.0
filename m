From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 09/11] ALSA: usb-audio: create PCM device
	entities
Date: Tue, 28 Aug 2012 00:34:24 +0200
Message-ID: <503BF5F0.10209@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9285F265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:35:22 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/quirks.c |    4 ++--
 sound/usb/stream.c |   16 +++++++++++-----
 sound/usb/stream.h |    1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2781726..293b4ba 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -152,7 +152,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,

 	stream = (fp->endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
+	err = snd_usb_add_audio_stream(chip, stream, 0, fp);
 	if (err < 0) {
 		kfree(fp);
 		kfree(rate_table);
@@ -258,7 +258,7 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,

 	stream = (fp->endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
+	err = snd_usb_add_audio_stream(chip, stream, 0, fp);
 	if (err < 0) {
 		kfree(fp);
 		return err;
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index e166eb5..145324d 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -78,7 +78,7 @@ static void snd_usb_audio_pcm_free(struct snd_pcm *pcm)
  */

 static void snd_usb_init_substream(struct snd_usb_stream *as,
-				   int stream,
+				   int stream, u8 terminal_id,
 				   struct audioformat *fp)
 {
 	struct snd_usb_substream *subs = &as->substream[stream];
@@ -98,6 +98,9 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
 	subs->num_formats++;
 	subs->fmt_type = fp->fmt_type;
 	subs->ep_num = fp->endpoint;
+
+	if (terminal_id > 0)
+		snd_pcm_media_entities_create(as->pcm, stream, terminal_id);
 }

 /*
@@ -106,7 +109,7 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
  * if not, create a new pcm stream.
  */
 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
-			     int stream,
+			     int stream, u8 terminal_id,
 			     struct audioformat *fp)
 {
 	struct list_head *p;
@@ -138,7 +141,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		err = snd_pcm_new_stream(as->pcm, stream, 1);
 		if (err < 0)
 			return err;
-		snd_usb_init_substream(as, stream, fp);
+		snd_usb_init_substream(as, stream, terminal_id, fp);
 		return 0;
 	}

@@ -166,7 +169,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 	else
 		strcpy(pcm->name, "USB Audio");

-	snd_usb_init_substream(as, stream, fp);
+	snd_usb_init_substream(as, stream, terminal_id, fp);

 	list_add(&as->list, &chip->pcm_list);
 	chip->pcm_devs++;
@@ -260,6 +263,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
+	u8 terminal_id = 0;

 	dev = chip->dev;

@@ -324,6 +328,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			}

 			format = le16_to_cpu(as->wFormatTag); /* remember the format value */
+			terminal_id = as->bTerminalLink;
 			break;
 		}

@@ -347,6 +352,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)

 			num_channels = as->bNrChannels;
 			format = le32_to_cpu(as->bmFormats);
+			terminal_id = as->bTerminalLink;

 			/* lookup the terminal associated to this interface
 			 * to extract the clock */
@@ -460,7 +466,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		}

 		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint %#x\n", dev->devnum, iface_no, altno, fp->endpoint);
-		err = snd_usb_add_audio_stream(chip, stream, fp);
+		err = snd_usb_add_audio_stream(chip, stream, terminal_id, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);
 			kfree(fp);
diff --git a/sound/usb/stream.h b/sound/usb/stream.h
index c97f679..31f17c0 100644
--- a/sound/usb/stream.h
+++ b/sound/usb/stream.h
@@ -6,6 +6,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip,

 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
+			     u8 terminal_id,
 			     struct audioformat *fp);

 #endif /* __USBAUDIO_STREAM_H */
