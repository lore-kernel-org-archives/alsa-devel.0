From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Constify
	asoc_qcom_lpass_cpu_dai_ops" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:20 +0100
Message-ID: <E1ZVNhM-00079K-Vf@finisterre>
References: <1440730411.11149.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ADCB2660EF
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:17 +0200 (CEST)
In-Reply-To: <1440730411.11149.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Constify asoc_qcom_lpass_cpu_dai_ops

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

>From 618718dc56a49321a12f231b34f6c43f44c3c374 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 28 Aug 2015 10:53:31 +0800
Subject: [PATCH] ASoC: qcom: Constify asoc_qcom_lpass_cpu_dai_ops

asoc_qcom_lpass_cpu_dai_ops is exported and used by multiple drivers,
make it const to prevent modifying it at run time.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.5.0
