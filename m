From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/5] ALSA: snd-usb: use snd_printk() instead of
	printk()
Date: Wed, 13 Jul 2011 02:13:26 +0200
Message-ID: <1310516009-4387-2-git-send-email-zonque@gmail.com>
References: <1310516009-4387-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C77A1038E2
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 02:13:36 +0200 (CEST)
In-Reply-To: <1310516009-4387-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.c  |    4 ++--
 sound/usb/clock.c |    6 +++---
 sound/usb/midi.c  |    4 ++--
 sound/usb/pcm.c   |   12 ++++++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 8990b49..9a4f423 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -488,7 +488,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 				break;
 			}
 		if (!chip) {
-			printk(KERN_ERR "no available usb audio device\n");
+			snd_printk(KERN_ERR "no available usb audio device\n");
 			goto __error;
 		}
 	}
@@ -709,7 +709,7 @@ static struct usb_driver usb_audio_driver = {
 static int __init snd_usb_audio_init(void)
 {
 	if (nrpacks < 1 || nrpacks > MAX_PACKS) {
-		printk(KERN_WARNING "invalid nrpacks value.\n");
+		snd_printk(KERN_WARNING "invalid nrpacks value.\n");
 		return -EINVAL;
 	}
 	return usb_register(&usb_audio_driver);
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 075195e..b319299 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -163,9 +163,9 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		/* Selector values are one-based */
 
 		if (ret > selector->bNrInPins || ret < 1) {
-			printk(KERN_ERR
-				"%s(): selector reported illegal value, id %d, ret %d\n",
-				__func__, selector->bClockID, ret);
+			snd_printk(KERN_ERR
+				   "%s(): selector reported illegal value, id %d, ret %d\n",
+				   __func__, selector->bClockID, ret);
 
 			return -EINVAL;
 		}
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f928910..a2ae089 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -237,8 +237,8 @@ static void dump_urb(const char *type, const u8 *data, int length)
 {
 	snd_printk(KERN_DEBUG "%s packet: [", type);
 	for (; length > 0; ++data, --length)
-		printk(" %02x", *data);
-	printk(" ]\n");
+		snd_printk(" %02x", *data);
+	snd_printk(" ]\n");
 }
 #else
 #define dump_urb(type, data, length) /* nothing */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b8dcbf4..24a7a404 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -300,12 +300,12 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	snd_usb_set_format_quirk(subs, fmt);
 
 #if 0
-	printk(KERN_DEBUG
-	       "setting done: format = %d, rate = %d..%d, channels = %d\n",
-	       fmt->format, fmt->rate_min, fmt->rate_max, fmt->channels);
-	printk(KERN_DEBUG
-	       "  datapipe = 0x%0x, syncpipe = 0x%0x\n",
-	       subs->datapipe, subs->syncpipe);
+	snd_printk(KERN_DEBUG
+		   "setting done: format = %d, rate = %d..%d, channels = %d\n",
+		   fmt->format, fmt->rate_min, fmt->rate_max, fmt->channels);
+	snd_printk(KERN_DEBUG
+		   "  datapipe = 0x%0x, syncpipe = 0x%0x\n",
+		   subs->datapipe, subs->syncpipe);
 #endif
 
 	return 0;
-- 
1.7.5.4
