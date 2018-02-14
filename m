From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: soc_probe_dai() code
	simplification" to the asoc tree
Date: Wed, 14 Feb 2018 13:29:29 +0000
Message-ID: <E1elx7p-00074W-32@debutante>
References: <87sha4b7ow.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E27267B15
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:29:31 +0100 (CET)
In-Reply-To: <87sha4b7ow.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: soc_probe_dai() code simplification

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

>From 7a2ccad58106696b7909815cc7ab359ae2743bcc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Feb 2018 02:58:03 +0000
Subject: [PATCH] ASoC: soc-core: soc_probe_dai() code simplification

Current soc_probe_dai() is using deep nested condition.
Thus, it is difficult to read/understand.
This patch simplification it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 60a542f35dbd..574048a73b1c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1624,22 +1624,21 @@ static int soc_probe_link_components(struct snd_soc_card *card,
 
 static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 {
-	int ret;
+	if (dai->probed ||
+	    dai->driver->probe_order != order)
+		return 0;
 
-	if (!dai->probed && dai->driver->probe_order == order) {
-		if (dai->driver->probe) {
-			ret = dai->driver->probe(dai);
-			if (ret < 0) {
-				dev_err(dai->dev,
-					"ASoC: failed to probe DAI %s: %d\n",
-					dai->name, ret);
-				return ret;
-			}
+	if (dai->driver->probe) {
+		int ret = dai->driver->probe(dai);
+		if (ret < 0) {
+			dev_err(dai->dev, "ASoC: failed to probe DAI %s: %d\n",
+				dai->name, ret);
+			return ret;
 		}
-
-		dai->probed = 1;
 	}
 
+	dai->probed = 1;
+
 	return 0;
 }
 
-- 
2.16.1
