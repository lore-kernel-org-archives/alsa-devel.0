From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: [PATCH] Improve behaviour of Dreamcast aica ALSA
	driver in poor resource conditions
Date: Tue, 3 Jul 2007 22:36:40 +0100
Message-ID: <92a12cdb0707031436k74a10405p6d3a9976860074de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D4C32444E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 23:36:42 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2852801wag
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 14:36:41 -0700 (PDT)
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

This patch stops the driver from crashing in certain situations (eg if
the network fails when NFS mounted), please apply.

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

--- alsa-kernel/sh/aica.c	2007-06-23 15:25:55.000000000 +0100
+++ linux-2.6.21/sound/sh/aica.c	2007-07-03 22:28:16.000000000 +0100
@@ -366,7 +366,9 @@
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+	flush_workqueue(aica_queue);
 	del_timer(&dreamcastcard->timer);
+	aica_chn_halt();
 	kfree(dreamcastcard->channel);
 	spu_disable();
 	return 0;
@@ -402,16 +404,11 @@
 static int snd_aicapcm_pcm_trigger(struct snd_pcm_substream
 				   *substream, int cmd)
 {
-	struct snd_card_aica *dreamcastcard;
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		spu_begin_dma(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		dreamcastcard = substream->pcm->private_data;
-		if (dreamcastcard->timer.data)
-			del_timer(&dreamcastcard->timer);
-		aica_chn_halt();
 		break;
 	default:
 		return -EINVAL;
