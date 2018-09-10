From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: clean up a return" to
	the asoc tree
Date: Mon, 10 Sep 2018 12:35:08 +0100 (BST)
Message-ID: <20180910113508.6D63B1122D51@debutante.sirena.org.uk>
References: <20180910084048.uhgbbsasp25czuud@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D8EA6267827
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 13:35:09 +0200 (CEST)
In-Reply-To: <20180910084048.uhgbbsasp25czuud@kili.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6asm-dai: clean up a return

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

>From 0712e0288b7602efbde95d95bca4c651ccad01b8 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 10 Sep 2018 11:40:48 +0300
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: clean up a return

Smatch complains that if both "psubstream" and "csubstream" are NULL
then "ret" is uninitialized.  That probably can't happen, but it's
cleaner to just return zero anyway so let's do that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9db9a2944ef2..c75fab38905d 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -493,7 +493,7 @@ static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
-- 
2.19.0.rc1
