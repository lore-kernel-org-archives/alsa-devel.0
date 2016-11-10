From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic31xx: Add missing
	of_device_id for dac3100
Date: Thu, 10 Nov 2016 09:55:54 +0200
Message-ID: <20161110075555.7878-2-peter.ujfalusi@ti.com>
References: <20161110075555.7878-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id E31972666FB
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 08:55:52 +0100 (CET)
In-Reply-To: <20161110075555.7878-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The compatible table was not updated when the support for DAC3100 was added.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index be1a64bfd320..8880f6be3336 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1253,6 +1253,7 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
 	{ .compatible = "ti,tlv320aic3110" },
 	{ .compatible = "ti,tlv320aic3120" },
 	{ .compatible = "ti,tlv320aic3111" },
+	{ .compatible = "ti,tlv320dac3100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic31xx_of_match);
-- 
2.10.2
