From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Add missing regmap_init_i2c in
	wm8804_i2c_probe
Date: Tue, 06 Mar 2012 15:06:53 +0800
Message-ID: <1331017613.11182.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 27703103C68
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 08:07:04 +0100 (CET)
Received: by dakp5 with SMTP id p5so6566398dak.8
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 23:07:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

commit 891271c "ASoC: Convert wm8804 to direct regmap API usage"
only converts wm8804_spi_probe to use regmap_init_spi.

This patch adds missing regmap_init_i2c in wm8804_i2c_probe.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8804.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 7ee8dcf..6bd1b76 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -755,6 +755,12 @@ static __devinit int wm8804_i2c_probe(struct i2c_client *i2c,
 	if (!wm8804)
 		return -ENOMEM;
 
+	wm8804->regmap = regmap_init_i2c(i2c, &wm8804_regmap_config);
+	if (IS_ERR(wm8804->regmap)) {
+		ret = PTR_ERR(wm8804->regmap);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8804);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.5.4
