From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] add output/input widgets in ad1938 to make
	dac/adc dynamic PM work
Date: Wed, 12 Aug 2009 11:34:25 +0800
Message-ID: <1250048065-23433-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 722B424DA5
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 05:32:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the function dapm_dac_check_power() in
sound/soc/soc-dapm.c, dac power can't be on/off stand-alone without any
output widget as sink. And according to dapm_adc_check_power(), adc
power can't be on/off stand-alone without any input widget as source. So
we can't only define some stand-alone SND_SOC_DAPM_DAC/SND_SOC_DAPM_ADC
to hope their power can be managed dynamically.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad1938.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index aafda74..9b8cc5c 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -99,11 +99,23 @@ static const struct snd_soc_dapm_widget ad1938_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", "Playback", AD1938_DAC_CTRL0, 0, 1),
 	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD1938_ADC_CTRL0, 0, 1, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC4OUT"),
+	SND_SOC_DAPM_INPUT("ADC1IN"),
+	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
 
 static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC_PWR" },
+	{ "DAC1OUT", "DAC1 Switch", "DAC" },
+	{ "DAC2OUT", "DAC2 Switch", "DAC" },
+	{ "DAC3OUT", "DAC3 Switch", "DAC" },
+	{ "DAC4OUT", "DAC4 Switch", "DAC" },
+	{ "ADC", "ADC1 Switch", "ADC1IN" },
+	{ "ADC", "ADC2 Switch", "ADC2IN" },
 };
 
 /*
-- 
1.5.6.3
