From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 1/2] sound: lpass-cpu: add module licence and description
Date: Mon, 13 Jun 2016 14:23:16 +0100
Message-ID: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Patrick Lai <plai@codeaurora.org>, kwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds module licence to lpass-cpu driver, without this
patch lpass-cpu module would taint with below error, while insmod/modprobe.

snd_soc_lpass_cpu: module license 'unspecified' taints kernel.
Disabling lock debugging due to kernel taint
snd_soc_lpass_cpu: Unknown symbol regmap_write (err 0)
snd_soc_lpass_cpu: Unknown symbol devm_kmalloc (err 0)
...

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 3cde9fb..eff3f9a 100644
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
2.8.3
