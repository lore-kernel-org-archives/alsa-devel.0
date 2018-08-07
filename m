From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Correct DSP pointer for
	preloader control
Date: Tue, 7 Aug 2018 18:30:42 +0100
Message-ID: <20180807173042.22501-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E10A267898
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 19:30:45 +0200 (CEST)
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
Cc: ajit.pandey@cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Ajit Pandey <ajit.pandey@cirrus.com>

The offset of the DSP core needs to be taken into account for the DSP
preloader control get and put. Currently the dsp->preloaded variable
will only ever be read/updated on the first DSP, whilst this doesn't
affect the operation of the control the readback will be incorrect.

Signed-off-by: Ajit Pandey <ajit.pandey@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3bc1bb5504a1..ae131376cea1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2665,7 +2665,10 @@ int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 
 	ucontrol->value.integer.value[0] = dsp->preloaded;
 
@@ -2677,10 +2680,11 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 	char preload[32];
 
 	snprintf(preload, ARRAY_SIZE(preload), "DSP%u Preload", mc->shift);
-- 
2.11.0
