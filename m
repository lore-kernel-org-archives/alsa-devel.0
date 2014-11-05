From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ad193x: Keep DAC output stage active in
	idle
Date: Wed,  5 Nov 2014 17:19:53 +0100
Message-ID: <1415204393-30970-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-121.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 47DA12606CA
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 17:19:53 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Setting the DAC power-down bit for the ad193x will also disable the DAC
output amplifier. This will cause audible clicks and pops when starting or
stopping playback. To prevent this a new widget is introduced that controls
the DAC power-down bit. This widget is connected to both the DAC and a newly
introduced VMID widget. This makes sure that the DAC power-down bit is not
set as long as a audio sink is connected to the DAC output. At the same time
the PLL and SYSCLK will still be disabled when no playback or capture stream
is active.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 6844d0b..387530b 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -72,11 +72,13 @@ static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget ad193x_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("DAC", "Playback", AD193X_DAC_CTRL0, 0, 1),
+	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_PGA("DAC Output", AD193X_DAC_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_SUPPLY("PLL_PWR", AD193X_PLL_CLK_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD193X_ADC_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("SYSCLK", AD193X_PLL_CLK_CTRL0, 7, 0, NULL, 0),
+	SND_SOC_DAPM_VMID("VMID"),
 	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
@@ -87,13 +89,15 @@ static const struct snd_soc_dapm_widget ad193x_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC", NULL, "SYSCLK" },
+	{ "DAC Output", NULL, "DAC" },
+	{ "DAC Output", NULL, "VMID" },
 	{ "ADC", NULL, "SYSCLK" },
 	{ "DAC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC_PWR" },
-	{ "DAC1OUT", NULL, "DAC" },
-	{ "DAC2OUT", NULL, "DAC" },
-	{ "DAC3OUT", NULL, "DAC" },
-	{ "DAC4OUT", NULL, "DAC" },
+	{ "DAC1OUT", NULL, "DAC Output" },
+	{ "DAC2OUT", NULL, "DAC Output" },
+	{ "DAC3OUT", NULL, "DAC Output" },
+	{ "DAC4OUT", NULL, "DAC Output" },
 	{ "ADC", NULL, "ADC1IN" },
 	{ "ADC", NULL, "ADC2IN" },
 	{ "SYSCLK", NULL, "PLL_PWR" },
-- 
1.8.0
