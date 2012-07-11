From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: STA529: fix an error message
Date: Wed, 11 Jul 2012 09:41:23 +0300
Message-ID: <20120711064123.GI11812@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id D17A62414A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2012 08:41:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

GCC complains that "ret" is uninitialized here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index a9f34c7..0c225cd 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -397,8 +397,9 @@ static __devinit int sta529_i2c_probe(struct i2c_client *i2c,
 
 	sta529->regmap = devm_regmap_init_i2c(i2c, &sta529_regmap);
 	if (IS_ERR(sta529->regmap)) {
+		ret = PTR_ERR(sta529->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
-		return PTR_ERR(sta529->regmap);
+		return ret;
 	}
 
 	i2c_set_clientdata(i2c, sta529);
