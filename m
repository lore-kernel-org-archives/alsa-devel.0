From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Remove programming of PWR regs
	before force_bias_level() call" to the asoc tree
Date: Thu, 01 Mar 2018 19:26:09 +0000
Message-ID: <E1erTqD-0001WJ-WB@debutante>
References: <20180225104713.4745-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F1028267BC2
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:27:23 +0100 (CET)
In-Reply-To: <20180225104713.4745-12-hdegoede@redhat.com>
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

   ASoC: rt5651: Remove programming of PWR regs before force_bias_level() call

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

>From a25fe11746846f5dd3286cf690b470e3d049797f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:52 +0100
Subject: [PATCH] ASoC: rt5651: Remove programming of PWR regs before
 force_bias_level() call

Remove the setup of the PWR_ANLG1 reg which was done directly before
calling snd_soc_component_force_bias_level(SND_SOC_BIAS_OFF), as the
latter will override any settings done to PWR_ANLG1 immediately anyways.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index d4fb16686889..74f83af3b6be 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1662,16 +1662,6 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	rt5651->component = component;
 
-	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2);
-	usleep_range(10000, 15000);
-	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2);
-
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	rt5651_apply_properties(component);
-- 
2.16.2
