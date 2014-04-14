From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/17] ASoC: adau1373: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:30:56 +0200
Message-ID: <1397503872-20864-2-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9573D2656AE
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:20 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SOC_VALUE_ENUM, SND_SOC_DAPM_VIRT_MUX and SOC_DAPM_ENUM_VIRT are deprecated and
merely an alias for SOC_ENUM, SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the
deprecated macros so we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 877f573..1ff7d4d 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -519,8 +519,7 @@ static const struct snd_kcontrol_new adau1373_controls[] = {
 	SOC_ENUM("HPF Channel", adau1373_hpf_channel_enum),
 
 	SOC_ENUM("Bass HPF Cutoff", adau1373_bass_hpf_cutoff_enum),
-	SOC_VALUE_ENUM("Bass Clip Level Threshold",
-	    adau1373_bass_clip_level_enum),
+	SOC_ENUM("Bass Clip Level Threshold", adau1373_bass_clip_level_enum),
 	SOC_ENUM("Bass LPF Cutoff", adau1373_bass_lpf_cutoff_enum),
 	SOC_DOUBLE("Bass Playback Switch", ADAU1373_BASS2, 0, 1, 1, 0),
 	SOC_SINGLE_TLV("Bass Playback Volume", ADAU1373_BASS2, 2, 7, 0,
@@ -580,7 +579,7 @@ static SOC_ENUM_SINGLE_VIRT_DECL(adau1373_decimator_enum,
 	adau1373_decimator_text);
 
 static const struct snd_kcontrol_new adau1373_decimator_mux =
-	SOC_DAPM_ENUM_VIRT("Decimator Mux", adau1373_decimator_enum);
+	SOC_DAPM_ENUM("Decimator Mux", adau1373_decimator_enum);
 
 static const struct snd_kcontrol_new adau1373_left_adc_mixer_controls[] = {
 	SOC_DAPM_SINGLE("DAC1 Switch", ADAU1373_LADC_MIXER, 4, 1, 0),
@@ -694,7 +693,7 @@ static const struct snd_soc_dapm_widget adau1373_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("DMIC1", NULL, ADAU1373_DIGMICCTRL, 0, 0),
 	SND_SOC_DAPM_ADC("DMIC2", NULL, ADAU1373_DIGMICCTRL, 2, 0),
 
-	SND_SOC_DAPM_VIRT_MUX("Decimator Mux", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MUX("Decimator Mux", SND_SOC_NOPM, 0, 0,
 		&adau1373_decimator_mux),
 
 	SND_SOC_DAPM_SUPPLY("MICBIAS2", ADAU1373_PWDN_CTRL1, 5, 0, NULL, 0),
-- 
1.8.0
