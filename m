From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Question about your DSP topic branch
Date: Tue, 25 Jan 2011 16:46:13 +0000
Message-ID: <1295973973.3322.347.camel@odin>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B6D210398C
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 17:46:30 +0100 (CET)
Received: by wyi11 with SMTP id 11so5771823wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 08:46:28 -0800 (PST)
In-Reply-To: <4D3E7536.9070906@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Patrick,

CCing in Mark and alsa-devel@alsa-project.org (preferred list)

On Mon, 2011-01-24 at 23:01 -0800, Patrick Lai wrote:
> Hi Liam,
> 
> I have two more questions about your DSP topic branch
> 
> 7. I see in sdp4430.c, SDP4430 MODEM front-end dailink no_host_mode is 
> set to SND_SOC_DAI_LINK_NO_HOST. What is the purpose of no_host_mode?

No host mode means no audio is transferred to the host CPU in this case.
i.e. the MODEM routes audio directly between the DSP and mic/speaker.

This flags also tells the ASoC core that no DMA will be required, hence
the code in the DMA branch will not start any DMA. This part had to be
cleaned up for upstream.

> Is it for use case that two physical devices can exchange audio data 
> without host-processor intervention? If so, if user-space application 
> tries to write to PCM buffer, will framework reject the buffer?
> 

Yes, that's correct. The PCM core will also not complain here when it
receive no data either.

> 8. I see there is dmic codec(dmic.c) under sound/soc/codec which is 
> pretty much just a dummy codec driver. I supposed the configuration of 
> DMIC is done in other driver. Would it be better if we could have 
> something like fixed voltage regulator? So, there is no need to 
> duplicate the effort.
> 

Yeah, this is a generic DMIC driver. It's designed to have a very wide
coverage and should cover most DMICs out there. So it should also be
able to fit into your architecture too.

> Look forward to seeing your reply soon
> 
> Thanks
> 
> On 1/6/2011 3:39 PM, Patrick Lai wrote:
> > Hi Liam,
> >
> > I sync to your kernel DSP topic branch two days back in attempt to
> > understand the up-coming ASOC DSP design. I have few questions to get
> > clarification from you.
> >
> > 1. In the sdp4430.c, there are both FE dai link and BE dai link have
> > omap-aess-audio as platform driver. How is omap-aess-audio platform
> > driver used in both front-end and backend?
> >

The MODEM and Low Power (LP) Front Ends (FE) use the AESS platform
driver since they do not require DMA, whilts the other FE's use the
normal DMA platform driver since they do require DMA. 


> > 2. Front-end dai with stream name "Multimedia" has platform driver as
> > omap-pcm-audio which is the DMA based. This front-end dai is mapped to
> > backend (i.e PDM-DL1) with platform driver as omap-aess-audio.
> > Omap-aess-audio looks to me is DSP platform driver. If a stream is DMA
> > based, it seems strange to have DSP-based backend.
> >

The DMA is used to send the PCM data from the ALSA PCM device to the DSP
FIFO. 

> > 3. To best of my knowledge, I see in omap-abe.c which is the front end
> > implementation. Playback_trigger() seems to go ahead enable all
> > back-ends linked to the given front-end. However, front end may not be
> > routed to all back-ends. Where in the code to make sure BE is only
> > activated when a stream is being routed to that particular back-end?
> >

This is all done in soc-dsp.c now. We use the DAPM graph to work out all
valid routes from FE to BE and vice versa.

> > 4. omap-abe.c manages activation of BE DAIS and omap-abe-dsp.c manages
> > routing of front-end to back-end DAPM widgets and routing map. Am I
> > correct? 

Yes, although the routing management is now all in soc-dsp.c

> This leads to previous question. How are two drivers working
> > together to make sure BEs are only activated if Front-end has been
> > routed to them?
> >

soc-dsp.c now marshals all the PCM ops and makes sure that only valid
paths have their DAIs activated.


> > 5. Is there mechanism for front-end to switch between DMA and DSP
> > platform driver? It looks to me that mapping of frond-end and platform
> > driver is predetermined based on use case. For example, HDMI goes
> > through DMA as legacy dailink.

There is no way to dynamically switch platform drivers atm, but this can
be solved by having a mutually exclusive FE for each use case.

> >
> > 6. struct abe_data has array member called dapm. It looks to me that
> > this array simply tracks dapm components status but I don't see it's
> > really being used in meaningful way in omap-abe-adsp.c.
> >

It used by the OMAP4 ABE to work out the OPP power level and to work out
the routing between FE and BE.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
