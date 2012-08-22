From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] ASoC: omap-mcbsp: Use macro to create
	the McBSP2/3 ST controls
Date: Wed, 22 Aug 2012 13:11:42 +0300
Message-ID: <1345630303-26291-4-git-send-email-peter.ujfalusi@ti.com>
References: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
 [74.125.149.247])
 by alsa0.perex.cz (Postfix) with ESMTP id D69F82660F7
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:12:06 +0200 (CEST)
Received: by obceq6 with SMTP id eq6so1158954obc.11
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:12:01 -0700 (PDT)
In-Reply-To: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

To remove duplicated code from the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   39 +++++++++++++++------------------------
 1 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index c964f68..44c475c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -688,31 +688,22 @@ static int omap_mcbsp_st_get_mode(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
-	SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
-			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
-	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
-				      -32768, 32767,
-				      omap_mcbsp_get_st_ch0_volume,
-				      omap_mcbsp_set_st_ch0_volume),
-	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
-				      -32768, 32767,
-				      omap_mcbsp_get_st_ch1_volume,
-				      omap_mcbsp_set_st_ch1_volume),
-};
+#define OMAP_MCBSP_ST_CONTROLS(port)					  \
+static const struct snd_kcontrol_new omap_mcbsp##port##_st_controls[] = { \
+SOC_SINGLE_EXT("McBSP" #port " Sidetone Switch", 1, 0, 1, 0,		  \
+	       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),		  \
+OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP" #port " Sidetone Channel 0 Volume", \
+			      -32768, 32767,				  \
+			      omap_mcbsp_get_st_ch0_volume,		  \
+			      omap_mcbsp_set_st_ch0_volume),		  \
+OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP" #port " Sidetone Channel 1 Volume", \
+			      -32768, 32767,				  \
+			      omap_mcbsp_get_st_ch1_volume,		  \
+			      omap_mcbsp_set_st_ch1_volume),		  \
+}
 
-static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
-	SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
-			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
-	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
-				      -32768, 32767,
-				      omap_mcbsp_get_st_ch0_volume,
-				      omap_mcbsp_set_st_ch0_volume),
-	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
-				      -32768, 32767,
-				      omap_mcbsp_get_st_ch1_volume,
-				      omap_mcbsp_set_st_ch1_volume),
-};
+OMAP_MCBSP_ST_CONTROLS(2);
+OMAP_MCBSP_ST_CONTROLS(3);
 
 int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
 {
-- 
1.7.8.6
