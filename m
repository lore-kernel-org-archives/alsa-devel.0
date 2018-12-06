From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2] ASoC: max9867: Remove useless assignment
Date: Thu, 6 Dec 2018 23:24:22 +0100
Message-ID: <20181206222422.GA29787@lenoch>
References: <20181207080122.20d3d342@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207080122.20d3d342@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ret is assigned later, no need to initialize it.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 CHANGES:
 -v2: add missing Signed-off-by
 (I'm sorry for that...)

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
2.20.0.rc2
