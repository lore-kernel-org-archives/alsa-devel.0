From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa/mioa701_wm9713: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:33:26 +0000
Message-ID: <E1elDIU-0003cJ-H0@debutante>
References: <87y3l33kho.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D36B267645
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:33:30 +0100 (CET)
In-Reply-To: <87y3l33kho.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa/mioa701_wm9713: replace codec to component

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

>From acafeefe43ec897a198740322f65521809b2b9cd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:46:53 +0000
Subject: [PATCH] ASoC: pxa/mioa701_wm9713: replace codec to component

Now codec can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mioa701_wm9713.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index c4c6fbedc723..47052fe3f5f4 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -58,20 +58,20 @@
 #define AC97_GPIO_PULL		0x58
 
 /* Use GPIO8 for rear speaker amplifier */
-static int rear_amp_power(struct snd_soc_codec *codec, int power)
+static int rear_amp_power(struct snd_soc_component *component, int power)
 {
 	unsigned short reg;
 
 	if (power) {
-		reg = snd_soc_read(codec, AC97_GPIO_CFG);
-		snd_soc_write(codec, AC97_GPIO_CFG, reg | 0x0100);
-		reg = snd_soc_read(codec, AC97_GPIO_PULL);
-		snd_soc_write(codec, AC97_GPIO_PULL, reg | (1<<15));
+		reg = snd_soc_component_read32(component, AC97_GPIO_CFG);
+		snd_soc_component_write(component, AC97_GPIO_CFG, reg | 0x0100);
+		reg = snd_soc_component_read32(component, AC97_GPIO_PULL);
+		snd_soc_component_write(component, AC97_GPIO_PULL, reg | (1<<15));
 	} else {
-		reg = snd_soc_read(codec, AC97_GPIO_CFG);
-		snd_soc_write(codec, AC97_GPIO_CFG, reg & ~0x0100);
-		reg = snd_soc_read(codec, AC97_GPIO_PULL);
-		snd_soc_write(codec, AC97_GPIO_PULL, reg & ~(1<<15));
+		reg = snd_soc_component_read32(component, AC97_GPIO_CFG);
+		snd_soc_component_write(component, AC97_GPIO_CFG, reg & ~0x0100);
+		reg = snd_soc_component_read32(component, AC97_GPIO_PULL);
+		snd_soc_component_write(component, AC97_GPIO_PULL, reg & ~(1<<15));
 	}
 
 	return 0;
@@ -82,11 +82,11 @@ static int rear_amp_event(struct snd_soc_dapm_widget *widget,
 {
 	struct snd_soc_card *card = widget->dapm->card;
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
-	codec = rtd->codec;
-	return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
+	component = rtd->codec_dai->component;
+	return rear_amp_power(component, SND_SOC_DAPM_EVENT_ON(event));
 }
 
 /* mioa701 machine dapm widgets */
@@ -129,13 +129,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_component *component = rtd->codec_dai->component;
 
 	/* Prepare GPIO8 for rear speaker amplifier */
-	snd_soc_update_bits(codec, AC97_GPIO_CFG, 0x100, 0x100);
+	snd_soc_component_update_bits(component, AC97_GPIO_CFG, 0x100, 0x100);
 
 	/* Prepare MIC input */
-	snd_soc_update_bits(codec, AC97_3D_CONTROL, 0xc000, 0xc000);
+	snd_soc_component_update_bits(component, AC97_3D_CONTROL, 0xc000, 0xc000);
 
 	return 0;
 }
-- 
2.16.1
