From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-digital: Select REGMAP_MMIO
	to fix build error" to the asoc tree
Date: Mon, 14 Jan 2019 23:03:56 +0000 (GMT)
Message-ID: <20190114230356.A8C1A1127AD2@debutante.sirena.org.uk>
References: <20190111102040.11596-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB932670AC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 00:03:58 +0100 (CET)
In-Reply-To: <20190111102040.11596-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-digital: Select REGMAP_MMIO to fix build error

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

>From 5b86fa6d2903c41c3c3dbff4def76a5b8bbe0660 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 11 Jan 2019 18:20:40 +0800
Subject: [PATCH] ASoC: msm8916-wcd-digital: Select REGMAP_MMIO to fix build
 error

Fix below build error:
ERROR: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-msm8916-digital.ko] undefined!

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 87ecb38e57f4..71e6e123a115 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -706,6 +706,7 @@ config SND_SOC_MSM8916_WCD_ANALOG
 
 config SND_SOC_MSM8916_WCD_DIGITAL
 	tristate "Qualcomm MSM8916 WCD DIGITAL Codec"
+	select REGMAP_MMIO
 
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
-- 
2.20.1
