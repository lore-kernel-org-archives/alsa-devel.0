From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Enable Platform Clock during
	jack-type detect" to the asoc tree
Date: Wed, 07 Mar 2018 14:13:55 +0000
Message-ID: <E1etZpL-0001Of-Ec@debutante>
References: <20180225104713.4745-20-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E17E2673CC
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:14:00 +0100 (CET)
In-Reply-To: <20180225104713.4745-20-hdegoede@redhat.com>
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

   ASoC: rt5651: Enable Platform Clock during jack-type detect

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

>From 4b4a373c0212e084045530e47071374a87a3761e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:55 +0100
Subject: [PATCH] ASoC: rt5651: Enable Platform Clock during jack-type detect

When using RCCLK instead of MCLK / PLL1 the OVCD status often gets stuck
at its last value, which breaks jack-type detection.

This commit fixes this by force-enabling the platform clock when doing
jack-type detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 62918f7e8270..873af6798d7a 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1563,6 +1563,8 @@ static void rt5651_enable_micbias1_for_ovcd(struct snd_soc_component *component)
 	snd_soc_dapm_mutex_lock(dapm);
 	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
 	snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+	/* OVCD is unreliable when used with RCCLK as sysclk-source */
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Platform Clock");
 	snd_soc_dapm_sync_unlocked(dapm);
 	snd_soc_dapm_mutex_unlock(dapm);
 }
@@ -1572,6 +1574,7 @@ static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Platform Clock");
 	snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
 	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
 	snd_soc_dapm_sync_unlocked(dapm);
-- 
2.16.2
