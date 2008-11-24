From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 8/9] ASoC: TWL4030: Add Hands-free outupt mux
	control
Date: Mon, 24 Nov 2008 13:49:42 +0200
Message-ID: <1227527383-22516-9-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-7-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-8-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 69A9F24383
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:50:13 +0100 (CET)
In-Reply-To: <1227527383-22516-8-git-send-email-peter.ujfalusi@nokia.com>
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

This patch adds the routing selection for the Hands-free output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 03b0431..88f5cbe 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -198,6 +198,10 @@ static const char *twl4030_hsoutl_mix[] = {"Off", "Voice", "DACL1", "DACL2"};
 static const char *twl4030_hsoutr_mix[] = {"Off", "Voice", "DACR1", "DACR2"};
 static const char *twl4030_carkitl_mix[] = {"Off", "Voice", "DACL1", "DACL2"};
 static const char *twl4030_carkitr_mix[] = {"Off", "Voice", "DACR1", "DACR2"};
+static const char *twl4030_handsfreel_mix[] = {"Voice", "DACL1",
+					       "DACL2", "DACR2"};
+static const char *twl4030_handsfreer_mix[] = {"Voice", "DACR1",
+					       "DACR2", "DACL2"};
 
 
 static const struct soc_enum twl4030_enum[] = {
@@ -207,6 +211,8 @@ static const struct soc_enum twl4030_enum[] = {
 	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 3, 4, twl4030_hsoutr_mix),
 	SOC_ENUM_SINGLE(TWL4030_REG_PRECKL_CTL, 0, 4, twl4030_carkitl_mix),
 	SOC_ENUM_SINGLE(TWL4030_REG_PRECKR_CTL, 0, 4, twl4030_carkitr_mix),
+	SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0, 4, twl4030_handsfreel_mix),
+	SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0, 4, twl4030_handsfreer_mix),
 };
 /*
  * Some of TWL's input selection are in bitfield.
@@ -471,6 +477,10 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV_TWL4030("Carkit Playback Volume",
 		 TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
 		4, 3, 0, gainv1_tvl),
+
+	/* Hand-free output controls*/
+	SOC_ENUM("HandsfreeL Playback Mux", twl4030_enum[6]),
+	SOC_ENUM("HandsfreeR Playback Mux", twl4030_enum[7]),
 };
 
 /* add non dapm controls */
-- 
1.6.0.3
