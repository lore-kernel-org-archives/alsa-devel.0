From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Mon, 24 Jan 2011 23:01:10 -0800
Message-ID: <4D3E7536.9070906@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4D2652C8.7030701@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam,

I have two more questions about your DSP topic branch

7. I see in sdp4430.c, SDP4430 MODEM front-end dailink no_host_mode is 
set to SND_SOC_DAI_LINK_NO_HOST. What is the purpose of no_host_mode?
Is it for use case that two physical devices can exchange audio data 
without host-processor intervention? If so, if user-space application 
tries to write to PCM buffer, will framework reject the buffer?

8. I see there is dmic codec(dmic.c) under sound/soc/codec which is 
pretty much just a dummy codec driver. I supposed the configuration of 
DMIC is done in other driver. Would it be better if we could have 
something like fixed voltage regulator? So, there is no need to 
duplicate the effort.

Look forward to seeing your reply soon

Thanks

On 1/6/2011 3:39 PM, Patrick Lai wrote:
> Hi Liam,
>
> I sync to your kernel DSP topic branch two days back in attempt to
> understand the up-coming ASOC DSP design. I have few questions to get
> clarification from you.
>
> 1. In the sdp4430.c, there are both FE dai link and BE dai link have
> omap-aess-audio as platform driver. How is omap-aess-audio platform
> driver used in both front-end and backend?
>
> 2. Front-end dai with stream name "Multimedia" has platform driver as
> omap-pcm-audio which is the DMA based. This front-end dai is mapped to
> backend (i.e PDM-DL1) with platform driver as omap-aess-audio.
> Omap-aess-audio looks to me is DSP platform driver. If a stream is DMA
> based, it seems strange to have DSP-based backend.
>
> 3. To best of my knowledge, I see in omap-abe.c which is the front end
> implementation. Playback_trigger() seems to go ahead enable all
> back-ends linked to the given front-end. However, front end may not be
> routed to all back-ends. Where in the code to make sure BE is only
> activated when a stream is being routed to that particular back-end?
>
> 4. omap-abe.c manages activation of BE DAIS and omap-abe-dsp.c manages
> routing of front-end to back-end DAPM widgets and routing map. Am I
> correct? This leads to previous question. How are two drivers working
> together to make sure BEs are only activated if Front-end has been
> routed to them?
>
> 5. Is there mechanism for front-end to switch between DMA and DSP
> platform driver? It looks to me that mapping of frond-end and platform
> driver is predetermined based on use case. For example, HDMI goes
> through DMA as legacy dailink.
>
> 6. struct abe_data has array member called dapm. It looks to me that
> this array simply tracks dapm components status but I don't see it's
> really being used in meaningful way in omap-abe-adsp.c.
>
> Thanks
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
