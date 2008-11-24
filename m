From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 7/9] ASoC: TWL4030: Add Carkit outupt mux and
	volume controls
Date: Mon, 24 Nov 2008 13:49:41 +0200
Message-ID: <1227527383-22516-8-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-7-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BF4B610381A
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:50:12 +0100 (CET)
In-Reply-To: <1227527383-22516-7-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the routing selection for the Carkit output
and Carkit gain control.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index b3cd498..03b0431 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -196,6 +196,8 @@ static const char *twl4030_predrivr_mix[] = {"Off", "Voice", "DACR1",
 					    "DACR2", "DACL2"};
 static const char *twl4030_hsoutl_mix[] = {"Off", "Voice", "DACL1", "DACL2"};
 static const char *twl4030_hsoutr_mix[] = {"Off", "Voice", "DACR1", "DACR2"};
+static const char *twl4030_carkitl_mix[] = {"Off", "Voice", "DACL1", "DACL2"};
+static const char *twl4030_carkitr_mix[] = {"Off", "Voice", "DACR1", "DACR2"};
 
 
 static const struct soc_enum twl4030_enum[] = {
@@ -203,6 +205,8 @@ static const struct soc_enum twl4030_enum[] = {
 	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 0, 5, twl4030_predrivr_mix),
 	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 0, 4, twl4030_hsoutl_mix),
 	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 3, 4, twl4030_hsoutr_mix),
+	SOC_ENUM_SINGLE(TWL4030_REG_PRECKL_CTL, 0, 4, twl4030_carkitl_mix),
+	SOC_ENUM_SINGLE(TWL4030_REG_PRECKR_CTL, 0, 4, twl4030_carkitr_mix),
 };
 /*
  * Some of TWL's input selection are in bitfield.
@@ -459,6 +463,14 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_TLV_TWL4030("Headset Playback Volume",
 		 TWL4030_REG_HS_GAIN_SET, 0, 2, 3, 0, gainv1_tvl),
 
+	/* Carkit output controls*/
+	SOC_ENUM_EXT("CarkitL Playback Mux", twl4030_enum[4],
+		     snd_soc_get_enum_twl4030, snd_soc_put_enum_twl4030),
+	SOC_ENUM_EXT("CarkitR Playback Mux", twl4030_enum[5],
+		     snd_soc_get_enum_twl4030, snd_soc_put_enum_twl4030),
+	SOC_DOUBLE_R_TLV_TWL4030("Carkit Playback Volume",
+		 TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
+		4, 3, 0, gainv1_tvl),
 };
 
 /* add non dapm controls */
-- 
1.6.0.3
