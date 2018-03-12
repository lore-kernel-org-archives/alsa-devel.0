From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: twl6040: Add back missing write
	callback
Date: Mon, 12 Mar 2018 16:24:22 +0200
Message-ID: <20180312142423.13177-2-peter.ujfalusi@ti.com>
References: <20180312142423.13177-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C5B266E63
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 15:24:25 +0100 (CET)
In-Reply-To: <20180312142423.13177-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

We need to have the write callback to use the code.

Fixes: 7480389fb0d8 ("ASoC: twl6040: replace codec to component")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9bf23f8e7162..b56a6471f9c4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1157,6 +1157,7 @@ static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
 	.probe			= twl6040_probe,
 	.remove			= twl6040_remove,
 	.read			= twl6040_read,
+	.write			= twl6040_write,
 	.remove			= twl6040_remove,
 	.set_bias_level		= twl6040_set_bias_level,
 	.controls		= twl6040_snd_controls,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
