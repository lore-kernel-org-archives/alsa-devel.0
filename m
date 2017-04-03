From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Add control for HS and HF mono
	to stereo selection
Date: Mon, 3 Apr 2017 13:12:39 +0300
Message-ID: <20170403101239.2721-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F36A2669D7
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 12:11:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The new controls will give user the ability to route the left PDM channel
data to the right headset/handsfree DAC.
HS mono to stereo switch: PDM channel 1 (or mono) data to both HS DAC.
HF mono to stereo switch: PDM channel 3 data to both HF DAC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 748036e851ea..2b6ad09e0886 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -606,6 +606,14 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 		twl6040_headset_power_get_enum,
 		twl6040_headset_power_put_enum),
 
+	/* Left HS PDM data routed to Right HSDAC */
+	SOC_SINGLE("Headset Mono to Stereo Playback Switch",
+		TWL6040_REG_HSRCTL, 7, 1, 0),
+
+	/* Left HF PDM data routed to Right HFDAC */
+	SOC_SINGLE("Handsfree Mono to Stereo Playback Switch",
+		TWL6040_REG_HFRCTL, 5, 1, 0),
+
 	SOC_ENUM_EXT("PLL Selection", twl6040_power_mode_enum,
 		twl6040_pll_get_enum, twl6040_pll_put_enum),
 };
-- 
2.12.2
