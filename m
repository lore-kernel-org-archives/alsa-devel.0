From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Account for name prefixes when
	toggling preloader
Date: Tue, 24 Apr 2018 16:53:09 +0100
Message-ID: <20180424155309.12059-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 379072676AD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 17:53:12 +0200 (CEST)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Use the correct functions to allow a name prefix assigned through
codec_conf to be taken into consideration whilst enabling and disabling
the preloader widget.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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
2.11.0
