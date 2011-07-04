From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/6] ASoC: twl6040: Use neutral name for power
	mode text/enum
Date: Mon, 4 Jul 2011 13:05:53 +0300
Message-ID: <1309773958-14608-2-git-send-email-peter.ujfalusi@ti.com>
References: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 585B5103807
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 12:05:58 +0200 (CEST)
In-Reply-To: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Change the variable names to be neutral (not refering to HS).
This will ease up the introduction of PLL selection, which
going to use the same enum strings.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0145041..3b2843c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1012,13 +1012,13 @@ static const struct snd_kcontrol_new ep_driver_switch_controls =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_EARCTL, 0, 1, 0);
 
 /* Headset power mode */
-static const char *twl6040_headset_power_texts[] = {
+static const char *twl6040_power_mode_texts[] = {
 	"Low-Power", "High-Perfomance",
 };
 
-static const struct soc_enum twl6040_headset_power_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl6040_headset_power_texts),
-			twl6040_headset_power_texts);
+static const struct soc_enum twl6040_power_mode_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl6040_power_mode_texts),
+			twl6040_power_mode_texts);
 
 static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
@@ -1067,7 +1067,7 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	SOC_SINGLE_TLV("Earphone Playback Volume",
 		TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
 
-	SOC_ENUM_EXT("Headset Power Mode", twl6040_headset_power_enum,
+	SOC_ENUM_EXT("Headset Power Mode", twl6040_power_mode_enum,
 		twl6040_headset_power_get_enum,
 		twl6040_headset_power_put_enum),
 };
-- 
1.7.6
