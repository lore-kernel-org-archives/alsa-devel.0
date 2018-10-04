From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: checking NULL vs
	IS_ERR()" to the asoc tree
Date: Thu,  4 Oct 2018 11:42:38 +0100 (BST)
Message-ID: <20181004104238.04D1E1121BA8@debutante.sirena.org.uk>
References: <20181001164430.GA29197@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA5D52678C3
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 12:42:39 +0200 (CEST)
In-Reply-To: <20181001164430.GA29197@mwanda>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6asm-dai: checking NULL vs IS_ERR()

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

>From 8e9f7265eda9f3a662ca1ca47a69042a7840735b Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 1 Oct 2018 19:44:30 +0300
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: checking NULL vs IS_ERR()

The q6asm_audio_client_alloc() doesn't return NULL, it returns error
pointers.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c3806d7037fc..a16c71c03058 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -318,10 +318,11 @@ static int q6asm_dai_open(struct snd_pcm_substream *substream)
 	prtd->audio_client = q6asm_audio_client_alloc(dev,
 				(q6asm_cb)event_handler, prtd, stream_id,
 				LEGACY_PCM_MODE);
-	if (!prtd->audio_client) {
+	if (IS_ERR(prtd->audio_client)) {
 		pr_info("%s: Could not allocate memory\n", __func__);
+		ret = PTR_ERR(prtd->audio_client);
 		kfree(prtd);
-		return -ENOMEM;
+		return ret;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-- 
2.19.0.rc2
