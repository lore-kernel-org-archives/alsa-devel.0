From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Skip noop reconfiguration of WM8958
	DSP2 algorithms
Date: Sun, 15 May 2011 21:18:15 -0700
Message-ID: <1305519496-23078-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 255C5243FC
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 06:18:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we're setting the currently applied value for one of the DSP algorithm
configurations we can just skip all the handling as the control set is a
noop. This ensures we do not disrupt a running DSP.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 5d4bc7a..ca26779 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -508,6 +508,9 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
+	if (wm8994->mbc_ena[mbc] == ucontrol->value.integer.value[0])
+		return 0;
+
 	if (ucontrol->value.integer.value[0] > 1)
 		return -EINVAL;
 
@@ -628,6 +631,9 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
+	if (wm8994->vss_ena[vss] == ucontrol->value.integer.value[0])
+		return 0;
+
 	if (ucontrol->value.integer.value[0] > 1)
 		return -EINVAL;
 
@@ -689,6 +695,16 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
+	if (hpf < 3) {
+		if (wm8994->hpf1_ena[hpf % 3] ==
+		    ucontrol->value.integer.value[0])
+			return 0;
+	} else {
+		if (wm8994->hpf2_ena[hpf % 3] ==
+		    ucontrol->value.integer.value[0])
+			return 0;
+	}
+
 	if (ucontrol->value.integer.value[0] > 1)
 		return -EINVAL;
 
@@ -782,6 +798,9 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
+	if (wm8994->enh_eq_ena[eq] == ucontrol->value.integer.value[0])
+		return 0;
+
 	if (ucontrol->value.integer.value[0] > 1)
 		return -EINVAL;
 
-- 
1.7.5.1
