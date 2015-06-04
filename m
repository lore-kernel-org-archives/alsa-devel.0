From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Different codecs for playback and capture?
Date: Thu, 04 Jun 2015 16:54:27 +0200
Message-ID: <557066A3.7090804@metafoo.de>
References: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
 <556F0E7F.80802@metafoo.de>
 <alpine.DEB.2.02.1506041343450.15001@lnxricardw1.se.axis.com>
 <55705831.7060305@metafoo.de>
 <alpine.DEB.2.02.1506041607040.15001@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 845102606C8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 16:54:29 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1506041607040.15001@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 04:22 PM, Ricard Wanderlof wrote:
>
> On Thu, 4 Jun 2015, Lars-Peter Clausen wrote:
>
>>>> I'm not too sure how well it works if one CODEC is playback only and
>>>> the other is capture only and there might be some issues. But this is
>>>> the way to go and if there are problems fix them.
>>>
>>> It doesn't seem as if snd_soc_dai_link_component is used in any (in-tree)
>>> driver; a grep in sound/soc just returns soc-core.c . Perhaps some
>>> out-of-tree driver has been used to test it?
>>
>> This is the only example I'm aware of:
>> http://wiki.analog.com/resources/tools-software/linux-drivers/sound/ssm4567#multi_ssm4567_example_configuration
>
> Ok, thanks. As you mentioned previously this is an example of a left-right
> split codec configuration.
>
>> Even if your device does not have any configuration registers it will
>> still have constraints like the supported sample rates, sample-widths,
>> etc. You should create a driver describing these capabilities. This
>> ensures that the driver will work when the device is connected to a host
>> side CPU DAI that supports e.g. sample-rates outside the microphones
>> range. The AK4554 driver is an example of such a driver.
>
> Yes, makes sense.
>
> An mildly interesting aspect is that the resulting device doesn't belong
> to anything in the device tree, it just floats around by itself, as the
> device tree doesn't model I2S as a bus. A minor observation, don't know if
> it should be done differently.
>
>>> How are the different component codecs accessed when accessing the device?
>>> Or does this happen automatically? For instance, normally I would register
>>> one card with the single dai and coec, which would come up as #0, so I
>>> could access the resulting device with hw:0,0 . But when I have two codecs
>>> on the same dai_link, what mechanism does ALSA use to differentiate
>>> between the two? Or is it supposed to happen automatically depending on
>>> the capabilities of the respective codecs.
>>
>> It will be exposed as a single card with one capture and one playback PCM.
>> So it will be the same as if the CODEC side was only a single device
>> supporting both.
>
> Ok.
>
> I've experimented with this.
>
> The first problem is that the framework intersects the two codec drivers'
> capabilities, and since one of them supports playback only and the other
> capture only, the intersected rates and formats are always 0.
>
> I've fixed this by jumping out of the loop early in
> soc_pcm_init_runtime_hw() if the codec in question doesn't seem to support
> the mode (playback vs. capture) that's being considered, indicating that
> it doesn't care about the rate or format for that mode.
>
> Ideally it would have been some sort of 'if (!codec_stream->defined)' but
> there isn't such a member in struct snd_soc_dai . I've gone with 'if
> (!codec_stream->rates && !codec_stream->formats)', thinking that if a
> codec doesn't support any rates or formats, it probably doesn't support
> that mode at all (else it's rather meaningless). In fact, one of these
> (rates or formats) would probably suffice, with a comment explaining what
> we're really trying to do.
>
> The next problem is that when trying to set hw params, something in the
> framework or the individual codec driver hw_params() bails out saying it
> can't set the intended parameters. Looking at that right now to see if it
> can be solved in a similar way.

The best way to solve this is probably to introduce a helper function bool 
snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream) that 
implements the logic for detecting whether a DAI supports a playback or 
capture stream. And then whenever iterating over the codec_dais field for 
stream operations skip those which don't support the stream.

- Lars
