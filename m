From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320aic31xx: Add text in Kconfig
	so the codec can be used with simple-card
Date: Fri, 25 Jul 2014 15:07:48 +0300
Message-ID: <1406290068-11117-2-git-send-email-peter.ujfalusi@ti.com>
References: <1406290068-11117-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D86B82616F3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 14:07:54 +0200 (CEST)
In-Reply-To: <1406290068-11117-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In order to show the option under 'CODEC drivers' we need to have text in
Kconfig.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9fb6fb210251..8838838e25ed 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -564,7 +564,7 @@ config SND_SOC_TLV320AIC26
 	depends on SPI
 
 config SND_SOC_TLV320AIC31XX
-        tristate
+	tristate "Texas Instruments TLV320AIC31xx CODECs"
 	depends on I2C
 	select REGMAP_I2C
 
-- 
2.0.2
