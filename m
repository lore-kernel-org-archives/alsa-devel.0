From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: da732x: Mark DC offset control registers
	volatile
Date: Mon, 24 Feb 2014 12:00:53 +0900
Message-ID: <1393210853-32246-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D56D265268
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:34:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson@diasemi.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, stable@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The driver reads from the DC offset control registers during callibration
but since the registers are marked as volatile and there is a register
cache the values will not be read from the hardware after the first reading
rendering the callibration ineffective.

It appears that the driver was originally written for the ASoC level
register I/O code but converted to regmap prior to merge and this issue
was missed during the conversion as the framework level volatile register
functionality was not being used.

Signed-off-by: Mark Brown <broonie@linaro.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/da732x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 8e2c74d..798eb43 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1268,11 +1268,23 @@ static struct snd_soc_dai_driver da732x_dai[] = {
 	},
 };
 
+static bool da732x_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DA732X_REG_HPL_DAC_OFF_CNTL:
+	case DA732X_REG_HPR_DAC_OFF_CNTL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config da732x_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 
 	.max_register		= DA732X_MAX_REG,
+	.volatile_reg		= da732x_volatile,
 	.reg_defaults		= da732x_reg_cache,
 	.num_reg_defaults	= ARRAY_SIZE(da732x_reg_cache),
 	.cache_type		= REGCACHE_RBTREE,
-- 
1.9.0.rc3
