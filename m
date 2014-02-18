From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 045/102] ASoC: twl6040: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:01 +0100
Message-ID: <1392723517-12772-18-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 986D02655CF
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.
Also, use ARRAY_SIZE() in some ASOC_ENUM_SINGLE() lines.

No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/twl6040.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index cb642c927dc8..bd3a20647fdf 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -392,8 +392,10 @@ static const char *twl6040_amicr_texts[] =
 	{"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
 
 static const struct soc_enum twl6040_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3, 4, twl6040_amicl_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3, 4, twl6040_amicr_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3,
+			ARRAY_SIZE(twl6040_amicl_texts), twl6040_amicl_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3,
+			ARRAY_SIZE(twl6040_amicr_texts), twl6040_amicr_texts),
 };
 
 static const char *twl6040_hs_texts[] = {
@@ -476,9 +478,8 @@ static const char *twl6040_power_mode_texts[] = {
 	"Low-Power", "High-Performance",
 };
 
-static const struct soc_enum twl6040_power_mode_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl6040_power_mode_texts),
-			twl6040_power_mode_texts);
+static SOC_ENUM_SINGLE_EXT_DECL(twl6040_power_mode_enum,
+				twl6040_power_mode_texts);
 
 static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
-- 
1.8.5.2
