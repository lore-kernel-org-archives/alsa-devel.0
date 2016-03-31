From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Fix uninitialized symbol
	warning." to the asoc tree
Date: Thu, 31 Mar 2016 11:45:10 -0700
Message-ID: <E1alhag-0005Jf-Gi@finisterre>
References: <1459448595-18620-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF2052666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:45:22 +0200 (CEST)
In-Reply-To: <1459448595-18620-2-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Fix uninitialized symbol warning.

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

>From ea4d25d5a3709cba0d3df2195edffc400170394f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 31 Mar 2016 19:23:14 +0100
Subject: [PATCH] ASoC: qcom: Fix uninitialized symbol warning.

This patch fixes following static checker warning, by initializing the
ret to -EINVAL, as one of the code path in lpass_platform_pcm_new()
uses this variable uninitialized.

sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
error: uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 6e8665430bd5..f5cae01d18bd 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -474,7 +474,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret;
+	int ret = -EINVAL;
 	struct lpass_pcm_data *data;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
-- 
2.8.0.rc3
