From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: avoid nested code on
	soc_remove_dai()" to the asoc tree
Date: Tue, 11 Sep 2018 19:22:14 +0100 (BST)
Message-ID: <20180911182214.D4B3A1121B1F@debutante.sirena.org.uk>
References: <87y3c84jka.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFEC26787A
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 20:22:15 +0200 (CEST)
In-Reply-To: <87y3c84jka.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: avoid nested code on soc_remove_dai()

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

>From 2eda3cb108b699a6ff78a87e25143c153bc88e41 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 06:54:26 +0000
Subject: [PATCH] ASoC: soc-core: avoid nested code on soc_remove_dai()

Nested code is not readable.
This patch avoid it on soc_remove_dai().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4e9367aacc0c..dde9b70b58b5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -942,17 +942,18 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (dai && dai->probed &&
-			dai->driver->remove_order == order) {
-		if (dai->driver->remove) {
-			err = dai->driver->remove(dai);
-			if (err < 0)
-				dev_err(dai->dev,
-					"ASoC: failed to remove %s: %d\n",
-					dai->name, err);
-		}
-		dai->probed = 0;
+	if (!dai || !dai->probed ||
+	    dai->driver->remove_order != order)
+		return;
+
+	if (dai->driver->remove) {
+		err = dai->driver->remove(dai);
+		if (err < 0)
+			dev_err(dai->dev,
+				"ASoC: failed to remove %s: %d\n",
+				dai->name, err);
 	}
+	dai->probed = 0;
 }
 
 static void soc_remove_link_dais(struct snd_soc_card *card,
-- 
2.19.0.rc2
