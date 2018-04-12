From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: dmic: Fix clock parenting
Date: Thu, 12 Apr 2018 11:23:15 +0300
Message-ID: <20180412082315.17302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 1378D266FD1
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 10:22:57 +0200 (CEST)
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
Cc: t-kristo@ti.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Tero Kristo <t-kristo@ti.com>

In 4.16 the clock hierarchy got changed by
a5c82a09d876 ARM: dts: omap4: add clkctrl nodes

The fck of dmic is no longer a mux clock, it's parent is.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org # 4.16+
---
Mark,

can you apply this for 4.17 as DMIC got broken already in 4.16.

Regards,
Peter

 sound/soc/omap/omap-dmic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index c7101d851213..51dd7c65096b 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -281,7 +281,7 @@ static int omap_dmic_dai_trigger(struct snd_pcm_substream *substream,
 static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 				 unsigned int freq)
 {
-	struct clk *parent_clk;
+	struct clk *parent_clk, *mux;
 	char *parent_clk_name;
 	int ret = 0;
 
@@ -329,14 +329,21 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 		return -ENODEV;
 	}
 
+	mux = clk_get_parent(dmic->fclk);
+	if (IS_ERR(mux)) {
+		dev_err(dmic->dev, "can't get fck mux parent\n");
+		clk_put(parent_clk);
+		return -ENODEV;
+	}
+
 	mutex_lock(&dmic->mutex);
 	if (dmic->active) {
 		/* disable clock while reparenting */
 		pm_runtime_put_sync(dmic->dev);
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 		pm_runtime_get_sync(dmic->dev);
 	} else {
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 	}
 	mutex_unlock(&dmic->mutex);
 
@@ -349,6 +356,7 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 	dmic->fclk_freq = freq;
 
 err_busy:
+	clk_put(mux);
 	clk_put(parent_clk);
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
