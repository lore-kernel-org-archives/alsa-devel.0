From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next 1/1] ASoC: rsnd: ssiu: reset
	SSI_MODE register
Date: Mon, 30 Oct 2017 17:08:32 +0900
Message-ID: <3d8153c3-a8e1-93d8-daff-a4d37611e811@mentor.com>
References: <1509030462-4799-1-git-send-email-jiada_wang@mentor.com>
 <87d155ttv2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A19266CED
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 09:08:39 +0100 (CET)
In-Reply-To: <87d155ttv2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, gustavo@embeddedor.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san


On 10/30/2017 08:38 AM, Kuninori Morimoto wrote:
>
> Hi Jiada
>
>> register SSI_MODE is set when SSI works in TDM Extended or
>> TDM (Ex-)Split mode, but it isn't reset after SSI stops.
>> this will cause issue, if SSI starts to work in other modes
>> which requie SSI_MODE to have different value.
>>
>> This patch resets SSI_MODE register in .stop callback,
>> when last stream calls .stop.
>>
>> Fixes: 186fadc132f0 ("ASoC: rsnd: add TDM Extend Mode support")
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>  sound/soc/sh/rcar/ssiu.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
>> index 4d94875..eff9f3b 100644
>> --- a/sound/soc/sh/rcar/ssiu.c
>> +++ b/sound/soc/sh/rcar/ssiu.c
>> @@ -217,6 +217,8 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
>>  	if (rsnd_ssi_multi_slaves_runtime(io))
>>  		rsnd_mod_write(mod, SSI_CONTROL, 0);
>>
>> +	rsnd_mod_write(mod, SSI_MODE, 0);
>> +
>>  	return 0;
>>  }
>
> Thank you for your patch.
> But, I don't want to reset register when stop, because
> it might be point-less if SoC has power domain.
> How about this or similar (not tested) ?
>
> ------------------
> diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
> index 4d94875..8dc2e92 100644
> --- a/sound/soc/sh/rcar/ssiu.c
> +++ b/sound/soc/sh/rcar/ssiu.c
> @@ -130,14 +130,13 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
>  	if (ret < 0)
>  		return ret;
>
> -	if (rsnd_runtime_is_ssi_tdm(io)) {
> -		/*
> -		 * TDM Extend Mode
> -		 * see
> -		 *	rsnd_ssi_config_init()
> -		 */
> -		rsnd_mod_write(mod, SSI_MODE, 0x1);
> -	}
> +	/*
> +	 * TDM Extend Mode
> +	 * see
> +	 *	rsnd_ssi_config_init()
> +	 */
> +	rsnd_mod_write(mod, SSI_MODE,
> +		       rsnd_runtime_is_ssi_tdm(io) ? 0x1 : 0x0);

Thanks for your suggestion,
I will do some test for this change,
if it works fine, I will submit ver2 with it

Thanks,
Jiada
>
>  	if (rsnd_ssi_use_busif(io)) {
>  		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
>
>
> Best regards
> ---
> Kuninori Morimoto
>
