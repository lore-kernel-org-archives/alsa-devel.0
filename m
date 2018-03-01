From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Only configure LDO voltage once
	at boot" to the asoc tree
Date: Thu, 01 Mar 2018 19:26:06 +0000
Message-ID: <E1erTqA-0001VK-R3@debutante>
References: <20180225104713.4745-13-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 83743267BA3
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:15 +0100 (CET)
In-Reply-To: <20180225104713.4745-13-hdegoede@redhat.com>
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

   ASoC: rt5651: Only configure LDO voltage once at boot

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

>From 3d7719d3cc8efe88be4c72cb7cbb0d866ed7d1b2 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:53 +0100
Subject: [PATCH] ASoC: rt5651: Only configure LDO voltage once at boot

Now that rt5651_set_bias_level(BIAS_OFF) no longer modifies the LDO
voltage selection bits, there is no need to set them each time we move
to standby. Instead configure them once at component-probe() time.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 74f83af3b6be..9460bdcad349 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1540,9 +1540,6 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 			snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2);
-			snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-				RT5651_PWR_LDO_DVO_MASK,
-				RT5651_PWR_LDO_DVO_1_2V);
 			snd_soc_component_update_bits(component, RT5651_D_MISC, 0x1, 0x1);
 		}
 		break;
@@ -1662,6 +1659,9 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	rt5651->component = component;
 
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
+		RT5651_PWR_LDO_DVO_MASK, RT5651_PWR_LDO_DVO_1_2V);
+
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	rt5651_apply_properties(component);
-- 
2.16.2
