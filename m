From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Thu, 17 Sep 2015 16:30:30 -0700
Message-ID: <CAG5mAdwNjV19-5XYX-s6_3y0c9EHyo91UbKgLQ8=nxGh8o=PHA@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
 <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
 <20150917174242.GF12027@sirena.org.uk>
 <CAG5mAdziq11SJ3eAqDFcTEBuHJ-Rj6xwgu3kmqXC5HYOnDvYaA@mail.gmail.com>
 <CAG5mAdx+KSMfOjK2y+KKzkVjHb6HHE_W=Y_AuXE9kuom=_2Cww@mail.gmail.com>
 <20150917230025.GB16504@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F3882654B8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 01:30:51 +0200 (CEST)
Received: by igcpb10 with SMTP id pb10so24290953igc.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 16:30:49 -0700 (PDT)
In-Reply-To: <20150917230025.GB16504@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>
Cc: bernard.gautier@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 4:00 PM, James Cameron <quozl@laptop.org> wrote:
> On Thu, Sep 17, 2015 at 03:40:33PM -0700, Caleb Crome wrote:
>> The more I think of this channel synchronization issue, the
>> thorinier it gets.
>>
>> Basically, with the TLV320AIC series of codecs, whenever any of the
>> DAC or ADC channels are powered up on any codec, the MCLK needs to be
>> stopped, all DACs/ADCs turned off, then configuration can happen, then
>> all DACs/ADCs can be turned back on, then MCLK starts again.  That's
>> the only way to ensure phase/delay accuracy among several codecs.
>>
>> So, going from play-only to play+record requires MCLK be stopped, then
>> restarted.
>
> Aye.  Lots of clocks in lots of domains.  Also pay penalty of any
> delays needed to stabilise ADCs.
>
> Same general issue with many single codecs though, if capture vs
> playback synchronisation required.
>
>> Maybe it's not too terrible.  Any thoughts?
>
> In this scenario my preference would be to always configure the codecs
> and DMA for playback and capture, and do any gating higher in the
> stack; e.g. send zero samples if there is no playback stream, and
> discard samples if there is no capture stream.

Yes, this makes sense to me.  This is for this sort of special case
that I have where we have many synchronized codecs on the same bus.
It's really just 1 clock that needs to be gated -- the MCLK.

Is there any way for the machine driver to handle this?  Currently,
the AIC3x driver uses a dapm control to turn the ADCs and DACs on and
off.  Can the machine driver currently get some sort of pre and post
callback whenever particular controls are enabled?

I think to get through the day, I need to remove the
SND_SOC_DAPM_ADC("Left ADC", ...)
SND_SOC_DAPM_ADC("Right ADC", ...)
SND_SOC_DAPM_DAC("Left ...")
SND_SOC_DAPM_DAC("Right"
lines in tlv320aic3x, and just hard-wire them somewhere so they are
all always turned on.  Then I can make sure to turn on the clocks only
after all the codecs have been powered up and alsa thinks they are
configured.  I guess in the machine driver's trigger callback?

-Caleb








>
> --
> James Cameron
> http://quozl.linux.org.au/
