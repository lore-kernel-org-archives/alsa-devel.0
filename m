From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Don't specify LE device
	endianness" to the asoc tree
Date: Fri, 12 Feb 2016 20:11:53 +0000
Message-ID: <E1aUK4H-0003nd-3M@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A957E2605FF
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 21:12:04 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Don't specify LE device endianness

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

>From 8faa268ab780a7379cfe54b882c6f6e0083233f2 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 12 Feb 2016 09:30:17 -0800
Subject: [PATCH] ASoC: qcom: Don't specify LE device endianness

This reverts commit 18560a4e3 (ASoC: qcom: Specify LE device
endianness).

The commit that caused us to specify LE device endianness here,
29bb45f25ff3 (regmap-mmio: Use native endianness for read/write,
2015-10-29), has been reverted in mainline so now when we specify
LE it actively breaks big endian kernels because the byte
swapping in regmap-mmio is incorrect. Let's revert this change
because it will 1) fix the big endian kernels and 2) be redundant
to specify LE because that will become the default soon.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 00b6c9d039cf..e5101e0d2d37 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -355,7 +355,6 @@ static struct regmap_config lpass_cpu_regmap_config = {
 	.readable_reg = lpass_cpu_regmap_readable,
 	.volatile_reg = lpass_cpu_regmap_volatile,
 	.cache_type = REGCACHE_FLAT,
-	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
-- 
2.7.0
