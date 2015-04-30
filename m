From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/5] ASoC: dapm: Add support for
	autodisable mux controls
Date: Thu, 30 Apr 2015 14:44:40 +0200
Message-ID: <554223B8.1040304@metafoo.de>
References: <1430390332-14037-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430390332-14037-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-225.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id DF8052614E0
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 14:44:36 +0200 (CEST)
In-Reply-To: <1430390332-14037-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On 04/30/2015 12:38 PM, Charles Keepax wrote:
> Commit 57295073b6ac ("ASoC: dapm: Implement mixer input auto-disable")
> added support for autodisable controls, controls whose values are only
> written to the hardware when their respective widgets are powered up.
> But it only added support for controls based on the mixer abstraction.
>
> This patch add support for mux controls (DAPM controls based on the
> enum abstraction) to be auto-disabled as well. As each mux can only have
> a single control, there is no need to tie the autodisable widget to the
> inputs (as is done for the mixer controls) it can be tided directly to
> the mux widget itself.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Looks pretty good.

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
> +			template.off_val = 0;

I've though about adding a auto-disable MUX type as well and the chip were I 
wanted to use it has a non-zero power-off value. So I'd like to be able to 
somehow specify this. We could for example put it at the end of the values 
array. E.g.

if (e->values)
	template.off_val = e->values[e->items].
else
	template.off_val = 0;

> +			template.on_val = template.off_val;
> +			template.id = snd_soc_dapm_kcontrol;
> +			template.name = name;
> +
> +			data->value = template.on_val;
> +
> +			data->widget = snd_soc_dapm_new_control(widget->dapm,
> +					&template);
> +			if (!data->widget) {
> +				ret = -ENOMEM;
> +				goto err_name;
> +			}
> +
> +			snd_soc_dapm_add_path(widget->dapm, data->widget,
> +					      widget, NULL, NULL);
> +		}
> +		break;
>   	default:
>   		break;
>   	}
