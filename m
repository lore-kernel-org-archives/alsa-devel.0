From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v3 1/2] ASoC: twl6040: Set default gains to
	minimun value
Date: Tue, 14 Dec 2010 19:18:36 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4EDD708@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 74D2C24475
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 02:18:41 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Updated default values to improve power consumption.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9dfe208..b252cf8 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -806,6 +806,15 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 
 		/* initialize vdd/vss registers with reg_cache */
 		twl6040_init_vdd_regs(codec);
+
+		/* Set external boost GPO */
+		twl6040_write(codec, TWL6040_REG_GPOCTL, 0x02);
+
+		/* Set initial minimal gain values */
+		twl6040_write(codec, TWL6040_REG_HSGAIN, 0xFF);
+		twl6040_write(codec, TWL6040_REG_EARCTL, 0x1E);
+		twl6040_write(codec, TWL6040_REG_HFLGAIN, 0x1D);
+		twl6040_write(codec, TWL6040_REG_HFRGAIN, 0x1D);
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (!priv->codec_powered)
-- 
1.7.0.4
