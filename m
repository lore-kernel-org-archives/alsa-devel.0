From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 8/9] ASoC: tas2552: Use consistent name for
	'struct tas2552_data'
Date: Mon, 8 Jun 2015 15:19:55 +0300
Message-ID: <1433765996-28930-9-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A5567260412
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:17 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In tas2552_sw_shutdown() tas_data is used while the rest of the driver uses
tas2552 when dealing with the 'struct tas2552_data'

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 534b57bff03d..169a7035d7e3 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -145,17 +145,17 @@ static const struct snd_soc_dapm_route tas2552_audio_map[] = {
 };
 
 #ifdef CONFIG_PM
-static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
+static void tas2552_sw_shutdown(struct tas2552_data *tas2552, int sw_shutdown)
 {
 	u8 cfg1_reg = 0;
 
-	if (!tas_data->codec)
+	if (!tas2552->codec)
 		return;
 
 	if (sw_shutdown)
 		cfg1_reg = TAS2552_SWS;
 
-	snd_soc_update_bits(tas_data->codec, TAS2552_CFG_1, TAS2552_SWS,
+	snd_soc_update_bits(tas2552->codec, TAS2552_CFG_1, TAS2552_SWS,
 			    cfg1_reg);
 }
 #endif
-- 
2.4.2
