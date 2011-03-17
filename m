From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [alsa-devel] Question about your DSP topic branch
Date: Thu, 17 Mar 2011 00:21:57 -0700
Message-ID: <4D81B695.4020108@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org> <1295973973.3322.347.camel@odin> <4D4202AF.1090206@codeaurora.org> <4D7F1077.9030907@codeaurora.org> <20110315112531.GA17277@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110315112531.GA17277@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-msm@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 3/15/2011 4:25 AM, Mark Brown wrote:
> On Tue, Mar 15, 2011 at 12:08:39AM -0700, Patrick Lai wrote:
>
>> 1. If there are two front-ends routed to same backend, which front-end
>> hardware parameters should backend DAI be based on? For example, one
>> front-end is MONO and another front is stereo.
>
>> 2. Depending on device mode/use case, I would like to configure BE to
>> different channel mode irrespective of front-end configuration(i.e
>> configuring back-end to handset mode). Where is the hook to do so under
>> ASoC DSP framework?
>
> If you can configure the two completely separately then you can just
> have a DAPM path between the two devices and don't need to link the DAI
> configurations at all - WM8994 is an example of doing this, there is a
> bunch of DSP and mixing in the digital section between the DAIs but
> because the DSP includes sample rate conversion the DAIs can be
> configured separately and we don't have to worry about propagating DSP
> through.

Essentially, I have front-end DAI link represents PCM stream while
back-end DAI link represents physical hardware path. Irrespective
of PCM configuration of front-end DAI link, I want CPU DAI and CODEC
DAI of backend DAI link configured to the same PCM configuration. DSP
can handle resampling/downmixing. How to achieve this use case in
soc-dsp implementation is not obvious to me. In existing soc-dsp
implementation, back-end does not get activated unless front-end is
routed to back-end. Then, PCM parameters of front-end gets propagated
to CPU driver and codec driver of back-end DAI link. I don't see how I
would be able to pass PCM configuration specifically for back-end.

>
> One thing I should mention which I've been working on and which may
> (depending on the design of your hardware) be a better match for you is
> providing a mechanism for setting up DAI links and starting streams on
> them in kernel space based on DAPM routing, with DAPM propagating over
> these links automatically.  This is mostly intended for representing
> things like basebands where you'll have a DAI link that's going to be
> running in one of a small number of configurations (often only one)
> connected to something else along the lines of:
>
>     CODEC<   8kHz mono>   Baseband
>
> so the idea is that to the user you can have a couple of pin switches
> (or whatever else can be represented) in the baseband to say that the
> baseband is passing audio and then DAPM will be extended to figure out
> that it should start up the audio intefaces and configure their params
> without needing userspace to do it just like it can if the link between
> the two were analogue.
>

Yes, I do have use case in mind which requires functionality as you 
described to activate back-end DAI link without front-end DAI being
activated. DAPM seems to be most appropriate approach.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
