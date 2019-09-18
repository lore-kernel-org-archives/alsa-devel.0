Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F4C4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:04:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D8A214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mxG5BqVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F257166E;
	Wed, 18 Sep 2019 12:04:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F257166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568801093;
	bh=GSUnQtwtd2WBL1O3vocOcfRSm75gvuLSuv0CTq4nTtc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mxG5BqVyN96Uvsgmmi5hM1FzoBl3fKmSBMcik9T7XJWPv1effdAhzybplx2qBDtf3
	 y1dgrW95wSaC2O78Mn//aNGhb2U13h4Pcx2+2ALWtMkTMqjQHg2fPa4Jme6Bpdki+w
	 RYS2BXDVBBU+I4rRF4TcPBx6dIgMnofBx3JwkZe8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6B4AF804FF;
	Wed, 18 Sep 2019 12:04:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08F99F80527; Wed, 18 Sep 2019 12:04:02 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BA8FF80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 12:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BA8FF80146
X-Originating-IP: 86.207.98.53
Received: from localhost
 (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A3AE6FF811;
 Wed, 18 Sep 2019 10:03:54 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Sep 2019 12:03:44 +0200
Message-Id: <20190918100344.23629-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [alsa-devel] [PATCH v2] ASoC: atmel_ssc_dai: Remove wrong spinlock
	usage
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

A potential bug was reported in the email "[BUG] atmel_ssc_dai: a
possible sleep-in-atomic bug in atmel_ssc_shutdown"[1]

Indeed in the function atmel_ssc_shutdown() free_irq() was called in a
critical section protected by spinlock.

However this spinlock is only used in atmel_ssc_shutdown() and
atmel_ssc_startup() functions. After further analysis, it occurred that
the call to these function are already protected by mutex used on the
calling functions.

Then we can remove the spinlock which will fix this bug as a side
effect. Thanks to this patch the following message disappears:

"BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:909"

[1]: https://www.spinics.net/lists/alsa-devel/msg71286.html

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---

Changelog:

v1 -> v2:

   - Removed the spinlock from the atmel_ssc_info struct
   - Added the Reviewed-by flag form Alex

 sound/soc/atmel/atmel_ssc_dai.c | 12 ++----------
 sound/soc/atmel/atmel_ssc_dai.h |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 6f89483ac88c..786b48ae4905 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -116,19 +116,16 @@ static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
 static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
 	{
 	.name		= "ssc0",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
 	},
 	{
 	.name		= "ssc1",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
 	},
 	{
 	.name		= "ssc2",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
 	},
@@ -317,13 +314,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, dma_params);
 
-	spin_lock_irq(&ssc_p->lock);
-	if (ssc_p->dir_mask & dir_mask) {
-		spin_unlock_irq(&ssc_p->lock);
+	if (ssc_p->dir_mask & dir_mask)
 		return -EBUSY;
-	}
+
 	ssc_p->dir_mask |= dir_mask;
-	spin_unlock_irq(&ssc_p->lock);
 
 	return 0;
 }
@@ -355,7 +349,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 
 	dir_mask = 1 << dir;
 
-	spin_lock_irq(&ssc_p->lock);
 	ssc_p->dir_mask &= ~dir_mask;
 	if (!ssc_p->dir_mask) {
 		if (ssc_p->initialized) {
@@ -369,7 +362,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
 		ssc_p->forced_divider = 0;
 	}
-	spin_unlock_irq(&ssc_p->lock);
 
 	/* Shutdown the SSC clock. */
 	pr_debug("atmel_ssc_dai: Stopping clock\n");
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index ae764cb541c7..3470b966e449 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -93,7 +93,6 @@ struct atmel_ssc_state {
 struct atmel_ssc_info {
 	char *name;
 	struct ssc_device *ssc;
-	spinlock_t lock;	/* lock for dir_mask */
 	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
 	unsigned short initialized;	/* true if SSC has been initialized */
 	unsigned short daifmt;
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
