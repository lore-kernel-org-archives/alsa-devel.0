From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:07:29 +0000
Message-ID: <1327511249.11901.37.camel@odin>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CFAC2433C
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:07:35 +0100 (CET)
Received: by wics10 with SMTP id s10so3954311wic.19
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 09:07:32 -0800 (PST)
In-Reply-To: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-01-24 at 13:36 -0800, Pierre-Louis Bossart wrote:
> Hi,
> I've been doing some work on audio loopback (FM radio, BT, Modem -> audio
> codec), and I am somewhat confused by the soc-dsp programming model. Let me
> take the FM radio example:
> 
> If the FM radio is directly connected to the audio codec, my understanding
> is that changing the routing with codec controls will trigger the DAPM
> logic, which will turn on everything that needs to be on. Very simple, no
> matter if the FM-codec link is analog or digital.
> 

Yep, this is correct. soc-dsp (now know as Dynamic PCM) takes care of
any digital links that require the host CPU to perform any PCM or DAI
operations (based again on DAPM graph status). i.e. on OMAP we can start
the McBSP to FM Digital DAI based on the DAPM graph status and then
configure the link format, speed etc to optimal values for the ABE and
FM. 

It's not required for the analog path as DAPM will switch on the correct
components for FM analog to be played on the CODEC Speaker output.

> Now if the FM radio routing is handled with a digital loopback on the
> application processor audio dsp (omap-abe, Intel SST, etc), then soc-dsp
> will need to be used. And for a simple FM playback, I need to 
> 1. configure the audio codec routing for output selection 
> 2. open a virtual front-end for FM capture 
> 3. configure the DSP routing to link capture front-end to I2S1 backend (FM
> interface) 
> 4. open a virtual front-end for FM playback 
> 5. configure the DSP routing to link playback front-end to I2S2 backend
> (codec interface)
> 

Using Dynamic PCM here really depends on your hardware capabilities. On
OMAP, the host CPU configures and manages all DAIs so Dynamic PCM
manages the DAI and PCM operations. We also have the need to re-write
the hw_params and DAI formats between the FEs and BEs for optimum
performance.

> That seems complicated. To some extent, having the ability to have two
> back-ends connected together would make more sense, and would simplify the
> programming model a great deal. User-space code would be similar for
> loopbacks internal to the codecs or handled on the application processor.
> This would apply to Bluetooth and modem connections as well. Without this
> capability, we will end-up with multiple 'virtual' front-ends (6 in my
> case), making user-space code quite complex.

It's not really that much extra code, it's really just open(),
hw_params() and pcm_start() on the FE. Steps 1,3 & 5 are compulsory
anyway for any audio device, but we need to configure format, rate, DAI
clocking for the loopback. Having the FE PCM gives us this capability,
although we dont transfer any data to or from the host with the FE so
it's use is only for configuration.

We could eventually remove steps 2 and 4 for the FE DAI link, and look
at hard coding the hw_params() in the mach driver for the loopback link.
That way the only user space driven actions would be to configure the
mixers in the CODEC and DSP for the correct route. DAPM would then
detect the path and Dynamic PCM would use the hard coded configuration
or bespoke mach driver logic to configure the loopback DAI link based on
use case. This would have to be done after the basic Dynamic PCM
infrastructure was upstream though (unless you have a patch atm). 

> Looking at the current soc-dsp code, I saw that each back-end is supposed to
> have at least one front-end client, and the impact of my proposal seems
> fairly important. Before I start looking further into code changes, I wanted
> to see if my understanding is correct and if there are other ideas to
> simplify loopbacks.

Atm with the current code base we can support routing many FE PCMs to
many BE PCMs. We can support the BE loopback, but this does require the
FE to be opened atm in order to configure the DAI link. 

Regards

Liam
