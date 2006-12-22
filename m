From: John Daiker <daikerj@onid.orst.edu>
Subject: [PATCH][RESEND] usbaudio.c: remove unneeded casts
Date: Fri, 22 Dec 2006 10:45:04 -0800
Message-ID: <458C27B0.50005@onid.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp4.oregonstate.edu (smtp4.oregonstate.edu [128.193.15.32])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D20D1169
	for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2006 19:45:05 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel-janitors@lists.osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry for the mess up last time.  If things are fubar again, I'll try from a different mail client.

From: John Daiker <daikerjohn@gmail.com>

Went rummaging through usbaudio.c and found some castings that aren't needed as far as I can see.  Part of the KernelJanitors TODO list.

Signed-off-by: John Daiker <daikerjohn@gmail.com>

---
--- linux-2.6.orig/sound/usb/usbaudio.c	2006-12-21 13:19:19.000000000 -0800
+++ linux-2.6/sound/usb/usbaudio.c	2006-12-21 13:23:06.000000000 -0800
@@ -253,7 +253,7 @@
 				    struct urb *urb)
 {
 	unsigned char *cp = urb->transfer_buffer;
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
 	urb->iso_frame_desc[0].length = 3;
@@ -275,7 +275,7 @@
 				       struct urb *urb)
 {
 	unsigned char *cp = urb->transfer_buffer;
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
 	urb->iso_frame_desc[0].length = 4;
@@ -313,7 +313,7 @@
 			       struct urb *urb)
 {
 	int i, offs;
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	offs = 0;
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
@@ -402,7 +402,7 @@
 				     struct snd_pcm_runtime *runtime,
 				     struct urb *urb)
 {
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
 	urb->iso_frame_desc[0].length = 3;
@@ -420,7 +420,7 @@
 					struct snd_pcm_runtime *runtime,
 					struct urb *urb)
 {
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
 	urb->iso_frame_desc[0].length = 4;
@@ -537,7 +537,7 @@
 	unsigned int counts;
 	unsigned long flags;
 	int period_elapsed = 0;
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 
 	stride = runtime->frame_bits >> 3;
 
@@ -655,7 +655,7 @@
  */
 static void snd_complete_urb(struct urb *urb)
 {
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 	struct snd_usb_substream *subs = ctx->subs;
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
@@ -678,7 +678,7 @@
  */
 static void snd_complete_sync_urb(struct urb *urb)
 {
-	struct snd_urb_ctx *ctx = (struct snd_urb_ctx *)urb->context;
+	struct snd_urb_ctx *ctx = urb->context;
 	struct snd_usb_substream *subs = ctx->subs;
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
@@ -1408,7 +1408,7 @@
 static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_usb_substream *subs = (struct snd_usb_substream *)substream->runtime->private_data;
+	struct snd_usb_substream *subs = substream->runtime->private_data;
 	struct audioformat *fmt;
 	unsigned int channels, rate, format;
 	int ret, changed;
@@ -1464,7 +1464,7 @@
  */
 static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_usb_substream *subs = (struct snd_usb_substream *)substream->runtime->private_data;
+	struct snd_usb_substream *subs = substream->runtime->private_data;
 
 	subs->cur_audiofmt = NULL;
 	subs->cur_rate = 0;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
