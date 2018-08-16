From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added speaker FS gain cotnrol
	register to volatile." to the asoc tree
Date: Thu, 16 Aug 2018 12:14:21 +0100 (BST)
Message-ID: <20180816111421.32926440078@finisterre.ee.mobilebroadband>
References: <20180816015338.3734-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FDEE2677BB
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2018 13:14:23 +0200 (CEST)
In-Reply-To: <20180816015338.3734-1-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added speaker FS gain cotnrol register to volatile.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0d22825255f25adb6a609f130b42c752d3fd0f5d Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Wed, 15 Aug 2018 18:53:38 -0700
Subject: [PATCH] ASoC: max98373: Added speaker FS gain cotnrol register to
 volatile.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 92b7125ea169..2764fae69333 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -520,6 +520,7 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
+	case MAX98373_R203E_AMP_PATH_GAIN:
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
-- 
2.18.0
