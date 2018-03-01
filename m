From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Only configure OVCD once at
	set_jack time" to the asoc tree
Date: Thu, 01 Mar 2018 19:25:52 +0000
Message-ID: <E1erTpw-0001SD-Lf@debutante>
References: <20180225104713.4745-16-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0081A267190
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:02 +0100 (CET)
In-Reply-To: <20180225104713.4745-16-hdegoede@redhat.com>
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

   ASoC: rt5651: Only configure OVCD once at set_jack time

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

>From 9e1795925d0e967d2a0191b1487b5caf0693f2ae Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:56 +0100
Subject: [PATCH] ASoC: rt5651: Only configure OVCD once at set_jack time

Only configure OVCD once at set_jack time, rather then configuring
it on every jack-insertion event and switch to using bit field defines
instead of hardcoding a magic value.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index be942886700d..41d7c192ac03 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1637,7 +1637,15 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
 		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
 
-	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
+	snd_soc_component_update_bits(component, RT5651_MICBIAS,
+				      RT5651_MIC1_OVCD_MASK |
+				      RT5651_MIC1_OVTH_MASK |
+				      RT5651_PWR_CLK12M_MASK |
+				      RT5651_PWR_MB_MASK,
+				      RT5651_MIC1_OVCD_DIS |
+				      RT5651_MIC1_OVTH_600UA |
+				      RT5651_PWR_MB_PU |
+				      RT5651_PWR_CLK12M_PU);
 
 	rt5651->hp_jack = hp_jack;
 
@@ -1842,14 +1850,8 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
 		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK |
-				    RT5651_MIC1_OVTH_MASK |
-				    RT5651_PWR_CLK12M_MASK |
-				    RT5651_PWR_MB_MASK,
-				    RT5651_MIC1_OVCD_EN |
-				    RT5651_MIC1_OVTH_600UA |
-				    RT5651_PWR_MB_PU |
-				    RT5651_PWR_CLK12M_PU);
+				    RT5651_MIC1_OVCD_MASK,
+				    RT5651_MIC1_OVCD_EN);
 		msleep(100);
 		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
 			jack_type = SND_JACK_HEADPHONE;
-- 
2.16.2
