From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 090/102] ASoC: twl6040: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:36 +0100
Message-ID: <1392724308-13375-10-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C138265763
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/twl6040.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bd3a20647fdf..f50dbd7dc4b2 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -392,10 +392,8 @@ static const char *twl6040_amicr_texts[] =
 	{"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
 
 static const struct soc_enum twl6040_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3,
-			ARRAY_SIZE(twl6040_amicl_texts), twl6040_amicl_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3,
-			ARRAY_SIZE(twl6040_amicr_texts), twl6040_amicr_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_MICLCTL, 3, twl6040_amicl_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_MICRCTL, 3, twl6040_amicr_texts),
 };
 
 static const char *twl6040_hs_texts[] = {
@@ -403,10 +401,8 @@ static const char *twl6040_hs_texts[] = {
 };
 
 static const struct soc_enum twl6040_hs_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_HSLCTL, 5, ARRAY_SIZE(twl6040_hs_texts),
-			twl6040_hs_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_HSRCTL, 5, ARRAY_SIZE(twl6040_hs_texts),
-			twl6040_hs_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_HSLCTL, 5, twl6040_hs_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_HSRCTL, 5, twl6040_hs_texts),
 };
 
 static const char *twl6040_hf_texts[] = {
@@ -414,10 +410,8 @@ static const char *twl6040_hf_texts[] = {
 };
 
 static const struct soc_enum twl6040_hf_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_HFLCTL, 2, ARRAY_SIZE(twl6040_hf_texts),
-			twl6040_hf_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_HFRCTL, 2, ARRAY_SIZE(twl6040_hf_texts),
-			twl6040_hf_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_HFLCTL, 2, twl6040_hf_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_HFRCTL, 2, twl6040_hf_texts),
 };
 
 static const char *twl6040_vibrapath_texts[] = {
@@ -425,12 +419,8 @@ static const char *twl6040_vibrapath_texts[] = {
 };
 
 static const struct soc_enum twl6040_vibra_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_VIBCTLL, 1,
-			ARRAY_SIZE(twl6040_vibrapath_texts),
-			twl6040_vibrapath_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_VIBCTLR, 1,
-			ARRAY_SIZE(twl6040_vibrapath_texts),
-			twl6040_vibrapath_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_VIBCTLL, 1, twl6040_vibrapath_texts),
+	SOC_ENUM_SINGLE_CONST(TWL6040_REG_VIBCTLR, 1, twl6040_vibrapath_texts),
 };
 
 static const struct snd_kcontrol_new amicl_control =
-- 
1.8.5.2
