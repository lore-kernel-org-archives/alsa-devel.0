From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Add control for digimic Left
	Right swap
Date: Wed, 12 May 2010 10:35:36 +0300
Message-ID: <1273649736-31131-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 04C7424963
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 09:35:55 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The codec has support for swapping the left and right
channels in the digimic interface.
New kcontrol to handle this bit.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 0fe74d1..6a34f56 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1102,6 +1102,16 @@ static const struct soc_enum twl4030_vibradir_enum =
 			ARRAY_SIZE(twl4030_vibradir_texts),
 			twl4030_vibradir_texts);
 
+/* Digimic Left and right swapping */
+static const char *twl4030_digimicswap_texts[] = {
+	"Not swapped", "Swapped",
+};
+
+static const struct soc_enum twl4030_digimicswap_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_MISC_SET_1, 0,
+			ARRAY_SIZE(twl4030_digimicswap_texts),
+			twl4030_digimicswap_texts);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Codec operation mode control */
 	SOC_ENUM_EXT("Codec Operation Mode", twl4030_op_modes_enum,
@@ -1178,6 +1188,8 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 
 	SOC_ENUM("Vibra H-bridge mode", twl4030_vibradirmode_enum),
 	SOC_ENUM("Vibra H-bridge direction", twl4030_vibradir_enum),
+
+	SOC_ENUM("Digimic LR Swap", twl4030_digimicswap_enum),
 };
 
 static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
-- 
1.7.1
