From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: Off by one in
	of_q6asm_parse_dai_data()" to the asoc tree
Date: Fri, 21 Dec 2018 13:42:29 +0000 (GMT)
Message-ID: <20181221134229.B95561121B93@debutante.sirena.org.uk>
References: <20181221090442.GA2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2E5267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:42:30 +0100 (CET)
In-Reply-To: <20181221090442.GA2735@kadam>
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

   ASoC: qdsp6: q6asm-dai: Off by one in of_q6asm_parse_dai_data()

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

>From 6f10aff97f5d2c9a26a4deff1482f845841b7307 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Dec 2018 12:04:42 +0300
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: Off by one in
 of_q6asm_parse_dai_data()

The q6asm_fe_dais[] array has MAX_SESSIONS (8) elements so the >
comparison should be >= or we access one element beyond the end of the
array.

Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 5b986b74dd36..9d738b4c1e05 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -874,7 +874,7 @@ static int of_q6asm_parse_dai_data(struct device *dev,
 
 	for_each_child_of_node(dev->of_node, node) {
 		ret = of_property_read_u32(node, "reg", &id);
-		if (ret || id > MAX_SESSIONS || id < 0) {
+		if (ret || id >= MAX_SESSIONS || id < 0) {
 			dev_err(dev, "valid dai id not found:%d\n", ret);
 			continue;
 		}
-- 
2.20.1
