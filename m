From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt274: Add fall-through annotations" to
	the asoc tree
Date: Fri,  5 Oct 2018 14:26:17 +0100 (BST)
Message-ID: <20181005132617.DCD7D112229A@debutante.sirena.org.uk>
References: <20181004183006.23983-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BF52E26793A
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 15:26:18 +0200 (CEST)
In-Reply-To: <20181004183006.23983-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt274: Add fall-through annotations

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0beeb4baf56bd9deb920712a4034541fb33bbbe0 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 4 Oct 2018 20:30:04 +0200
Subject: [PATCH] ASoC: rt274: Add fall-through annotations

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, add the "fall through" annotations in rt274 driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
