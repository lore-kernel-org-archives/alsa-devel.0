From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6routing: support dt based module loading" to the asoc tree
Date: Tue, 26 Jun 2018 16:11:00 +0100 (BST)
Message-ID: <20180626151100.1963E440070@finisterre.ee.mobilebroadband>
References: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com, linux-arm-kernel@lists.infradead.orgniklas.cassel@linaro.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6routing: support dt based module loading

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

>From f48bde4bfbcf434d6aef604c1c50d68b12a4bc45 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:13 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: support dt based module loading

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..ab696bf8d1d3 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6pcm_routing_device_id[] = {
+	{ .compatible = "qcom,q6adm-routing" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
+
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
 		.name = "q6routing",
+		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
 	},
 	.probe = q6pcm_routing_probe,
 	.remove = q6pcm_routing_remove,
-- 
2.17.1
