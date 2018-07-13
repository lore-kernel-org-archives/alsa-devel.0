From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6afe-dai: fix a range check in
	of_q6afe_parse_dai_data()" to the asoc tree
Date: Fri, 13 Jul 2018 16:30:13 +0100 (BST)
Message-ID: <20180713153013.31DC8440088@finisterre.ee.mobilebroadband>
References: <20180713150557.gsx7wrau2l7tg2jq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AFD267730
 for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2018 00:44:28 +0200 (CEST)
In-Reply-To: <20180713150557.gsx7wrau2l7tg2jq@kili.mountain>
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

   ASoC: qdsp6: q6afe-dai: fix a range check in of_q6afe_parse_dai_data()

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

>From b8110a87b75f948d978c06e130cc68026645c4a1 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Jul 2018 18:05:57 +0300
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: fix a range check in
 of_q6afe_parse_dai_data()

The main thing is that the data->priv[] array has AFE_PORT_MAX elements
so the > condition should be >=.  But we may as well check for negative
values as well just to be safe.

Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index a373ca5523ff..9ba95956ada8 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1183,7 +1183,7 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 		int id, i, num_lines;
 
 		ret = of_property_read_u32(node, "reg", &id);
-		if (ret || id > AFE_PORT_MAX) {
+		if (ret || id < 0 || id >= AFE_PORT_MAX) {
 			dev_err(dev, "valid dai id not found:%d\n", ret);
 			continue;
 		}
-- 
2.18.0
