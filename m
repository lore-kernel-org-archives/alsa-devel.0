From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next 09/10] ASoC: rsnd: add busif property to dai
 stream
Date: Tue, 2 Oct 2018 16:58:24 +0900
Message-ID: <042e51bb-7c48-9145-51f2-b6687c044c19@mentor.com>
References: <20180927051212.18032-1-jiada_wang@mentor.com>
 <87in2qtr6f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87in2qtr6f.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, twischer@de.adit-jv.com, dragos_tarcatu@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/09/28 9:21, Kuninori Morimoto wrote:
> Hi Jiada
>
>
>> SSI may use different busif for data transfer, this patch
>> adds busif property to each dai stream, to indicate the
>> busif used by playback/capture stream.
> (snip)
>> +	io_playback->busif = rsnd_busif_get(priv, dai_i);
>> +	io_capture->busif  = rsnd_busif_get(priv, rsnd_rdai_nr(priv) + dai_i);
> (snip)
>> +	busif = devm_kcalloc(dev, 2 * nr, sizeof(*busif), GFP_KERNEL);
> (snip)
>> @@ -456,6 +456,7 @@ struct rsnd_dai_stream {
>>   	struct rsnd_mod *dma;
>>   	struct rsnd_dai *rdai;
>>   	struct device *dmac_dev; /* for IPMMU */
>> +	struct rsnd_kctrl_cfg_s *busif;
>>   	u32 parent_ssi_status;
>>   };
> It looks very complex to me.
> Why don't you just have "busif" on rsnd_dai_stream, instead of "*busif" ?
yes, it can be replaced with *busif instead,
but it will result in some reorder of declarations in rsnd.h
will update this patch in v2 patch set.

  Thanks,
Jiada
>>   int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
>>   {
>> -	return 0; /* BUSIF0 only for now */
>> +	if (!rsnd_ssi_use_busif(io))
>> +		return 0;
>> +
>> +	return io->busif->val;
>>   }
> Who/How update val ?
>
