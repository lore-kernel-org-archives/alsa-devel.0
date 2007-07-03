From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: [PATCH] Improve behaviour of Dreamcast aica ALSA
	driver in poor resource conditions
Date: Wed, 4 Jul 2007 00:08:46 +0100
Message-ID: <92a12cdb0707031608w532beb46yac48ad43a766698d@mail.gmail.com>
References: <92a12cdb0707031436k74a10405p6d3a9976860074de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 055CD103879
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 01:08:51 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2897283wag
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 16:08:49 -0700 (PDT)
In-Reply-To: <92a12cdb0707031436k74a10405p6d3a9976860074de@mail.gmail.com>
Content-Disposition: inline
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
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/07/07, Adrian McMenamin <adrianmcmenamin@gmail.com> wrote:
> This patch stops the driver from crashing in certain situations (eg if
> the network fails when NFS mounted), please apply.
>

Actually, looked at this again and while the previous patch stopped
the driver from crashing it still locked the sound subsystem. This was
because INIT_WORK was being called on the same work_struct when the
device recovered from the network failure. The patch below ensures
that this does not happen and that instead, PREPARE_WORK is called.

Submitted by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

--- alsa-kernel/sh/aica.c	2007-06-23 15:25:55.000000000 +0100
+++ linux-2.6.21/sound/sh/aica.c	2007-07-04 00:01:23.000000000 +0100
@@ -68,6 +68,7 @@
 static struct spu_work_holder {
 	struct work_struct spu_dma_work;
 	void *sspointer;
+	int already_started;
 } spu_working;

 static struct workqueue_struct *aica_queue;
@@ -319,7 +320,13 @@
 	dreamcastcard = substream->pcm->private_data;
 	/*  Use queue to do the heavy lifting */
 	spu_working.sspointer = substream;
-	INIT_WORK(&(spu_working.spu_dma_work), run_spu_dma);
+	if (spu_working.already_started == 1) {
+		PREPARE_WORK(&(spu_working.spu_dma_work), run_spu_dma);
+	}
+	else {
+		INIT_WORK(&(spu_working.spu_dma_work), run_spu_dma);
+		spu_working.already_started = 1;
+	}
 	queue_work(aica_queue, &(spu_working.spu_dma_work));
 	/* Timer may already be running */
 	if (unlikely(dreamcastcard->timer.data)) {
@@ -366,7 +373,9 @@
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+	flush_workqueue(aica_queue);
 	del_timer(&dreamcastcard->timer);
+	aica_chn_halt();
 	kfree(dreamcastcard->channel);
 	spu_disable();
 	return 0;
@@ -402,17 +411,10 @@
 static int snd_aicapcm_pcm_trigger(struct snd_pcm_substream
 				   *substream, int cmd)
 {
-	struct snd_card_aica *dreamcastcard;
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		spu_begin_dma(substream);
 		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		dreamcastcard = substream->pcm->private_data;
-		if (dreamcastcard->timer.data)
-			del_timer(&dreamcastcard->timer);
-		aica_chn_halt();
-		break;
 	default:
 		return -EINVAL;
 	}
