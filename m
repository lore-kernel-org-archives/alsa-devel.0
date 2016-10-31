From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lpass-cpu: add module licence and description" to the asoc tree
Date: Mon, 31 Oct 2016 12:30:50 -0600
Message-ID: <E1c1HMA-0002At-5t@finisterre>
References: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgkwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lpass-cpu: add module licence and description

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

>From 94201798dbce1cfd242407f1f422819a735c838f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 31 Oct 2016 11:25:45 +0000
Subject: [PATCH] ASoC: lpass-cpu: add module licence and description

This patch adds module licence to lpass-cpu driver, without this
patch lpass-cpu module would taint with below error:

snd_soc_lpass_cpu: module license 'unspecified' taints kernel.
Disabling lock debugging due to kernel taint
snd_soc_lpass_cpu: Unknown symbol regmap_write (err 0)
snd_soc_lpass_cpu: Unknown symbol devm_kmalloc (err 0)
...

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 3cde9fb977fa..eff3f9a8b685 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -586,3 +586,6 @@ int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_remove);
+
+MODULE_DESCRIPTION("QTi LPASS CPU Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.10.1
