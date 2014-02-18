From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 073/102] ASoC: wm8988: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:29 +0100
Message-ID: <1392723517-12772-46-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B88442655E5
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8988.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index c6e4aba25b77..0277a76c6bef 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -126,46 +126,46 @@ struct wm8988_priv {
  */
 
 static const char *bass_boost_txt[] = {"Linear Control", "Adaptive Boost"};
-static const struct soc_enum bass_boost =
-	SOC_ENUM_SINGLE(WM8988_BASS, 7, 2, bass_boost_txt);
+static SOC_ENUM_SINGLE_DECL(bass_boost,
+			    WM8988_BASS, 7, bass_boost_txt);
 
 static const char *bass_filter_txt[] = { "130Hz @ 48kHz", "200Hz @ 48kHz" };
-static const struct soc_enum bass_filter =
-	SOC_ENUM_SINGLE(WM8988_BASS, 6, 2, bass_filter_txt);
+static SOC_ENUM_SINGLE_DECL(bass_filter,
+			    WM8988_BASS, 6, bass_filter_txt);
 
 static const char *treble_txt[] = {"8kHz", "4kHz"};
-static const struct soc_enum treble =
-	SOC_ENUM_SINGLE(WM8988_TREBLE, 6, 2, treble_txt);
+static SOC_ENUM_SINGLE_DECL(treble,
+			    WM8988_TREBLE, 6, treble_txt);
 
 static const char *stereo_3d_lc_txt[] = {"200Hz", "500Hz"};
-static const struct soc_enum stereo_3d_lc =
-	SOC_ENUM_SINGLE(WM8988_3D, 5, 2, stereo_3d_lc_txt);
+static SOC_ENUM_SINGLE_DECL(stereo_3d_lc,
+			    WM8988_3D, 5, stereo_3d_lc_txt);
 
 static const char *stereo_3d_uc_txt[] = {"2.2kHz", "1.5kHz"};
-static const struct soc_enum stereo_3d_uc =
-	SOC_ENUM_SINGLE(WM8988_3D, 6, 2, stereo_3d_uc_txt);
+static SOC_ENUM_SINGLE_DECL(stereo_3d_uc,
+			    WM8988_3D, 6, stereo_3d_uc_txt);
 
 static const char *stereo_3d_func_txt[] = {"Capture", "Playback"};
-static const struct soc_enum stereo_3d_func =
-	SOC_ENUM_SINGLE(WM8988_3D, 7, 2, stereo_3d_func_txt);
+static SOC_ENUM_SINGLE_DECL(stereo_3d_func,
+			    WM8988_3D, 7, stereo_3d_func_txt);
 
 static const char *alc_func_txt[] = {"Off", "Right", "Left", "Stereo"};
-static const struct soc_enum alc_func =
-	SOC_ENUM_SINGLE(WM8988_ALC1, 7, 4, alc_func_txt);
+static SOC_ENUM_SINGLE_DECL(alc_func,
+			    WM8988_ALC1, 7, alc_func_txt);
 
 static const char *ng_type_txt[] = {"Constant PGA Gain",
 				    "Mute ADC Output"};
-static const struct soc_enum ng_type =
-	SOC_ENUM_SINGLE(WM8988_NGATE, 1, 2, ng_type_txt);
+static SOC_ENUM_SINGLE_DECL(ng_type,
+			    WM8988_NGATE, 1, ng_type_txt);
 
 static const char *deemph_txt[] = {"None", "32Khz", "44.1Khz", "48Khz"};
-static const struct soc_enum deemph =
-	SOC_ENUM_SINGLE(WM8988_ADCDAC, 1, 4, deemph_txt);
+static SOC_ENUM_SINGLE_DECL(deemph,
+			    WM8988_ADCDAC, 1, deemph_txt);
 
 static const char *adcpol_txt[] = {"Normal", "L Invert", "R Invert",
 				   "L + R Invert"};
-static const struct soc_enum adcpol =
-	SOC_ENUM_SINGLE(WM8988_ADCDAC, 5, 4, adcpol_txt);
+static SOC_ENUM_SINGLE_DECL(adcpol,
+			    WM8988_ADCDAC, 5, adcpol_txt);
 
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
@@ -317,16 +317,16 @@ static const struct snd_kcontrol_new wm8988_right_pga_controls =
 
 /* Differential Mux */
 static const char *wm8988_diff_sel[] = {"Line 1", "Line 2"};
-static const struct soc_enum diffmux =
-	SOC_ENUM_SINGLE(WM8988_ADCIN, 8, 2, wm8988_diff_sel);
+static SOC_ENUM_SINGLE_DECL(diffmux,
+			    WM8988_ADCIN, 8, wm8988_diff_sel);
 static const struct snd_kcontrol_new wm8988_diffmux_controls =
 	SOC_DAPM_ENUM("Route", diffmux);
 
 /* Mono ADC Mux */
 static const char *wm8988_mono_mux[] = {"Stereo", "Mono (Left)",
 	"Mono (Right)", "Digital Mono"};
-static const struct soc_enum monomux =
-	SOC_ENUM_SINGLE(WM8988_ADCIN, 6, 4, wm8988_mono_mux);
+static SOC_ENUM_SINGLE_DECL(monomux,
+			    WM8988_ADCIN, 6, wm8988_mono_mux);
 static const struct snd_kcontrol_new wm8988_monomux_controls =
 	SOC_DAPM_ENUM("Route", monomux);
 
-- 
1.8.5.2
