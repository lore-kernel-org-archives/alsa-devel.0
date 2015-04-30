From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/5] ASoC: dapm: Add support for
	autodisable mux controls
Date: Thu, 30 Apr 2015 19:48:09 +0200
Message-ID: <55426AD9.7080302@metafoo.de>
References: <1430411912-6599-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430411912-6599-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-225.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 13FD8260418
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 19:48:11 +0200 (CEST)
In-Reply-To: <1430411912-6599-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/30/2015 06:38 PM, Charles Keepax wrote:
[...]
> @@ -354,6 +355,34 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
>   			}
>   		}
>   		break;
> +	case snd_soc_dapm_mux:
> +		e = (struct soc_enum *)kcontrol->private_value;
> +
> +		if (e->autodisable) {
> +			struct snd_soc_dapm_widget template;
> +
> +			memset(&template, 0, sizeof(template));
> +			template.reg = e->reg;
> +			template.mask = e->mask << e->shift_l;
> +			template.shift = e->shift_l;
> +			template.off_val = e->values[0];

I think we should handle the case where e->values is NULL. In which case 
off_val should just be 0.

> +			template.on_val = template.off_val;
> +			template.id = snd_soc_dapm_kcontrol;
> +			template.name = name;
> +
[...]

> @@ -3002,10 +3034,10 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
>
>   	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
>
> +	change = dapm_kcontrol_set_value(kcontrol, val);
> +
>   	if (e->reg != SND_SOC_NOPM)
>   		change = soc_dapm_test_bits(dapm, e->reg, mask, val);
> -	else
> -		change = dapm_kcontrol_set_value(kcontrol, val);
>

This probably needs the same logic as in snd_soc_dapm_put_volsw() to 
correctly handle the case where the hardware state and the software state 
might be out of sync.

>   	if (change) {
>   		if (e->reg != SND_SOC_NOPM) {
>
/
