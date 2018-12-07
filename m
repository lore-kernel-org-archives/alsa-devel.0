From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Remove useless assignment" to
	the asoc tree
Date: Fri,  7 Dec 2018 12:23:25 +0000 (GMT)
Message-ID: <20181207122325.CC37111253E4@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 65197267D18
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 13:23:26 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Remove useless assignment

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

>From 8efc1afd7e0570d9bb37f5127f0742304a8ad2fc Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 4 Dec 2018 19:18:17 +0100
Subject: [PATCH] ASoC: max9867: Remove useless assignment

ret is assigned later, no need to initialize it.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 1cda54b59854..1b155f40b106 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -476,7 +476,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
 	struct max9867_priv *max9867;
-	int ret = 0, reg;
+	int ret, reg;
 
 	max9867 = devm_kzalloc(&i2c->dev, sizeof(*max9867), GFP_KERNEL);
 	if (!max9867)
@@ -497,10 +497,8 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
 	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
 			max9867_dai, ARRAY_SIZE(max9867_dai));
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
-		return ret;
-	}
 	return ret;
 }
 
-- 
2.19.0.rc2
