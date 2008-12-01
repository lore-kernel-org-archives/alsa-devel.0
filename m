From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon,  1 Dec 2008 10:03:48 +0200
Message-ID: <1228118628-22856-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 926AC243ED
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 09:04:06 +0100 (CET)
In-Reply-To: <1228118628-22856-4-git-send-email-peter.ujfalusi@nokia.com>
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

Controls for selecting the digital inputs for the four
DAC.
Digital input namings:
SDRL1: TDM #1
SDRR1: TDM #2
SDRL2: TDM #3, I2S Left
SDRR2: TDM #4, I2S Right

Mono mixing:
SDRM1: mixed SDRL1 and SDRR1
SDRM2: mixed SDRL2 and SDRR2

The possible mux settings for the DAC inputs:
DACL1 <- SDRL1, SDRM1, SDRM2, SDRL2
DACR1 <- SDRR1, SDRM1, SDRM2, SDRR2
DACL2 <- SDRL2, SDRM2
DACR2 <- SDRR2, SDRM2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index bd236b2..fd9d47e 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,6 +190,38 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+static const char *twl4030_predacl1_texts[] =
+		{"SDRL1", "SDRM1", "SRDL2", "SDRM2"};
+
+static const char *twl4030_predacr1_texts[] =
+		{"SDRR1", "SDRM1", "SRDR2", "SDRM2"};
+
+static const char *twl4030_predacl2_texts[] =
+		{"SDRL2", "SDRM2"};
+
+static const char *twl4030_predacr2_texts[] =
+		{"SDRR2", "SDRM2"};
+
+static const struct soc_enum twl4030_predacl1_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_RX_PATH_SEL, 2,
+			ARRAY_SIZE(twl4030_predacl1_texts),
+			twl4030_predacl1_texts);
+
+static const struct soc_enum twl4030_predacr1_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_RX_PATH_SEL, 0,
+			ARRAY_SIZE(twl4030_predacr1_texts),
+			twl4030_predacr1_texts);
+
+static const struct soc_enum twl4030_predacl2_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_RX_PATH_SEL, 5,
+			ARRAY_SIZE(twl4030_predacl2_texts),
+			twl4030_predacl2_texts);
+
+static const struct soc_enum twl4030_predacr2_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_RX_PATH_SEL, 4,
+			ARRAY_SIZE(twl4030_predacr2_texts),
+			twl4030_predacr2_texts);
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -420,6 +452,12 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Capture Volume",
 		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0, digital_capture_tlv),
+
+	/* Mux controls before the DACs */
+	SOC_ENUM("DACL1 Playback Mux", twl4030_predacl1_enum),
+	SOC_ENUM("DACR1 Playback Mux", twl4030_predacr1_enum),
+	SOC_ENUM("DACL2 Playback Mux", twl4030_predacl2_enum),
+	SOC_ENUM("DACR2 Playback Mux", twl4030_predacr2_enum),
 };
 
 /* add non dapm controls */
-- 
1.6.0.3
