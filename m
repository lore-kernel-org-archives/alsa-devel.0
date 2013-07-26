From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Broken headphone and speaker amplifier supplies
 for the rt5640 driver
Date: Fri, 26 Jul 2013 10:57:53 -0600
Message-ID: <51F2AA91.1010400@wwwdotorg.org>
References: <51F29064.8080003@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 58E3A26088F
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 18:57:57 +0200 (CEST)
In-Reply-To: <51F29064.8080003@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bard Liao <bardliao@realtek.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/26/2013 09:06 AM, Lars-Peter Clausen wrote:
> Hi,
> 
> The rt5640 driver sets for both the headphone and speaker amplifier widget
> the shift to SND_SOC_NOPM, which is -1. This doesn't make much sense and
> breaks compilation with some changes I've made.
> 
> I guess for the heaphone amplifier the right fix is to set the shift to
> RT5640_PWR_HA_BIT ...

If I make those changes (see below for the exact patch I tried), then
both headphones and speakers do appear to still work fine. Bard will
have to comment on whether the changes are actually correct though:-)

> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index ce585e3..e3ab0b2 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -899,8 +899,6 @@ static int spk_event(struct snd_soc_dapm_widget *w,
>  
>  	switch (event) {
>  	case SND_SOC_DAPM_POST_PMU:
> -		regmap_update_bits(rt5640->regmap, RT5640_PWR_DIG1,
> -					0x0001, 0x0001);
>  		regmap_update_bits(rt5640->regmap, RT5640_PR_BASE + 0x1c,
>  					0xf000, 0xf000);
>  		break;
> @@ -908,8 +906,6 @@ static int spk_event(struct snd_soc_dapm_widget *w,
>  	case SND_SOC_DAPM_PRE_PMD:
>  		regmap_update_bits(rt5640->regmap, RT5640_PR_BASE + 0x1c,
>  					0xf000, 0x0000);
> -		regmap_update_bits(rt5640->regmap, RT5640_PWR_DIG1,
> -					0x0001, 0x0000);
>  		break;
>  
>  	default:
> @@ -1159,13 +1155,13 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
>  	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
>  		RT5640_PWR_MA_BIT, 0, NULL, 0),
>  	SND_SOC_DAPM_SUPPLY("Improve HP Amp Drv", RT5640_PWR_ANLG1,
> -		SND_SOC_NOPM, 0, NULL, 0),
> +		RT5640_PWR_HA_BIT, 0, NULL, 0),
>  	SND_SOC_DAPM_PGA("HP L Amp", RT5640_PWR_ANLG1,
>  		RT5640_PWR_HP_L_BIT, 0, NULL, 0),
>  	SND_SOC_DAPM_PGA("HP R Amp", RT5640_PWR_ANLG1,
>  		RT5640_PWR_HP_R_BIT, 0, NULL, 0),
>  	SND_SOC_DAPM_SUPPLY("Improve SPK Amp Drv", RT5640_PWR_DIG1,
> -		SND_SOC_NOPM, 0, spk_event,
> +		RT5640_PWR_CLS_D_BIT, 0, spk_event,
>  		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
>  	/* Output Lines */
>  	SND_SOC_DAPM_OUTPUT("SPOLP"),
