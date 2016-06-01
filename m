From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs53l30: Rename the volume controls for
 preamplifier
Date: Wed, 1 Jun 2016 01:27:51 +0000
Message-ID: <D373A415.1446C%Paul.Handrigan@cirrus.com>
References: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Content-ID: <16B861F12298B842BE03147B204C4707@ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Austin, Brian" <Brian.Austin@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 5/31/16, 6:06 PM, "Nicolin Chen" <nicoleotsuka@gmail.com> wrote:

>Volume controls should end with 'Volume', so this patch renames them for
>ADC preamplifier.
>
>Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>---
> sound/soc/codecs/cs53l30.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 714e579..9aff449 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -331,10 +331,10 @@ static const struct snd_kcontrol_new
>cs53l30_snd_controls[] = {
> 	SOC_SINGLE_TLV("ADC2 NG Boost Volume", CS53L30_ADC2_NG_CTL,
> 		       CS53L30_ADCx_NG_BOOST_SHIFT, 1, 0, adc_ng_boost_tlv),
> 
>-	SOC_DOUBLE_R_TLV("ADC1 Pre Amp Gain", CS53L30_ADC1A_AFE_CTL,
>+	SOC_DOUBLE_R_TLV("ADC1 Preamplifier Volume", CS53L30_ADC1A_AFE_CTL,
> 			 CS53L30_ADC1B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
> 			 2, 0, pga_preamp_tlv),
>-	SOC_DOUBLE_R_TLV("ADC2 Pre Amp Gain", CS53L30_ADC2A_AFE_CTL,
>+	SOC_DOUBLE_R_TLV("ADC2 Preamplifier Volume", CS53L30_ADC2A_AFE_CTL,
> 			 CS53L30_ADC2B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
> 			 2, 0, pga_preamp_tlv),
> 
>-- 
>2.1.4

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
