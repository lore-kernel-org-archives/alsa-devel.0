From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Remove "JD Power" dapm supply"
	to the asoc tree
Date: Thu, 01 Mar 2018 19:25:58 +0000
Message-ID: <E1erTq2-0001U3-0x@debutante>
References: <20180225104713.4745-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DD3F6267B99
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:06 +0100 (CET)
In-Reply-To: <20180225104713.4745-14-hdegoede@redhat.com>
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

   ASoC: rt5651: Remove "JD Power" dapm supply

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

>From 57d9d7c32fc24ca4de49392fec1fdd3db1f58e92 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:54 +0100
Subject: [PATCH] ASoC: rt5651: Remove "JD Power" dapm supply

Remove the "JD power" dapm supply which gets force-enabled once when
using jack-detect and never gets disabled again.

Since the PWR_JD_M bit simply needs to be always on when using jack-detect
there is no need to have it tracked by dapm, instead we can simply set it
to 1 once when initializing the jack-detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9460bdcad349..cbf9f56ecb14 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -869,10 +869,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
 			      11, 0, NULL, 0),
 
-	/* Input Side */
-	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
-		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
-
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
@@ -1616,7 +1612,10 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+	/* Enable jack detect power */
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
+
 	snd_soc_dapm_force_enable_pin(dapm, "LDO");
 	snd_soc_dapm_sync(dapm);
 
-- 
2.16.2
