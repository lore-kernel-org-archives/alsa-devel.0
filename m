From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ASoC: rt274: Add fall-through annotations
Date: Thu,  4 Oct 2018 20:30:04 +0200
Message-ID: <20181004183006.23983-4-tiwai@suse.de>
References: <20181004183006.23983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9AF22678AB
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:30:09 +0200 (CEST)
In-Reply-To: <20181004183006.23983-1-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, add the "fall through" annotations in rt274 driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt274.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index d88e67341083..0ef966d56bac 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -755,6 +755,7 @@ static int rt274_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		break;
 	default:
 		dev_warn(component->dev, "invalid pll source, use BCLK\n");
+		/* fall through */
 	case RT274_PLL2_S_BCLK:
 		snd_soc_component_update_bits(component, RT274_PLL2_CTRL,
 				RT274_PLL2_SRC_MASK, RT274_PLL2_SRC_BCLK);
@@ -782,6 +783,7 @@ static int rt274_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			break;
 		default:
 			dev_warn(component->dev, "invalid freq_in, assume 4.8M\n");
+			/* fall through */
 		case 100:
 			snd_soc_component_write(component, 0x7a, 0xaab6);
 			snd_soc_component_write(component, 0x7b, 0x0301);
-- 
2.18.0
