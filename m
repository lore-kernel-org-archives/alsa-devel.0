From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v2 8/9] ASoC: rsnd: ssi: Request dedicated dma
 channels for busif0 to 7
Date: Thu, 4 Oct 2018 12:00:29 +0900
Message-ID: <7d213396-a56e-e83d-7d0b-7edf49911b41@mentor.com>
References: <20181003090122.4508-1-jiada_wang@mentor.com>
 <87woqyplnr.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87woqyplnr.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/10/04 10:12, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> Currently ssi driver only request dma channel for SSI_0,
>> which is used to transfer data to/from busif0.
>>
>> But in GEN3 busif1 to busif7 also maybe used, dedicated dma channels
>> are requested for data transfer through these busif.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> (snip)
>> +	if (rsnd_ssi_use_busif(io)) {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rxu");
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "txu");
>> +
>> +		if (rsnd_is_gen3(priv)) {
>> +			/*
>> +			 * Gen3 supports to use all available BUSIF
>> +			 */
>> +			int busif = rsnd_ssi_get_busif(io);
>> +
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "%s%d", name, busif);
>> +		}
> I think unspecified GenX is better idea.
> For example, we might want to have same setting on Gen2 in the future.
> (and this is not Gen3 HW specific feature
>   But yes, we have SW side reason)
>
> How about like this ?
> We can keep compatibility, and both Gen2/Gen3 can use it.
>
> 	if (rsnd_ssi_use_busif(io)) {
> 		/*
> 		 * 1) try to find txu%d/rxu%d first
> 		 * 2) If can't find it, try to find old txu/rxu
> 		 */
> 	}
I think this is a good idea, by doing so,
in case GEN2 DT also starts to support different BUSIF,
then no driver side change is required.

I will update accordingly in next version

Thanks,
Jiada
