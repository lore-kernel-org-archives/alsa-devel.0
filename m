From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC HDMI receiver driver
Date: Fri, 31 Oct 2014 20:42:50 +0100
Message-ID: <5453E63A.20201@metafoo.de>
References: <CAJ+vNU2mwrdkBsKU8k+8c1_yruSfSckjqe9A-_JDv4pkTbK4XA@mail.gmail.com>	<5451EB8E.9050203@metafoo.de>	<CAJ+vNU1KEyYNYcZzCn_mcSrSVf+EVehLK0n0utPSZ9WCfEPEPQ@mail.gmail.com>	<5453C0C6.8010006@metafoo.de>
 <CAJ+vNU3529XZbr2b-mmc1O_+kVioE-r+mPnYue-7Q-AQagHh8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 83AE726148A
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 20:42:50 +0100 (CET)
In-Reply-To: <CAJ+vNU3529XZbr2b-mmc1O_+kVioE-r+mPnYue-7Q-AQagHh8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/31/2014 08:16 PM, Tim Harvey wrote:
> On Fri, Oct 31, 2014 at 10:03 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 10/31/2014 12:13 AM, Tim Harvey wrote:
>>>
>>> On Thu, Oct 30, 2014 at 12:41 AM, Lars-Peter Clausen <lars@metafoo.de>
>>> wrote:
>>>>
>>>> On 10/30/2014 04:34 AM, Tim Harvey wrote:
>>>>>
>>>>> Greetings,
>>>>>
>>>>> I'm working on an ASoC driver (an mfd driver for an HDMI receiver chip
>>>>> with an accompanying codec driver for the audio capture portion, and a
>>>>> cpu-dai driver for the specific SoC its hooked to). I can't seem to
>>>>> figure out what kind of hook I need in order to fill out the
>>>>> snd_pcm_substream fields specifying the rate/channels/sample-format of
>>>>> the receiving HDMI audio stream. In this case HDMI audio (and thus the
>>>>> codec) supports several rates but it doesn't make sense that the codec
>>>>> is told what rate to capture at as the rate is dictated by the current
>>>>> stream the receiver is being provided. I'm thinking there is some hook
>>>>> I'm missing that allows the codec to fill in the params dynamically
>>>>> when the capture device is opened.
>>>>>
>>>>> Any pointers to how I deal with this?
>>>>
>>>>
>>>> In the startup() callback of the CODEC driver you can apply additional
>>>> constraints to the available parameter ranges. See
>>>> snd_pcm_hw_constraints_... in include/sound/pcm.h
>>>>
>>>> E.g. to constrain the rate to one fixed value you could do
>>>> snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, rate,
>>>> rate);
>>>>
>>>> - Lars
>>>>
>>>
>>> Lars,
>>>
>>> Thanks for the tip!
>>>
>>> I found that if I add some validation into the hw_params function for
>>> the codec, that I can return an -EINVAL if the requested params don't
>>> match the incoming stream and that will cause the ALSA application to
>>> at least error out.
>>>
>>> However, when I saw your response I then also tried setting the
>>> constraint and found that an invalid sample-rate gets 'refined' to the
>>> available rate thus the hw_params sanity check passes, yet the user
>>> application apparently does not feedback that the rate has been
>>> changed.
>>>
>>> For example if I do the following on a capture stream which is
>>> actually 44.1kHz from the HDMI source with a constraint to set the
>>> rate to 44100 the audio is played back at 44100 and has all kinds of
>>> pops etc:
>>>
>>> gst-launch alsasrc device="my-hdmi-receiver-card" !
>>> audio/x-raw-int,rate=48000 ! queue ! alsasink device="playback-card"
>>>
>>> Where-as the following plays back fine:
>>>
>>> gst-launch alsasrc device="my-hdmi-receiver-card" !
>>> audio/x-raw-int,rate=44100 ! queue ! alsasink device="playback-card"
>>>
>>>
>>> I find that the value passed to startup in the substream is 48000
>>> which gets refined to 44100 if the constraints were set, which ends up
>>> passing hw_params 44100 but the 'application' still has issues.
>>>
>>> I think its more appropriate to validate the hw_params instead of
>>> using the constraints. Does this make sense?
>>
>>
>> No. By setting up the constraints you tell the userspace application which
>> parameters are supported. This allows the application to pick one of the
>> available parameters and then call hw_params() with it. Not setting up the
>> constraints and erroring out in hw_params() will cause applications to not
>> work. If the rate requested is not in the valid range the ALSA core should
>> actually already error out before the drivers hw_params() function is
>> called.
>>
>> - Lars
>>
>
> Lars,
>
> The rates I'm talking about are in the codecs advertised set of rates,
> so the ALSA core doesn't error out. The issue is that at runtime only
> one of the possible rates is valid.

I know.

>
> Lets take for example just 44100 and 48000. The codec advertises
> support for both via the rates field of snd_soc_dai_driver, but in the
> case of a 48000 khz source, only 48000 is valid and should be allowed.
> If I use gstreamer alsasrc to capture specifying 44100 then the codec
> driver constraint would refine this to 48000 yet gstreamer doesn't
> know this and still basis the rest of its functionality on the invalid
> 44100 sample-rate it specified, which causes buffering issues and more
> (if gstreamer is sending this data to an output device, it would have
> configured the output device for 44100 not knowing any better and you
> now have the data being played back at the wrong sample-rate).

Yea, that sounds like a bug in gstreamer alsasrc.

>
> Is this perhaps the fault of gstreamer alsasrc in that it is
> requesting 44100 but then not querying the stream to determine what it
> was actually given? I'm not very familiar with the ALSA userspace API
> but I would think that if you requested a specific rate that couldn't
> be supported it should return an error and not just be 'changed',

That's exactly what happens in ALSA. The kernel driver and the application 
go through a negotiation process for all the different parameters like 
sampl> That's exactly what happens in ALSA.
erate, number of channels, bits per channel, etc. If they can't agree this 
is treated as an error. So if gstreamer starts capturing it means it has 
agreed to the rate.

> which is what setting the constraint in the startup hook ends up
> doing.[...]

No, this is not how it works. The negotiation process starts with the kernel 
driver presenting a range of supported parameters to the application. E.g. 
for the samplerate the kernel can say I support 8000-48000. The userspace 
application can than use this and further refine it, e.g. say I want 32000 
for the samplerate.

The initial set of ranges that is presented to the userspace application is 
what the kernel driver sets up in the startup callback. So if you constrain 
the set of supported samplerates to exactly one rate the userspace 
application will never see any other supported rates.

The 'static' rates the you can specify in the snd_soc_dai_driver struct are 
just helpers to avoid boilerplate code. The core will setup constraints for 
those parameters, but they will be setup at the same time as the startup 
callback is called.

- Lars
