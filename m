From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Always keep OVCD enabled" to
	the asoc tree
Date: Thu, 01 Mar 2018 19:25:49 +0000
Message-ID: <E1erTpt-0001RC-HK@debutante>
References: <20180225104713.4745-17-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CB3B3267BBF
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:27:23 +0100 (CET)
In-Reply-To: <20180225104713.4745-17-hdegoede@redhat.com>
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

   ASoC: rt5651: Always keep OVCD enabled

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

>From f1088d4b813fb4d20fc9e8e8db5ca252923f25eb Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:57 +0100
Subject: [PATCH] ASoC: rt5651: Always keep OVCD enabled

OVCD is not only useful for jack-type detection, but is also useful
to protect against over-current faults in general, so always keep
OVCD enabled, instead of only enabling it for jack-type detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 41d7c192ac03..55bcc74e344f 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1642,7 +1642,7 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 				      RT5651_MIC1_OVTH_MASK |
 				      RT5651_PWR_CLK12M_MASK |
 				      RT5651_PWR_MB_MASK,
-				      RT5651_MIC1_OVCD_DIS |
+				      RT5651_MIC1_OVCD_EN |
 				      RT5651_MIC1_OVTH_600UA |
 				      RT5651_PWR_MB_PU |
 				      RT5651_PWR_CLK12M_PU);
@@ -1849,9 +1849,6 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
-		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_EN);
 		msleep(100);
 		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
 			jack_type = SND_JACK_HEADPHONE;
@@ -1862,10 +1859,6 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
-
-		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_DIS);
 	}
 
 	return jack_type;
-- 
2.16.2
