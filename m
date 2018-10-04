From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [alsa-devel] [PATCH linux-next v2 9/9] ASoC: rsnd: add busif
 property to dai stream
Date: Thu, 4 Oct 2018 11:43:18 +0900
Message-ID: <557e63d1-dbb7-4232-b53e-4a5499024180@mentor.com>
References: <20181003090136.4556-1-jiada_wang@mentor.com>
 <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/10/04 10:41, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> in GEN3 SSI may use different BUSIF for data transfer,
>> this patch adds busif property to each dai stream,
>> to indicate the BUSIF used by playback/capture stream.
>>
>> Also adds rsnd_ssi_select_busif() to automatically select
>> BUSIF (currently only BUSIF0 is selected)
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   sound/soc/sh/rcar/core.c |  3 +++
>>   sound/soc/sh/rcar/dma.c  | 31 +++++++++++++++++++++++++++++++
>>   sound/soc/sh/rcar/rsnd.h |  3 +++
>>   sound/soc/sh/rcar/ssi.c  | 30 +++++++++++++++++++++++++++++-
>>   4 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
>> index 40d7dc4f7839..5e3e6e65bcdf 100644
>> --- a/sound/soc/sh/rcar/core.c
>> +++ b/sound/soc/sh/rcar/core.c
>> @@ -1158,6 +1158,9 @@ static int rsnd_hw_params(struct snd_pcm_substream *substream,
>>   	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
>>   	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
>>   	int ret;
>> +	int chan = rsnd_runtime_channel_for_ssi_with_params(io, hw_params);
>> +
>> +	rsnd_ssi_select_busif(io, chan);
> If my understanding was correct, the chance to use BUSIFx is when TDM split mode.
Yes, only when SSI works in Split/Ex-Split mode, BUSIFx other than 0 is 
necessary
> And this patch selects it on runtime (= hw_param) ?
Because, in order to automatically determine BUSIF number,
information like SSI mode (non-Split/Split/Ex-Split), runtime channel, 
are required
(in our internal implementation, SSI mode is selected by kctrl)
because of this, in this patch, BUSIF is selected on runtime

> But, I think we can/should select it on probe timing from DT connection.
> Am I misunderstanding ?
with the above reasoning, BUSIF is selected on runtime.
what do you think?

Thanks,
Jiada
> I'm not sure how to select, but adding new ssiuX0 - ssiuX7
> is realistic idea (parse sound card is not realistic...) ?
> If so, your rxu/txu DMA can be more simple ?
