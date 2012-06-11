From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: wm8996: Move reset before the
	initial regulator disable
Date: Mon, 11 Jun 2012 19:55:35 +0800
Message-ID: <1339415740-2376-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 29CE42435E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:05 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we don't have control over the LDO but do have control over the other
regulators then we may end up trying to write to a powered off device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e0bbe646..f1bf664 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3027,14 +3027,14 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 	dev_info(&i2c->dev, "revision %c\n",
 		 (reg & WM8996_CHIP_REV_MASK) + 'A');
 
-	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-
 	ret = wm8996_reset(wm8996);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to issue reset\n");
 		goto err_regmap;
 	}
 
+	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
+
 	wm8996_init_gpio(wm8996);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10
