From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: TWL4030: change DAPMs for analog
 microphone selection
Date: Mon, 11 May 2009 20:41:49 +0900
Message-ID: <4A080EFD.80501@samsung.com>
References: <49F69B56.4000902@samsung.com>
	<200904300951.21620.peter.ujfalusi@nokia.com>
	<49F95130.3060004@samsung.com>
	<200905110953.35817.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B7FA3247B1
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 13:41:52 +0200 (CEST)
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KJH008JW9TP3P@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 11 May 2009 20:41:49 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KJH00GMG9TPJ6@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 11 May 2009 20:41:49 +0900 (KST)
In-reply-to: <200905110953.35817.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 5/11/2009 3:53 PM, Peter Ujfalusi wrote:
> On Thursday 30 April 2009 10:20:16 ext Joonyoung Shim wrote:
>> On 4/30/2009 3:51 PM, Peter Ujfalusi wrote:
>>> On Wednesday 29 April 2009 03:19:21 ext Joonyoung Shim wrote:
>>>> I read it at TRM too, but cannot believe it such mixer of outputs.
>>>>
>>>> Actually, i setted to 1 both HSMIC_EN bit and MAINMIC_EN bit for the
>>>> ANAMICL register, and recorded sound from headset mic and main mic. The
>>>> result is that both sounds are recorded.
>>>>
>>>> So, to be sure this part, can you inquire about it to TI side?
>>> I'll ask Ti about this and also about the output mixer/mux thing, just to
>>> be sure that we are not doing anything 'illegal' with those either.
>>>
>>> We should wait with this until Ti responds, I'll let you know what is
>>> their opinion...
>> Ok, i see.
>>
>> Thanks.
> 
> I got the response for this:
> On the output side: ear, predive, HS, Carkit is mixable, but the mixing is 
> summing and not averaging, so if the inputs are close to full, it may cause 
> saturation.
> 
> On the input side: you are right, the inputs can be mixed, but if we enable 
> more than one input at the same time, the input impedance of the input 
> amplifier will be reduced.
> 
> Just in case, can you resend the patch?
> 

Ok, i resend the patch. Thanks.

--
From: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Mon, 11 May 2009 20:36:08 +0900
Subject: [PATCH] ASoC: TWL4030: change DAPMs for analog microphone selection

The inputs of the twl4030 codec can be mixed, so we will use the mixer
DAPM for the analog microphone registers(0x05, 0x06), but if we enable
more than one input at the same time, the input impedance of the input
amplifier will be reduced.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c |   52 ++++++++++++++++---------------------------
 1 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd392c6..eaf91ab 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -422,36 +422,18 @@ static const struct snd_kcontrol_new twl4030_dapm_vibrapath_control =
 SOC_DAPM_ENUM("Route", twl4030_vibrapath_enum);
 
 /* Left analog microphone selection */
-static const char *twl4030_analoglmic_texts[] =
-		{"Off", "Main mic", "Headset mic", "AUXL", "Carkit mic"};
-
-static const unsigned int twl4030_analoglmic_values[] =
-		{0x0, 0x1, 0x2, 0x4, 0x8};
-
-static const struct soc_enum twl4030_analoglmic_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0, 0xf,
-			ARRAY_SIZE(twl4030_analoglmic_texts),
-			twl4030_analoglmic_texts,
-			twl4030_analoglmic_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_analoglmic_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_analoglmic_enum);
+static const struct snd_kcontrol_new twl4030_dapm_analoglmic_controls[] = {
+	SOC_DAPM_SINGLE("Main mic", TWL4030_REG_ANAMICL, 0, 1, 0),
+	SOC_DAPM_SINGLE("Headset mic", TWL4030_REG_ANAMICL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUXL", TWL4030_REG_ANAMICL, 2, 1, 0),
+	SOC_DAPM_SINGLE("Carkit mic", TWL4030_REG_ANAMICL, 3, 1, 0),
+};
 
 /* Right analog microphone selection */
-static const char *twl4030_analogrmic_texts[] =
-		{"Off", "Sub mic", "AUXR"};
-
-static const unsigned int twl4030_analogrmic_values[] =
-		{0x0, 0x1, 0x4};
-
-static const struct soc_enum twl4030_analogrmic_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0, 0x5,
-			ARRAY_SIZE(twl4030_analogrmic_texts),
-			twl4030_analogrmic_texts,
-			twl4030_analogrmic_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_analogrmic_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_analogrmic_enum);
+static const struct snd_kcontrol_new twl4030_dapm_analogrmic_controls[] = {
+	SOC_DAPM_SINGLE("Sub mic", TWL4030_REG_ANAMICR, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUXR", TWL4030_REG_ANAMICR, 1, 1, 0),
+};
 
 /* TX1 L/R Analog/Digital microphone selection */
 static const char *twl4030_micpathtx1_texts[] =
@@ -1138,11 +1120,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
 		SND_SOC_DAPM_POST_REG),
 
-	/* Analog input muxes with switch for the capture amplifiers */
-	SND_SOC_DAPM_VALUE_MUX("Analog Left Capture Route",
-		TWL4030_REG_ANAMICL, 4, 0, &twl4030_dapm_analoglmic_control),
-	SND_SOC_DAPM_VALUE_MUX("Analog Right Capture Route",
-		TWL4030_REG_ANAMICR, 4, 0, &twl4030_dapm_analogrmic_control),
+	/* Analog input mixers for the capture amplifiers */
+	SND_SOC_DAPM_MIXER("Analog Left Capture Route",
+		TWL4030_REG_ANAMICL, 4, 0,
+		&twl4030_dapm_analoglmic_controls[0],
+		ARRAY_SIZE(twl4030_dapm_analoglmic_controls)),
+	SND_SOC_DAPM_MIXER("Analog Right Capture Route",
+		TWL4030_REG_ANAMICR, 4, 0,
+		&twl4030_dapm_analogrmic_controls[0],
+		ARRAY_SIZE(twl4030_dapm_analogrmic_controls)),
 
 	SND_SOC_DAPM_PGA("ADC Physical Left",
 		TWL4030_REG_AVADC_CTL, 3, 0, NULL, 0),
-- 
1.6.0.4
