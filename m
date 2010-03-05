From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/8] ALSA: usb-audio: rename substream format
	field to altset_idx
Date: Fri,  5 Mar 2010 08:41:21 +0100
Message-ID: <1267774885-16266-5-git-send-email-daniel@caiaq.de>
References: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
	<1267774885-16266-2-git-send-email-daniel@caiaq.de>
	<1267774885-16266-3-git-send-email-daniel@caiaq.de>
	<1267774885-16266-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 01834103A2A
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 08:42:02 +0100 (CET)
In-Reply-To: <1267774885-16266-4-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

From: Clemens Ladisch <clemens@ladisch.de>

The snd_usb_substream::format field actually contains the index of the
current alternate setting, so rename it to altset_idx to avoid
confusion.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/card.h |    2 +-
 sound/usb/pcm.c  |    8 ++++----
 sound/usb/proc.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 71f03c1..856d71b 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -54,7 +54,7 @@ struct snd_usb_substream {
 	struct audioformat *cur_audiofmt;	/* current audioformat pointer (for hw_params callback) */
 	unsigned int cur_rate;		/* current rate (for hw_params callback) */
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
-	unsigned int format;     /* USB data format */
+	unsigned int altset_idx;     /* USB data format: index of alternate setting */
 	unsigned int datapipe;   /* the data i/o pipe */
 	unsigned int syncpipe;   /* 1 - async out or adaptive in */
 	unsigned int datainterval;	/* log_2 of data packet interval */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 87863cc..c3d5a97 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -202,11 +202,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 			return -EIO;
 		}
 		subs->interface = -1;
-		subs->format = 0;
+		subs->altset_idx = 0;
 	}
 
 	/* set interface */
-	if (subs->interface != fmt->iface || subs->format != fmt->altset_idx) {
+	if (subs->interface != fmt->iface || subs->altset_idx != fmt->altset_idx) {
 		if (usb_set_interface(dev, fmt->iface, fmt->altsetting) < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed\n",
 				   dev->devnum, fmt->iface, fmt->altsetting);
@@ -214,7 +214,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		snd_printdd(KERN_INFO "setting usb interface %d:%d\n", fmt->iface, fmt->altsetting);
 		subs->interface = fmt->iface;
-		subs->format = fmt->altset_idx;
+		subs->altset_idx = fmt->altset_idx;
 	}
 
 	/* create a data pipe */
@@ -771,7 +771,7 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	struct snd_usb_substream *subs = &as->substream[direction];
 
 	subs->interface = -1;
-	subs->format = 0;
+	subs->altset_idx = 0;
 	runtime->hw = snd_usb_hardware;
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index be3065e..78fc3ba 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -116,7 +116,7 @@ static void proc_dump_substream_status(struct snd_usb_substream *subs, struct sn
 		unsigned int i;
 		snd_iprintf(buffer, "  Status: Running\n");
 		snd_iprintf(buffer, "    Interface = %d\n", subs->interface);
-		snd_iprintf(buffer, "    Altset = %d\n", subs->format);
+		snd_iprintf(buffer, "    Altset = %d\n", subs->altset_idx);
 		snd_iprintf(buffer, "    URBs = %d [ ", subs->nurbs);
 		for (i = 0; i < subs->nurbs; i++)
 			snd_iprintf(buffer, "%d ", subs->dataurb[i].packets);
-- 
1.6.6.2
