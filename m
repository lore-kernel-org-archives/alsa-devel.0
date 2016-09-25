From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Make DSP preloader a supply
	widget" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:20 -0700
Message-ID: <E1bo2SC-0002ve-KA@finisterre>
References: <1474375956-10443-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2482D2665B1
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:35 +0200 (CEST)
In-Reply-To: <1474375956-10443-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Make DSP preloader a supply widget

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5ca7e170e331781fe71acb4919667993bb9fbab6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 20 Sep 2016 13:52:31 +0100
Subject: [PATCH] ASoC: wm_adsp: Make DSP preloader a supply widget

Currently the DSP loading is split into two widgets, the preloader that
is a snd_soc_dapm_dai_link widget which starts a thread to download
the firmware, and the DSP itself which is a snd_soc_dapm_out_drv and
synchronises the thread back in to the DAPM sequence. This allows the
firmware download to be overlapped with the rest of the path bring up.

The use of a snd_soc_dapm_dai_link widget requires the preloader to be part
of the audio path in DAPM, really a supply widget is a better fit for the
preloader. The preloader is something that needs to be done for the DSP to
function, not a part of the audio path itself.

This change makes the DSP preloader widget a supply widget, which as well
as probably being a better fit will also make it much simpler to power up
the preloader widget to trigger firmware download to the core independently
of the audio path coming up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 16 ++++++++--------
 sound/soc/codecs/wm_adsp.h |  5 +++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index e49955d834f0..850aa338ba29 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -191,20 +191,20 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 #define ARIZONA_DSP_ROUTES(name) \
 	{ name, NULL, name " Preloader"}, \
 	{ name " Preloader", NULL, "SYSCLK" }, \
-	{ name " Preloader", NULL, name " Aux 1" }, \
-	{ name " Preloader", NULL, name " Aux 2" }, \
-	{ name " Preloader", NULL, name " Aux 3" }, \
-	{ name " Preloader", NULL, name " Aux 4" }, \
-	{ name " Preloader", NULL, name " Aux 5" }, \
-	{ name " Preloader", NULL, name " Aux 6" }, \
+	{ name, NULL, name " Aux 1" }, \
+	{ name, NULL, name " Aux 2" }, \
+	{ name, NULL, name " Aux 3" }, \
+	{ name, NULL, name " Aux 4" }, \
+	{ name, NULL, name " Aux 5" }, \
+	{ name, NULL, name " Aux 6" }, \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 1"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 2"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 3"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 4"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 5"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 6"), \
-	ARIZONA_MIXER_ROUTES(name " Preloader", name "L"), \
-	ARIZONA_MIXER_ROUTES(name " Preloader", name "R")
+	ARIZONA_MIXER_ROUTES(name, name "L"), \
+	ARIZONA_MIXER_ROUTES(name, name "R")
 
 #define ARIZONA_EQ_CONTROL(xname, xbase)                      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 6a054e744068..228b1f9e9a68 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -87,9 +87,10 @@ struct wm_adsp {
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
 #define WM_ADSP2(wname, num, event_fn) \
-{	.id = snd_soc_dapm_dai_link, .name = wname " Preloader", \
+{	.id = snd_soc_dapm_supply, .name = wname " Preloader", \
 	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
-	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
+	.subseq = 100, /* Ensure we run after SYSCLK supply widget */ }, \
 {	.id = snd_soc_dapm_out_drv, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
-- 
2.9.3
