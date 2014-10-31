From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: CS42L51_I2C depends on I2C
Date: Fri, 31 Oct 2014 10:54:23 -0700
Message-ID: <5453CCCF.5090201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 256842606D9
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:54:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_I2C is not enabled by making the
driver depend on I2C.

../sound/soc/codecs/cs42l51-i2c.c:55:1: warning: data definition has no type or storage class [enabled by default]
 module_i2c_driver(cs42l51_i2c_driver);
 ^
../sound/soc/codecs/cs42l51-i2c.c:55:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
../sound/soc/codecs/cs42l51-i2c.c:55:1: warning: parameter names (without types) in function declaration [enabled by default]
../sound/soc/codecs/cs42l51-i2c.c:45:26: warning: 'cs42l51_i2c_driver' defined but not used [-Wunused-variable]
 static struct i2c_driver cs42l51_i2c_driver = {
                          ^
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 sound/soc/codecs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20141031.orig/sound/soc/codecs/Kconfig
+++ linux-next-20141031/sound/soc/codecs/Kconfig
@@ -338,6 +338,7 @@ config SND_SOC_CS42L51
 
 config SND_SOC_CS42L51_I2C
 	tristate "Cirrus Logic CS42L51 CODEC (I2C)"
+	depends on I2C
 	select SND_SOC_CS42L51
 
 config SND_SOC_CS42L52
