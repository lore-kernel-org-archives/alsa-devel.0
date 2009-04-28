From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/17] ASoC: Staticise TLV values in WM8940
Date: Tue, 28 Apr 2009 16:23:39 +0100
Message-ID: <1240932222-3718-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDD681038F9
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:46 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8940.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 26987dc..a66dacc 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -168,16 +168,16 @@ static const char *wm8940_filter_mode_text[] = {"Audio", "Application"};
 static const struct soc_enum wm8940_filter_mode_enum
 = SOC_ENUM_SINGLE(WM8940_ADC, 7, 2, wm8940_filter_mode_text);
 
-DECLARE_TLV_DB_SCALE(wm8940_spk_vol_tlv, -5700, 100, 1);
-DECLARE_TLV_DB_SCALE(wm8940_att_tlv, -1000, 1000, 0);
-DECLARE_TLV_DB_SCALE(wm8940_pga_vol_tlv, -1200, 75, 0);
-DECLARE_TLV_DB_SCALE(wm8940_alc_min_tlv, -1200, 600, 0);
-DECLARE_TLV_DB_SCALE(wm8940_alc_max_tlv, 675, 600, 0);
-DECLARE_TLV_DB_SCALE(wm8940_alc_tar_tlv, -2250, 50, 0);
-DECLARE_TLV_DB_SCALE(wm8940_lim_boost_tlv, 0, 100, 0);
-DECLARE_TLV_DB_SCALE(wm8940_lim_thresh_tlv, -600, 100, 0);
-DECLARE_TLV_DB_SCALE(wm8940_adc_tlv, -12750, 50, 1);
-DECLARE_TLV_DB_SCALE(wm8940_capture_boost_vol_tlv, 0, 2000, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_spk_vol_tlv, -5700, 100, 1);
+static DECLARE_TLV_DB_SCALE(wm8940_att_tlv, -1000, 1000, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_pga_vol_tlv, -1200, 75, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_alc_min_tlv, -1200, 600, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_alc_max_tlv, 675, 600, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_alc_tar_tlv, -2250, 50, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_lim_boost_tlv, 0, 100, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_lim_thresh_tlv, -600, 100, 0);
+static DECLARE_TLV_DB_SCALE(wm8940_adc_tlv, -12750, 50, 1);
+static DECLARE_TLV_DB_SCALE(wm8940_capture_boost_vol_tlv, 0, 2000, 0);
 
 static const struct snd_kcontrol_new wm8940_snd_controls[] = {
 	SOC_SINGLE("Digital Loopback Switch", WM8940_COMPANDINGCTL,
@@ -253,7 +253,7 @@ static const struct snd_kcontrol_new wm8940_mono_mixer_controls[] = {
 	SOC_DAPM_SINGLE("PCM Playback Switch", WM8940_MONOMIX, 0, 1, 0),
 };
 
-DECLARE_TLV_DB_SCALE(wm8940_boost_vol_tlv, -1500, 300, 1);
+static DECLARE_TLV_DB_SCALE(wm8940_boost_vol_tlv, -1500, 300, 1);
 static const struct snd_kcontrol_new wm8940_input_boost_controls[] = {
 	SOC_DAPM_SINGLE("Mic PGA Switch", WM8940_PGAGAIN, 6, 1, 1),
 	SOC_DAPM_SINGLE_TLV("Aux Volume", WM8940_ADCBOOST,
-- 
1.6.2.4
