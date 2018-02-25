From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 08/32] ASoC: rt5651: Fix bias_level confusion
Date: Sun, 25 Feb 2018 11:46:49 +0100
Message-ID: <20180225104713.4745-9-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC2C2673C9
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:29 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The rt5651_set_bias_level() function was turning everything off at
SND_SOC_BIAS_STANDBY, rather then at SND_SOC_BIAS_OFF, requiring the bias-
level to be raised to SND_SOC_BIAS_PREPARE before turning anything on.

This is not how the bias-levels are supposed to work, this commit fixes
this by turning everything off at the SND_SOC_BIAS_OFF level and enabling
the pwr-bits needed for minimum functionality at SND_SOC_BIAS_STANDBY.

This fixes the minimum set of pwr-bits not getting enabled when
force-enabling some dapm-supplies (e.g. for jack type detection),
which raises the bias-level to standby.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index d4a2a1ef87b2..90e800416a8e 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1521,6 +1521,13 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == snd_soc_component_get_bias_level(component)) {
+			if (snd_soc_component_read32(component, RT5651_PLL_MODE_1) & 0x9200)
+				snd_soc_component_update_bits(component, RT5651_D_MISC,
+						    0xc00, 0xc00);
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (SND_SOC_BIAS_OFF == snd_soc_component_get_bias_level(component)) {
 			snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
 				RT5651_PWR_VREF1 | RT5651_PWR_MB |
 				RT5651_PWR_BG | RT5651_PWR_VREF2,
@@ -1534,13 +1541,10 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 				RT5651_PWR_LDO_DVO_MASK,
 				RT5651_PWR_LDO_DVO_1_2V);
 			snd_soc_component_update_bits(component, RT5651_D_MISC, 0x1, 0x1);
-			if (snd_soc_component_read32(component, RT5651_PLL_MODE_1) & 0x9200)
-				snd_soc_component_update_bits(component, RT5651_D_MISC,
-						    0xc00, 0xc00);
 		}
 		break;
 
-	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
 		snd_soc_component_write(component, RT5651_D_MISC, 0x0010);
 		snd_soc_component_write(component, RT5651_PWR_DIG1, 0x0000);
 		snd_soc_component_write(component, RT5651_PWR_DIG2, 0x0000);
-- 
2.14.3
