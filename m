From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next 01/10] ASoC: rsnd: ssi: Request dedicated dma
 channels for busif1 to 7
Date: Tue, 2 Oct 2018 16:52:24 +0900
Message-ID: <01535cc6-bd85-aec1-b0ce-7ea9e60533d0@mentor.com>
References: <20180927050407.17765-1-jiada_wang@mentor.com>
 <20180927050407.17765-2-jiada_wang@mentor.com>
 <87k1n6trsf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1n6trsf.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, dragos_tarcatu@mentor.com, twischer@de.adit-jv.com, tiwai@suse.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/09/28 9:08, Kuninori Morimoto wrote:
> Hi Jiada
> Cc: linux-renesas-soc ML
>
> Thank you for your patch
>
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> Currently ssi driver only request dma channel for SSI_0,
>> which is used to transfer data to/from busif0.
>>
>> But since busif1 to busif7 also maybe used, dedicated dma channels
>> are request for data transfer between these busif.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> (snip)
>> @@ -938,12 +940,20 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
>>   {
>>   	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
>>   	int is_play = rsnd_io_is_play(io);
>> -	char *name;
>> +	int busif = rsnd_ssi_get_busif(io);
>> +	char name[SSI_DMA_NAME_SIZE];
>>   
>> -	if (rsnd_ssi_use_busif(io))
>> -		name = is_play ? "rxu" : "txu";
>> -	else
>> -		name = is_play ? "rx" : "tx";
>> +	if (rsnd_ssi_use_busif(io)) {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
>> +	} else {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rx");
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "tx");
>> +	}
> Unfortunately, this patch breaks "git bisect", and Gen2 platforms.
> We need to keep existing "rxu/txu" more. Please consider compatibility.
> # we can remove it 2 or 3 version later ?
>
> If the commit which has this patch, but doesn't have [02/xx] or later,
> it can't use BUSIF.
>
> And your patch doesn't care Gen2 series.
> DT compatibility is very sensitive...
Thanks for your review comments, I will send out v2 patch set to take 
care of GEN2 series,
and move this patch after other DT related patches

Thanks,
Jiada
