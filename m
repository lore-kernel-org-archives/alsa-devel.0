From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: Add power down of widget powered up
	for suspend
Date: Mon, 23 Nov 2009 21:48:36 +0900
Message-ID: <4B0A84A4.7070300@samsung.com>
References: <4B0A216C.1030807@samsung.com>
	<20091123122232.GD24326@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F5F110380D
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 13:48:44 +0100 (CET)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KTK00KJ6BL0KX@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 23 Nov 2009 21:48:37 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KTK00MMZBL0QN@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 23 Nov 2009 21:48:36 +0900 (KST)
In-reply-to: <20091123122232.GD24326@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 11/23/2009 9:22 PM, Mark Brown wrote:
> On Mon, Nov 23, 2009 at 02:45:16PM +0900, Joonyoung Shim wrote:
>> If the widget was powered up when the device enters to the suspend, it
>> remains on because the power of the widget doesn't change, but we need
>> to power down the widget on suspend.
> 
> Hrm, yes - good spot, this got missed in the refactoring to make the
> bais maintinence less dependant on stream state.  However...
> 
>>  			power = w->power_check(w);
>> -			if (power)
>> +			if (power) {
>>  				sys_power = 1;
>> +				if (event == SND_SOC_DAPM_STREAM_SUSPEND)
>> +					power = 0;
>> +			}
> 
> We don't want to set sys_power here (since we want to bring the bias
> down to standby in preparatio for suspend) and we can skip the power
> check so something like the patch below ought to do the trick.  Could
> you test and let me know, please?
> 

OK, i missed about sys_power. I tested and below patch solves this issue 
too. I think your patch is better.

Thanks.

> That said, we probably want some more flexibility here for systems which
> want to suspend with bypass paths active.  They'll want to pause streams
> being directly driven by the CPU but leave any other paths active.  That
> would be a new feature, though.
> 

Then, is it possible that the bypass path is alive on suspend?

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index eaadb4b..0d294ef 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -977,9 +977,19 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
>  			if (!w->power_check)
>  				continue;
>  
> -			power = w->power_check(w);
> -			if (power)
> -				sys_power = 1;
> +			/* If we're suspending then pull down all the 
> +			 * power. */
> +			switch (event) {
> +			case SND_SOC_DAPM_STREAM_SUSPEND:
> +				power = 0;
> +				break;
> +
> +			default:
> +				power = w->power_check(w);
> +				if (power)
> +					sys_power = 1;
> +				break;
> +			}
>  
>  			if (w->power == power)
>  				continue;
> @@ -1003,8 +1013,12 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
>  		case SND_SOC_DAPM_STREAM_RESUME:
>  			sys_power = 1;
>  			break;
> +		case SND_SOC_DAPM_STREAM_SUSPEND:
> +			sys_power = 0;
> +			break;
>  		case SND_SOC_DAPM_STREAM_NOP:
>  			sys_power = codec->bias_level != SND_SOC_BIAS_STANDBY;
> +			break;
>  		default:
>  			break;
>  		}
> 
