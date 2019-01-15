From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Tue, 15 Jan 2019 08:06:17 +0000
Message-ID: <9b479bdb-2c29-86ad-1ea4-9f76b9b47f7b@axentia.se>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
 <4b8ce92c-9239-3a8a-f061-eb114050bd3a@axentia.se>
 <CAHEwa0BmUedqYR0Q0RtHtsHCqHCggtK75uY3hDcDzqAM8Qu4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30120.outbound.protection.outlook.com [40.107.3.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B142667F5
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 09:06:18 +0100 (CET)
In-Reply-To: <CAHEwa0BmUedqYR0Q0RtHtsHCqHCggtK75uY3hDcDzqAM8Qu4ZQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <54C3359E07A83645B327D21985E46B93@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2019-01-14 15:53, Dimitris Papavasiliou wrote:
> Thank you for your comments Peter.
> 
> On 1/14/19 1:13 PM, Peter Rosin wrote:> On 2019-01-13 21:16, Dimitris
> Papavasiliou wrote:
>>> Some boards, such as the HiFiBerry DAC+ Pro, use a pair of external
>>> oscillators, to generate 44.1 or 48kHz multiples and are forced to
>>
>> Ouch, is the PLL not fine-grained enough? That seems unlikely. Did
>> they perhaps simply not know how to wire the chip for the PLL to work?
> 
> There's a cheaper version of the board, which operates in slave
> mode, without external clocks.  My understanding, based on their
> marketing blurb, is that it's done in order to improve audio
> quality by minimizing clock jitter.  The datasheet mentions that
> using an external clock would be desirable, in order to "keep the
> jitter evident in the PLL (in all PLLs) out of the DAC", but it
> suggests using the external clock only for the DAC clock and the
> clocks derived from it and keep the PLL for the audio processing
> block.
> 
> Whether this would have been preferable, but they couldn't figure
> out how to get it to work, I can't really tell.  What I can say,
> is that the current design is causing all sorts of problems, none
> of which seem to be evident when the device is configured to run
> in slave mode.

Right, the slave part of the driver is way simpler than all the
nasty clock handling required when mastering the AIF...

>>> Notes:
>>>      The patch also includes a related change in the calculation of the
>>>      bclk divider.  The current calculation is not very clear to me, as I
>>>      can't find much concrete information on what this sample rate fraction
>>>      is, how it's calculated and how, therefore, its denominator would fit
>>>      into the calculation.  It also yields slightly wrong dividers in
>>>      certain cases, which the machine driver for my HiFiBerry DAC+ Pro
>>>      board seemingly tries to circumvent, by updating the rate fraction so
>>>      as to suit this calculation.
>>>
>>>      The updated calculation seems to work fine in my tests and, as far as
>>>      I can see, should correctly yield the smallest bit clock rate that
>>>      would fit the frame.  Please comment if anything looks off.
>>
>> On reading this, I think this should be a separate patch. But maybe that's
>> just me?
> 
> No, I also considered splitting this into two patches, but
> decided to keep the RFC in one piece, to keep the discussion in
> one place.  The patches are related after all, in the sense that
> it probably wouldn't make much sense to just change the
> calculation, if the set_bclk_ratio patch is rejected.  If the
> patch proves to be, in principle at least, acceptable, I'll
> probably submit it as two separate patches.
> 
>>> -    lrclk_div = snd_soc_params_to_frame_size(params);
>>> -    if (lrclk_div == 0) {
>>> -        dev_err(dev, "No LRCLK?\n");
>>> -        return -EINVAL;
>>> +    if (pcm512x->bclk_ratio > 0) {
>>> +        lrclk_div = pcm512x->bclk_ratio;
>>> +    } else {
>>> +        lrclk_div = snd_soc_params_to_frame_size(params);
>>> +
>>> +        if (lrclk_div == 0) {
>>> +            dev_err(dev, "No LRCLK?\n");
>>> +            return -EINVAL;
>>> +        }
>>>       }
>>>
>>>       if (!pcm512x->pll_out) {
>>>           sck_rate = clk_get_rate(pcm512x->sclk);
>>> -        bclk_div = params->rate_den * 64 / lrclk_div;
>>> -        bclk_rate = DIV_ROUND_CLOSEST(sck_rate, bclk_div);
>>> +        bclk_rate = params_rate(params) * lrclk_div;
>>> +        bclk_div = DIV_ROUND_CLOSEST(sck_rate, bclk_rate);
>>
>> Ok, so I apparently wrote this. Half a decade ago or so. It should be known
>> that my focus was entirely on the pll-case. I added the non-pll-case mostly
>> as a courtesy and we are not using it over here. If you don't have an even
>> divider, you should be using the pll anyway, right? :-) At least if you
>> knew you had to wire the HW so that the pll is an option... The datasheets
>> are not very clear, at least they were not way back when for the chip we
>> focused on (the pcm5142, big relief when I discovered the pcm5242
>> datasheet).
> 
> It's good to know this code path doesn't affect you.  The TSE-850
> seems to be the only driver using the pcm512x CODEC driver in the
> mainline kernel and I was worrying that the change might cause
> trouble for you.

Yes, we are typically only using a single sample frequency (250kHz)
and have naturally selected an external xtal so that the pll can be
avoided (sck is 16MHz, but since we have the pll option, the branch
you changed is not affecting our case). At least not if
pcm512x->bclk_ratio is left at zero (or set to 64)...

>>> +static int pcm512x_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
>>> +{
>>> +    struct snd_soc_component *component = dai->component;
>>> +    struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
>>> +
>>> +    pcm512x->bclk_ratio = ratio;
>>
>> You should perhaps check if (ratio >= 1 && ratio <= 256) prior to
>> accepting a divider that can't be programmed? But maybe that's enforced
>> somewhere else? And perhaps the sanity check should be even stricter?

...and when double-checking that, this dai op is only ever called from
snd_soc_dai_set_bclk_ratio, and that function is in turn not called from
anywhere AFAICT. What's the point of this dai op anyway? Or, what am I
missing?

Cheers,
Peter
