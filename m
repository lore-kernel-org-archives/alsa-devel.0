From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: isabelle: using an uninitialized variable
Date: Thu, 7 Jun 2012 15:38:37 +0300
Message-ID: <20120607123837.GA7171@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 16A1A243E3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 14:38:53 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

We should set "isabelle_regmap" before using it.  GCC complains.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index bcc77ef..0d62f3b 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1126,8 +1126,6 @@ static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
 	struct regmap *isabelle_regmap;
 	int ret = 0;
 
-	i2c_set_clientdata(i2c, isabelle_regmap);
-
 	isabelle_regmap = devm_regmap_init_i2c(i2c, &isabelle_regmap_config);
 	if (IS_ERR(isabelle_regmap)) {
 		ret = PTR_ERR(isabelle_regmap);
@@ -1135,6 +1133,7 @@ static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
+	i2c_set_clientdata(i2c, isabelle_regmap);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 				&soc_codec_dev_isabelle, isabelle_dai,
