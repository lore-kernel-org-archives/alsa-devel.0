From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 15:16:09 +0100
Message-ID: <1281449769.3059.62.camel@odin>
References: <20100810133818.GL27749@pengutronix.de>
	<20100810134755.GC6416@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 58EC324484
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:16:14 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3694955ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 07:16:13 -0700 (PDT)
In-Reply-To: <20100810134755.GC6416@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-10 at 14:47 +0100, Mark Brown wrote:
> On Tue, Aug 10, 2010 at 03:38:18PM +0200, Sascha Hauer wrote:
> 
> > I'm wondering what exactly a snd_soc_platform is. Apparently the
> > snd_pcm_ops/pcm_new/pcm_free are specific to a platform. For my
> > understanding these operations are more specific to a cpu_dai. Looking
> > at the tree it seems that each cpu_dai has exactly one possible
> > platform, which seems logical to me because the cpu_dai knows how to
> > transfer the data.
> 
> They're for the DMA bit of the CPU.  While most platforms have a single
> DMA controller (though some have more than one) it's moderately common
> to have more than one DAI (eg, dedicated I2S and DSP mode controllers
> rather than a programmable serial port, or an AC'97 controller) so it's
> useful to share the DMA code.
> 
> > My problem on i.MX is that I currently have two possible cpu dais
> > (imx-ssi.[01]) and each can be configured to use dma or fiq depending
> > on the dma capabilities. So the cpu_dai knows which pcm_ops we have
> > to use, but currently it's the soc glue code which has to decide in
> > platform_name. Am I understanding something wrong here?
> 
> This is mostly a holdover from the existing (current mainline) ASoC
> structuring at the minute, that also has the DMA configured per machine.
> This may change depending on future hardware requirements, though.
> _______________________________________________

With multi-component it's possible to register both FIQ and DMA platform
together. i.e. ssi0 could use DMA and ssi1 FIQ. 

So for OMAP4 I have two platforms. One is the SDMA driver and the other
a DSP. So I could have the following DAI link :-

static struct snd_soc_dai_link sdp4430_dai[] = {
	.name = "TWL6040-SDMA",
	.stream_name = "TWL6040",
	.cpu_dai_name ="omap-mcpdm-dai",
	.codec_dai_name = "twl6040-hifi",
	.platform_name = "omap-pcm-audio",  <<<< SDMA audio device
	.codec_name = "twl6040-codec",
	.init = sdp4430_twl6040_init,
	.ops = &sdp4430_ops,
}, {
	.name = "TWL6040-DSP",
	.stream_name = "TWL6040",
	.cpu_dai_name ="omap-mcpdm-dai",
	.codec_dai_name = "twl6040-hifi",
	.platform_name = "omap-dsp-audio",   <<< DSP audio device.
	.codec_name = "twl6040-codec",
	.init = sdp4430_twl6040_init,
	.ops = &sdp4430_ops,
};

The snd_soc_dai_set_dma_data() can be used to pass DMA type data between
the SSI ports and FIQ/SDMA components.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
