From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: qcom: Constify
	asoc_qcom_lpass_cpu_dai_ops
Date: Fri, 28 Aug 2015 10:53:31 +0800
Message-ID: <1440730411.11149.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 29974260469
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 04:53:39 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so46060841pac.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 19:53:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

asoc_qcom_lpass_cpu_dai_ops is exported and used by multiple drivers,
make it const to prevent modifying it at run time.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/qcom/lpass-cpu.c | 2 +-
 sound/soc/qcom/lpass.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 23f3d59..97bc202 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -235,7 +235,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
+const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
 	.set_sysclk	= lpass_cpu_daiops_set_sysclk,
 	.startup	= lpass_cpu_daiops_startup,
 	.shutdown	= lpass_cpu_daiops_shutdown,
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index d6e86c1..0b63e2e 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -93,6 +93,6 @@ int asoc_qcom_lpass_platform_register(struct platform_device *);
 int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai);
-extern struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
+extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
 
 #endif /* __LPASS_H__ */
-- 
2.1.0
