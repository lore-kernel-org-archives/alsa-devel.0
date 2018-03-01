From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Fix bias_level confusion" to
	the asoc tree
Date: Thu, 01 Mar 2018 19:26:20 +0000
Message-ID: <E1erTqO-0001ZG-2X@debutante>
References: <20180225104713.4745-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA7EB267BAA
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:28 +0100 (CET)
In-Reply-To: <20180225104713.4745-9-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Fix bias_level confusion

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

>From 984c803f9a2ad6f1d2bea0b7ef2e3c18d69fbdfd Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:49 +0100
Subject: [PATCH] ASoC: rt5651: Fix bias_level confusion

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 8548f9406520..c565607f95f7 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1526,6 +1526,13 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
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
@@ -1539,13 +1546,10 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
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
2.16.2
