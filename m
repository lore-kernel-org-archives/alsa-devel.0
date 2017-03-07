From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: Added */ to the next line" to
	the asoc tree
Date: Tue, 07 Mar 2017 14:33:16 +0100
Message-ID: <E1clFEq-0005Xb-Ed@finisterre>
References: <1488051202-8563-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CD9266FCD
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:34:21 +0100 (CET)
In-Reply-To: <1488051202-8563-1-git-send-email-codrut.cristian.grosu@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, Codrut GROSU <codrut.cristian.grosu@gmail.com>, broonie@kernel.org, colin.king@canonical.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: Added */ to the next line

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

>From 8fcf1e5eb460d8f032c699280f5a33fbf3716c29 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 21:33:22 +0200
Subject: [PATCH] ASoC: ux500: Added */ to the next line

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/ux500_msp_dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index b343efd9be5b..36e9bb2bd634 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -482,7 +482,8 @@ static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
 	if ((drvdata->fmt & SND_SOC_DAIFMT_MASTER_MASK) &&
 		(drvdata->msp->f_bitclk > 19200000)) {
 		/* If the bit-clock is higher than 19.2MHz, Vape should be
-		 * run in 100% OPP. Only when bit-clock is used (MSP master) */
+		 * run in 100% OPP. Only when bit-clock is used (MSP master)
+		 */
 		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP,
 					"ux500-msp-i2s", 100);
 		drvdata->vape_opp_constraint = 1;
-- 
2.11.0
