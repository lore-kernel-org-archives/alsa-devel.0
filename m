From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Thu, 27 Jan 2011 15:41:35 -0800
Message-ID: <4D4202AF.1090206@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org>	 <4D3E7536.9070906@codeaurora.org> <1295973973.3322.347.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1295973973.3322.347.camel@odin>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 1/25/2011 8:46 AM, Liam Girdwood wrote:
> Hi Patrick,
>
> CCing in Mark and alsa-devel@alsa-project.org (preferred list)
>
> On Mon, 2011-01-24 at 23:01 -0800, Patrick Lai wrote:
>> Hi Liam,
>>
>> I have two more questions about your DSP topic branch
>>
>> 7. I see in sdp4430.c, SDP4430 MODEM front-end dailink no_host_mode is
>> set to SND_SOC_DAI_LINK_NO_HOST. What is the purpose of no_host_mode?
>
> No host mode means no audio is transferred to the host CPU in this case.
> i.e. the MODEM routes audio directly between the DSP and mic/speaker.
>
> This flags also tells the ASoC core that no DMA will be required, hence
> the code in the DMA branch will not start any DMA. This part had to be
> cleaned up for upstream.
>
>> Is it for use case that two physical devices can exchange audio data
>> without host-processor intervention? If so, if user-space application
>> tries to write to PCM buffer, will framework reject the buffer?
>>
>
> Yes, that's correct. The PCM core will also not complain here when it
> receive no data either.

I experimented NO_HOST option and found platform driver pcm copy 
function is called. Is it part of the clean up you were talking about?

>> 8. I see there is dmic codec(dmic.c) under sound/soc/codec which is
>> pretty much just a dummy codec driver. I supposed the configuration of
>> DMIC is done in other driver. Would it be better if we could have
>> something like fixed voltage regulator? So, there is no need to
>> duplicate the effort.
>>
>
> Yeah, this is a generic DMIC driver. It's designed to have a very wide
> coverage and should cover most DMICs out there. So it should also be
> able to fit into your architecture too.
>
>> Look forward to seeing your reply soon
>>
>> Thanks
>>
>> On 1/6/2011 3:39 PM, Patrick Lai wrote:
>>> Hi Liam,
>>>
>>> I sync to your kernel DSP topic branch two days back in attempt to
>>> understand the up-coming ASOC DSP design. I have few questions to get
>>> clarification from you.
>>>
>>> 1. In the sdp4430.c, there are both FE dai link and BE dai link have
>>> omap-aess-audio as platform driver. How is omap-aess-audio platform
>>> driver used in both front-end and backend?
>>>
>
> The MODEM and Low Power (LP) Front Ends (FE) use the AESS platform
> driver since they do not require DMA, whilts the other FE's use the
> normal DMA platform driver since they do require DMA.
>
PCM functions inside omap-abe-dsp.c seem to do no-op if dai ID is not 
MODEM or LP. I guess reusing omap-aess-audio platform driver for the 
back-end DAI link serves purpose of architecture requirement that each 
DAI-LINK must have platform driver. Do I get the right impression?


>
>>> 2. Front-end dai with stream name "Multimedia" has platform driver as
>>> omap-pcm-audio which is the DMA based. This front-end dai is mapped to
>>> backend (i.e PDM-DL1) with platform driver as omap-aess-audio.
>>> Omap-aess-audio looks to me is DSP platform driver. If a stream is DMA
>>> based, it seems strange to have DSP-based backend.
>>>
>
> The DMA is used to send the PCM data from the ALSA PCM device to the DSP
> FIFO.
>
>>> 3. To best of my knowledge, I see in omap-abe.c which is the front end
>>> implementation. Playback_trigger() seems to go ahead enable all
>>> back-ends linked to the given front-end. However, front end may not be
>>> routed to all back-ends. Where in the code to make sure BE is only
>>> activated when a stream is being routed to that particular back-end?
>>>
>
> This is all done in soc-dsp.c now. We use the DAPM graph to work out all
> valid routes from FE to BE and vice versa.
>

I experimented dynamic routing. If issuing mixer command to route AIF_IN 
to AIF_OUT through mixer widget before starting playback, it works. 
Otherwise, I get I/O error from aplay. I think it's acceptable to 
require application to setup path before start of playback. For  device 
switch case, is it mandatory to route stream to the mixer of BE 
DAI-LINK2 before derouting stream out of mixer of BE DAI-LINK1?

>>> 4. omap-abe.c manages activation of BE DAIS and omap-abe-dsp.c manages
>>> routing of front-end to back-end DAPM widgets and routing map. Am I
>>> correct?
>
> Yes, although the routing management is now all in soc-dsp.c
>
>> This leads to previous question. How are two drivers working
>>> together to make sure BEs are only activated if Front-end has been
>>> routed to them?
>>>
>
> soc-dsp.c now marshals all the PCM ops and makes sure that only valid
> paths have their DAIs activated.
>
>
>>> 5. Is there mechanism for front-end to switch between DMA and DSP
>>> platform driver? It looks to me that mapping of frond-end and platform
>>> driver is predetermined based on use case. For example, HDMI goes
>>> through DMA as legacy dailink.
>
> There is no way to dynamically switch platform drivers atm, but this can
> be solved by having a mutually exclusive FE for each use case.
>
>>>
>>> 6. struct abe_data has array member called dapm. It looks to me that
>>> this array simply tracks dapm components status but I don't see it's
>>> really being used in meaningful way in omap-abe-adsp.c.
>>>
>
> It used by the OMAP4 ABE to work out the OPP power level and to work out
> the routing between FE and BE.
>
> Liam


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
