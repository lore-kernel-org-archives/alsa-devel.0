From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: wm_adsp: Make DSP preloader a supply
	widget
Date: Tue, 20 Sep 2016 13:52:31 +0100
Message-ID: <1474375956-10443-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AE53266D0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:37 +0200 (CEST)
In-Reply-To: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/arizona.h | 16 ++++++++--------
 sound/soc/codecs/wm_adsp.h |  5 +++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index c3daa07..9d0997b 100644
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
index be3b5bc..a3b1b7e 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -85,9 +85,10 @@ struct wm_adsp {
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
2.1.4
