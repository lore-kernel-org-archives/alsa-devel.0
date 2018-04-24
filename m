From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Account for name prefixes when
	toggling preloader" to the asoc tree
Date: Tue, 24 Apr 2018 18:45:37 +0100
Message-ID: <E1fB20X-0003VY-Rb@debutante>
References: <20180424155309.12059-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 814172676AB
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 19:45:41 +0200 (CEST)
In-Reply-To: <20180424155309.12059-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Account for name prefixes when toggling preloader

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

>From 95a594d0f5ffdc55eaf0d1ae21cfbfd4e64378f2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 24 Apr 2018 16:53:09 +0100
Subject: [PATCH] ASoC: wm_adsp: Account for name prefixes when toggling
 preloader

Use the correct functions to allow a name prefix assigned through
codec_conf to be taken into consideration whilst enabling and disabling
the preloader widget.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 82b0927e6ed7..b7b914963c62 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2666,9 +2666,9 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 	dsp->preloaded = ucontrol->value.integer.value[0];
 
 	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_force_enable_pin(dapm, preload);
+		snd_soc_component_force_enable_pin(component, preload);
 	else
-		snd_soc_dapm_disable_pin(dapm, preload);
+		snd_soc_component_disable_pin(component, preload);
 
 	snd_soc_dapm_sync(dapm);
 
@@ -2852,11 +2852,11 @@ EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
 int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	char preload[32];
 
 	snprintf(preload, ARRAY_SIZE(preload), "DSP%d Preload", dsp->num);
-	snd_soc_dapm_disable_pin(dapm, preload);
+
+	snd_soc_component_disable_pin(component, preload);
 
 	wm_adsp2_init_debugfs(dsp, component);
 
-- 
2.17.0
