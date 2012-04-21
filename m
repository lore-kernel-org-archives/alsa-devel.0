From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: remove refactorization
	left-overs
Date: Sat, 21 Apr 2012 13:52:12 +0200
Message-ID: <1335009132-17346-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id C69BC24904
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 13:52:47 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Drop some struct members and definitions that became obsolete during
the refactorization of the driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.h |   13 -------------
 sound/usb/proc.c |    6 +-----
 2 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 77d2eec..0d37238 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -43,13 +43,6 @@ struct snd_urb_ctx {
 	struct list_head ready_list;
 };
 
-struct snd_urb_ops {
-	int (*prepare)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
-	int (*retire)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
-	int (*prepare_sync)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
-	int (*retire_sync)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
-};
-
 struct snd_usb_endpoint {
 	struct snd_usb_audio *chip;
 
@@ -125,11 +118,6 @@ struct snd_usb_substream {
 	unsigned long active_mask;	/* bitmask of active urbs */
 	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
 
-	unsigned int nurbs;			/* # urbs */
-	struct snd_urb_ctx dataurb[MAX_URBS];	/* data urb table */
-	struct snd_urb_ctx syncurb[SYNC_URBS];	/* sync urb table */
-	char *syncbuf;				/* sync buffer for all sync URBs */
-	dma_addr_t sync_dma;			/* DMA address of syncbuf */
 	/* data and sync endpoints for this stream */
 	struct snd_usb_endpoint *data_endpoint;
 	struct snd_usb_endpoint *sync_endpoint;
@@ -141,7 +129,6 @@ struct snd_usb_substream {
 	struct snd_pcm_hw_constraint_list rate_list;	/* limited rates */
 	spinlock_t lock;
 
-	struct snd_urb_ops ops;		/* callbacks (must be filled at init) */
 	int last_frame_number;          /* stored frame number */
 	int last_delay;                 /* stored delay */
 };
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 06e23d8..ebc1a5b 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -25,6 +25,7 @@
 #include "usbaudio.h"
 #include "helper.h"
 #include "card.h"
+#include "endpoint.h"
 #include "proc.h"
 
 /* convert our full speed USB rate into sampling rate in Hz */
@@ -137,14 +138,9 @@ static void proc_dump_ep_status(struct snd_usb_substream *subs,
 static void proc_dump_substream_status(struct snd_usb_substream *subs, struct snd_info_buffer *buffer)
 {
 	if (subs->running) {
-		unsigned int i;
 		snd_iprintf(buffer, "  Status: Running\n");
 		snd_iprintf(buffer, "    Interface = %d\n", subs->interface);
 		snd_iprintf(buffer, "    Altset = %d\n", subs->altset_idx);
-		snd_iprintf(buffer, "    URBs = %d [ ", subs->nurbs);
-		for (i = 0; i < subs->nurbs; i++)
-			snd_iprintf(buffer, "%d ", subs->dataurb[i].packets);
-		snd_iprintf(buffer, "]\n");
 		proc_dump_ep_status(subs, subs->data_endpoint, buffer);
 		proc_dump_ep_status(subs, subs->sync_endpoint, buffer);
 	} else {
-- 
1.7.5.4
