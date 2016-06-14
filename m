From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] sound: lpass-cpu: add module licence
	and description
Date: Tue, 14 Jun 2016 09:30:02 +0100
Message-ID: <1465893003-12477-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F94265ABD
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 10:30:06 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id v199so109912660wmv.0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 01:30:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds module licence to lpass-cpu driver, without this
patch lpass-cpu module would taint with below error:

snd_soc_lpass_cpu: module license 'unspecified' taints kernel.
Disabling lock debugging due to kernel taint
snd_soc_lpass_cpu: Unknown symbol regmap_write (err 0)
snd_soc_lpass_cpu: Unknown symbol devm_kmalloc (err 0)
...

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
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
