From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: ASoC HDMI receiver driver
Date: Thu, 30 Oct 2014 16:13:10 -0700
Message-ID: <CAJ+vNU1KEyYNYcZzCn_mcSrSVf+EVehLK0n0utPSZ9WCfEPEPQ@mail.gmail.com>
References: <CAJ+vNU2mwrdkBsKU8k+8c1_yruSfSckjqe9A-_JDv4pkTbK4XA@mail.gmail.com>
 <5451EB8E.9050203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 97DA326064A
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 00:13:11 +0100 (CET)
Received: by mail-ie0-f173.google.com with SMTP id tr6so171310ieb.32
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:13:10 -0700 (PDT)
In-Reply-To: <5451EB8E.9050203@metafoo.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2014 at 12:41 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/30/2014 04:34 AM, Tim Harvey wrote:
>> Greetings,
>>
>> I'm working on an ASoC driver (an mfd driver for an HDMI receiver chip
>> with an accompanying codec driver for the audio capture portion, and a
>> cpu-dai driver for the specific SoC its hooked to). I can't seem to
>> figure out what kind of hook I need in order to fill out the
>> snd_pcm_substream fields specifying the rate/channels/sample-format of
>> the receiving HDMI audio stream. In this case HDMI audio (and thus the
>> codec) supports several rates but it doesn't make sense that the codec
>> is told what rate to capture at as the rate is dictated by the current
>> stream the receiver is being provided. I'm thinking there is some hook
>> I'm missing that allows the codec to fill in the params dynamically
>> when the capture device is opened.
>>
>> Any pointers to how I deal with this?
>
> In the startup() callback of the CODEC driver you can apply additional
> constraints to the available parameter ranges. See
> snd_pcm_hw_constraints_... in include/sound/pcm.h
>
> E.g. to constrain the rate to one fixed value you could do
> snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, rate, rate);
>
> - Lars
>

Lars,

Thanks for the tip!

I found that if I add some validation into the hw_params function for
the codec, that I can return an -EINVAL if the requested params don't
match the incoming stream and that will cause the ALSA application to
at least error out.

However, when I saw your response I then also tried setting the
constraint and found that an invalid sample-rate gets 'refined' to the
available rate thus the hw_params sanity check passes, yet the user
application apparently does not feedback that the rate has been
changed.

For example if I do the following on a capture stream which is
actually 44.1kHz from the HDMI source with a constraint to set the
rate to 44100 the audio is played back at 44100 and has all kinds of
pops etc:

gst-launch alsasrc device="my-hdmi-receiver-card" !
audio/x-raw-int,rate=48000 ! queue ! alsasink device="playback-card"

Where-as the following plays back fine:

gst-launch alsasrc device="my-hdmi-receiver-card" !
audio/x-raw-int,rate=44100 ! queue ! alsasink device="playback-card"


I find that the value passed to startup in the substream is 48000
which gets refined to 44100 if the constraints were set, which ends up
passing hw_params 44100 but the 'application' still has issues.

I think its more appropriate to validate the hw_params instead of
using the constraints. Does this make sense?

Regards,

Tim
