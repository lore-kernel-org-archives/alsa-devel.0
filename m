From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Mon, 17 Mar 2014 15:28:49 +0200
Message-ID: <5326F891.7090906@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
 <532588A3.4050301@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DF1D26171B
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 14:28:53 +0100 (CET)
In-Reply-To: <532588A3.4050301@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/16/2014 01:18 PM, Lars-Peter Clausen wrote:
> On 03/14/2014 03:42 PM, Peter Ujfalusi wrote:
>> We need to place constraint on the period and buffer size if the read
>> or write AFIFO is enabled and it is configured for more than one word
>> otherwise the DMA will fail in buffer configuration where the sizes
>> are not aligned with the requested FIFO configuration.
>>
>> Some application (like mplayer) needs the constraint placed on the
>> buffer size as well. If only period size is constrained they might
>> fail to figure out the allowed buffer configuration.
> =

> Hm... the sound like there is still a bug somewhere. We constrain the buf=
fer
> size to be a multiple of the period size. If the period size is constrain=
t to
> be a multiple of a constant then the buffer size should automatically be
> constrained to be a multiple of constant * period count. And just constra=
ining
> the buffer size to be a multiple of the burst size still allows buffer si=
zes
> that are not a multiple of burst size * period count.

Yeah, aplay, PA is fine. mplayer however does things in a different manner.=
 I
use mplayer mainly to test PA (with -ao pulse) but sometimes I use it throu=
gh
ALSA and this is where I noticed the issue.

If I constrain only period_size mplayer will fail to set hw_params. If I on=
ly
constrain the buffer_size than we can have period_size which does not allign
with the FIFO settings.

I also tried to have snd_pcm_hw_rule_add() and using the snd_interval_step(=
) -
which need to be exported but mplayer fails with that also. It fails even i=
f I
add the rule for period and buffer size.

Also the constraint as it is currently is not optimal since it does not take
into account the number of channels as you pointed out.

>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   sound/soc/davinci/davinci-mcasp.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/sound/soc/davinci/davinci-mcasp.c
>> b/sound/soc/davinci/davinci-mcasp.c
>> index a01ae97c90aa..3ca6e8c4568a 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -720,6 +720,7 @@ static int davinci_mcasp_startup(struct
>> snd_pcm_substream *substream,
>>                    struct snd_soc_dai *dai)
>>   {
>>       struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
>> +    int afifo_numevt;
>>
>>       if (mcasp->version =3D=3D MCASP_VERSION_4)
>>           snd_soc_dai_set_dma_data(dai, substream,
>> @@ -727,6 +728,21 @@ static int davinci_mcasp_startup(struct
>> snd_pcm_substream *substream,
>>       else
>>           snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
>>
>> +    if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>> +        afifo_numevt =3D mcasp->txnumevt;
>> +    else
>> +        afifo_numevt =3D mcasp->rxnumevt;
> =

> Shouldn't this use the same calculation that's used to set dma_data->maxb=
urst?
> Also we should add this to the dmaengine PCM driver, since there will most
> likely be more DMA controllers with this restriction, doesn't necessarily=
 need
> to be done in this patch series though.

At startup time we do not know the number of channels going to be used. I'm
planning to improve this constraint handling in a coming series.
Using the afifo_numevt as step is not optimal since in case of stereo stream
the step should be (afifo_numevt / 2). afifo_numevt is the sample count and
not the frame count.

> =

>> +
>> +    if (afifo_numevt > 1) {
>> +        snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +                       SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
>> +                       afifo_numevt);
>> +
>> +        snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +                       SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
>> +                       afifo_numevt);
>> +    }
>> +
>>       return 0;
>>   }
>>
>>
> =



-- =

P=E9ter
