From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/5] ASoC: max9867: Remove useless assignment
Date: Tue, 4 Dec 2018 19:18:17 +0100
Message-ID: <20181204181817.GB1136@lenoch>
References: <20181204181725.GA1136@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id DCBC6267B4E
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 19:18:18 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990411AbeLDSSSlN86p (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Tue, 4 Dec 2018 19:18:18 +0100
Content-Disposition: inline
In-Reply-To: <20181204181725.GA1136@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

ret is assigned later, no need to initialize it.
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
2.20.0.rc2
