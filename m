From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Specify LE device endianness" to
	the asoc tree
Date: Sat, 21 Nov 2015 14:02:00 +0000
Message-ID: <E1a08jo-0001DH-Nc@finisterre>
References: <1448062986-19535-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 393B126150C
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:03:33 +0100 (CET)
In-Reply-To: <1448062986-19535-1-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kenneth Westfield <kwestfie@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tyler Baker <tyler.baker@linaro.org>, Simon Arlott <simon@fire.lp0.eu>, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Specify LE device endianness

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

>From 18560a4e3b07438113b50589e78532d95f907029 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 20 Nov 2015 15:43:06 -0800
Subject: [PATCH] ASoC: qcom: Specify LE device endianness

This is a little endian device, but so far we've been relying on
the regmap mmio bus handling this for us without explicitly
stating that fact. After commit 4a98da2164cf (regmap-mmio: Use
native endianness for read/write, 2015-10-29), the regmap mmio
bus will read/write with the __raw_*() IO accessors, instead of
using the readl/writel() APIs that do proper byte swapping for
little endian devices.

So if we're running on a big endian processor and haven't
specified the endianness explicitly in the regmap config or in
DT, we're going to switch from doing little endian byte swapping
to big endian accesses without byte swapping, leading to some
confusing results. Specify the endianness explicitly so that the
regmap core properly byte swaps the accesses for us.

Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Tyler Baker <tyler.baker@linaro.org>
Cc: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index e5101e0..00b6c9d 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -355,6 +355,7 @@ static struct regmap_config lpass_cpu_regmap_config = {
 	.readable_reg = lpass_cpu_regmap_readable,
 	.volatile_reg = lpass_cpu_regmap_volatile,
 	.cache_type = REGCACHE_FLAT,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
-- 
2.6.1
