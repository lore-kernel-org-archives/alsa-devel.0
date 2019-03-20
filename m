From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 10/12] ASoC: tlv320aic32x4: Remove mclk
	references
Date: Tue, 19 Mar 2019 21:51:27 -0700
Message-ID: <20190320045129.6859-11-nh6z@nh6z.net>
References: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82FFBF89715
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 05:51:55 +0100 (CET)
In-Reply-To: <20190320045129.6859-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

mclk is not used by anything anymore.  Remove support for it.
All that information now comes from the clock tree.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 00822749cb8b..e8a9fb9d5e25 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -53,7 +53,6 @@ struct aic32x4_priv {
 	u32 micpga_routing;
 	bool swapdacs;
 	int rstn_gpio;
-	struct clk *mclk;
 	const char *mclk_name;
 
 	struct regulator *supply_ldo;
@@ -1175,12 +1174,6 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		aic32x4->mclk_name = "mclk";
 	}
 
-	aic32x4->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(aic32x4->mclk)) {
-		dev_err(dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
-		return PTR_ERR(aic32x4->mclk);
-	}
-
 	ret = aic32x4_register_clocks(dev, aic32x4->mclk_name);
 	if (ret)
 		return ret;
-- 
2.19.1
