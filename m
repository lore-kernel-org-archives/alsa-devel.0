From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 08/19] ASoC: kirkwood: Don't set unused
 struct snd_pcm_hardware fields
Date: Wed, 01 Jan 2014 21:10:15 +0100
Message-ID: <52C47627.9080709@metafoo.de>
References: <20131230204209.109eca01@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D2A2610C5
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 21:10:01 +0100 (CET)
In-Reply-To: <20131230204209.109eca01@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/30/2013 08:42 PM, Jean-Francois Moine wrote:
>> On 12/20/2013 08:13 PM, Jean-Francois Moine wrote:
>>> On Fri, 20 Dec 2013 18:18:49 +0100
>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>   
>>>> On 12/20/2013 07:05 PM, Jean-Francois Moine wrote:  
>>>>>> diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
>>>>>> index 4af1936..aac22fc 100644
>>>>>> --- a/sound/soc/kirkwood/kirkwood-dma.c
>>>>>> +++ b/sound/soc/kirkwood/kirkwood-dma.c  
>>>>> 	[snip]  
>>>>>> @@ -43,12 +33,6 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
>>>>>>  		 SNDRV_PCM_INFO_MMAP_VALID |
>>>>>>  		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>>>>  		 SNDRV_PCM_INFO_PAUSE),
>>>>>> -	.formats		= KIRKWOOD_FORMATS,
>>>>>> -	.rates			= KIRKWOOD_RATES,
>>>>>> -	.rate_min		= 8000,
>>>>>> -	.rate_max		= 384000,
>>>>>> -	.channels_min		= 1,
>>>>>> -	.channels_max		= 8,
>>>>>>  	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
>>>>>>  	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
>>>>>>  	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,  
>>>>>
>>>>> Lars,
>>>>>
>>>>> You removed too many things. The 'formats' field is mandatory.  
>>>>
>>>> No it is not. While snd_soc_set_runtime_hwparams() uses it it is later
>>>> overwritten again in soc_pcm_init_runtime_hw().  
>>>
>>> I have a DPCM system and soc_pcm_init_runtime_hw() is not called
>>> (either 'dynamic' or 'no_pcm' is set in the DAI links).
>>
>> Ok, I see dpcm_set_fe_runtime() does things slightly different.
> 
> Well, I advanced a bit with DPCM, and I have a problem with this field.
> 
> In the driver, the front-end DAI is the audio controller and the
> back-ends DAIs are the HDMI and SPDIF outputs. These back-end DAIs
> have different rates and formats, as have the audio controller outputs
> (I2S and SPDIF). So, I used intermediate DAIs which represent the audio
> controller outputs, and they are described in the DAI links:
> 
> link 0 (FE): audio controller <-> dummy DAI
> link 1 (BE): i2s audio controller output <-> HDMI output
> link 2 (BE): spdif audio controller output <-> HDMI output
> link 3 (BE): spdif audio controller output <-> SPDIF output
> 
> Without any patch in the core, the rates and formats are always the
> rates and formats of the audio controller (FE). This is due to the
> 'goto dynamic' in soc_pcm_open(): as the back-ends are linked to real
> DAIs, the rate and format constraints must be checked. So, as a
> temporary patch, I replaced:
> 
> 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm)
> 		goto dynamic;
> by:
> 	if (rtd->dai_link->dynamic)
> 		goto dynamic;
> 
> (indeed, this will not work if the back-end is linked to the dummy DAI)
> 
> and, I get the correct rates and formats in the runtime hardware
> parameters. But these values are lost:
> 
> - on DMA open (FE pcm open), when the driver calls
>   snd_soc_set_runtime_hwparams() (loss of the formats), and
> 
> - on dpcm_set_fe_runtime() call (loss of the rates).
> 
> The first problem can be fixed in the audio controller by a hack,
> saving /restoring the formats on calling snd_soc_set_runtime_hwparams(),
> and the second problem is easily fixed moving dpcm_set_fe_runtime() at
> the beginning of dpcm_fe_dai_startup(). Are these good solutions?

This seems all to be very hackish. We clearly need to fix that DPCM only
considers the constraints of the FE DAI though.

The digital domain of a sound card can be thought of as a pipeline which
mostly operates on one sample at a time. The samples have two main
parameters, the frequency with which they are generated and their width.
Certain components in the pipeline have constraints on which parameters they
can work with. There are also components which can change the parameters,
e.g. a samplerate converter can change the frequency or a DAI might be able
to change the width. What we are interested in is for which parameters on
the PCM side are we able to build up a pipeline that satisfies all
constraints of all the components in the pipeline. I think this can be done
by walking the DAPM graph and collect the constraints associated with the
components in the path (The graph walking only has to be done when
components are added or removed). E.g. build up a list of all the the DAIs
that are reachable from a PCM and then use the constraints of those DAIs for
the PCM.

For starters we probably do not want support components which can change the
parameters for the sample stream. This is currently not supported in ASoC at
all and adding it will makes things more complex. But it should be kept in
mind, so it can be added in the next iteration. When calculating the
constraints we should probably also consider all possible paths and not only
active paths, since otherwise you'll run into problems if you want to change
the active path at runtime and the new configuration has more restrictive
constraints.

While we are at it we should probably also reduce the separation between
DPCM and clasic PCM as clasic PCM is just a special case (static routes) of
DPCM.

- Lars
