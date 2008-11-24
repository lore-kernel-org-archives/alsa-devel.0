From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/9] ASoC: TWL4030: Add PreDriv outupt mux and
	volume controls
Date: Mon, 24 Nov 2008 13:49:39 +0200
Message-ID: <1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CF9E624385
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:49:57 +0100 (CET)
In-Reply-To: <1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
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

This patch adds the routing selection for the PreDriv output
and PreDriv gain control.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index b0975a9..cee52ab 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,6 +190,16 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+static const char *twl4030_predrivl_mix[] = {"Off", "Voice", "DACL1",
+					    "DACL2", "DACR2"};
+static const char *twl4030_predrivr_mix[] = {"Off", "Voice", "DACR1",
+					    "DACR2", "DACL2"};
+
+
+static const struct soc_enum twl4030_enum[] = {
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 0, 5, twl4030_predrivl_mix),
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 0, 5, twl4030_predrivr_mix),
+};
 /*
  * Some of TWL's input selection are in bitfield.
  * Dealing with those need special function
@@ -411,6 +421,12 @@ static DECLARE_TLV_DB_SCALE(master_tlv, -6300, 100, 1);
  */
 static DECLARE_TLV_DB_SCALE(master_coarse_tlv, 0, 600, 0);
 
+/*
+ * Output gain controls
+ * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
+ */
+static DECLARE_TLV_DB_SCALE(gainv1_tvl, -1200, 600, 1);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
@@ -421,6 +437,16 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R("Capture Volume",
 		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0),
+
+	/* PreDrive output controls*/
+	SOC_ENUM_EXT("PreDriveL Playback Mux", twl4030_enum[0],
+		     snd_soc_get_enum_twl4030, snd_soc_put_enum_twl4030),
+	SOC_ENUM_EXT("PreDriveR Playback Mux", twl4030_enum[1],
+		     snd_soc_get_enum_twl4030, snd_soc_put_enum_twl4030),
+	SOC_DOUBLE_R_TLV_TWL4030("PreDriv Playback Volume",
+		 TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
+		4, 3, 0, gainv1_tvl),
+
 };
 
 /* add non dapm controls */
-- 
1.6.0.3
