From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: qdafe: fix some off by one bugs"
	to the asoc tree
Date: Thu, 28 Jun 2018 11:20:35 +0100
Message-ID: <E1fYU2V-00048l-O0@debutante>
References: <20180627085653.v5bi34k2ozkvvrsr@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 142BB2676C7
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 12:20:48 +0200 (CEST)
In-Reply-To: <20180627085653.v5bi34k2ozkvvrsr@kili.mountain>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: qdafe: fix some off by one bugs

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

>From c54c1c5ee8e73b7cb752834e52e2129b1dab00bd Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 27 Jun 2018 11:56:53 +0300
Subject: [PATCH] ASoC: qdsp6: qdafe: fix some off by one bugs

The > should be >= or we could read one element beyond the end of the
port_maps[] array.

Fixes: 7fa2d70f9766 ("ASoC: qdsp6: q6afe: Add q6afe driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 621b67b34db9..671743453fbb 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -776,7 +776,7 @@ static int q6afe_callback(struct apr_device *adev, struct apr_resp_pkt *data)
  */
 int q6afe_get_port_id(int index)
 {
-	if (index < 0 || index > AFE_PORT_MAX)
+	if (index < 0 || index >= AFE_PORT_MAX)
 		return -EINVAL;
 
 	return port_maps[index].port_id;
@@ -1013,7 +1013,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 
 	port_id = port->id;
 	index = port->token;
-	if (index < 0 || index > AFE_PORT_MAX) {
+	if (index < 0 || index >= AFE_PORT_MAX) {
 		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
 		return -EINVAL;
 	}
@@ -1354,7 +1354,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	unsigned long flags;
 	int cfg_type;
 
-	if (id < 0 || id > AFE_PORT_MAX) {
+	if (id < 0 || id >= AFE_PORT_MAX) {
 		dev_err(dev, "AFE port token[%d] invalid!\n", id);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.18.0.rc2
