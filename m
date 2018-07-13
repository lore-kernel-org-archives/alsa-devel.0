From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6routing: off by one in
	routing_hw_params()" to the asoc tree
Date: Fri, 13 Jul 2018 16:30:10 +0100 (BST)
Message-ID: <20180713153010.3EF2F440085@finisterre.ee.mobilebroadband>
References: <20180713151100.x5usbqhlhrzjmeoq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A130267730
 for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2018 00:44:28 +0200 (CEST)
In-Reply-To: <20180713151100.x5usbqhlhrzjmeoq@kili.mountain>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6routing: off by one in routing_hw_params()

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

>From 090345ce7265dd111299e3a63cdc79c3ef924481 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Jul 2018 18:11:04 +0300
Subject: [PATCH] ASoC: qdsp6: q6routing: off by one in routing_hw_params()

The data->port_data[] array has AFE_MAX_PORTS elements so the check
should be >= instead of > or we write one element beyond the end of the
array.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..7a19d6278406 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -899,7 +899,7 @@ static int routing_hw_params(struct snd_pcm_substream *substream,
 	else
 		path_type = ADM_PATH_LIVE_REC;
 
-	if (be_id > AFE_MAX_PORTS)
+	if (be_id >= AFE_MAX_PORTS)
 		return -EINVAL;
 
 	session = &data->port_data[be_id];
-- 
2.18.0
