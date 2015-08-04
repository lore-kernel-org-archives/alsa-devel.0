From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_ssc_dai: Correct misuse of
	0x%<decimal>" to the asoc tree
Date: Tue, 04 Aug 2015 18:47:58 +0100
Message-ID: <E1ZMgJi-0007qw-N0@finisterre>
References: <1438624169.16753.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C75260656
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:48:07 +0200 (CEST)
In-Reply-To: <1438624169.16753.5.camel@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_ssc_dai: Correct misuse of 0x%<decimal>

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 56113f6e6f8d57d3c184544c6421422558a9988e Mon Sep 17 00:00:00 2001
From: Joe Perches <joe@perches.com>
Date: Mon, 3 Aug 2015 10:49:29 -0700
Subject: [PATCH] ASoC: atmel_ssc_dai: Correct misuse of 0x%<decimal>

Correct misuse of 0x%d in logging message.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..ba8def5 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -290,7 +290,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	int dir, dir_mask;
 	int ret;
 
-	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+	pr_debug("atmel_ssc_startup: SSC_SR=0x%x\n",
 		ssc_readl(ssc_p->ssc->regs, SR));
 
 	/* Enable PMC peripheral clock for this SSC */
-- 
2.1.4
