From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 26 Jan 2012 07:12:07 -0600
Message-ID: <4F215127.8050509@linux.intel.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<002d01ccdb9c$7099f1e0$51cdd5a0$@bossart@linux.intel.com>
	<20120125201438.GA17032@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id B11B32437C
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 14:12:16 +0100 (CET)
In-Reply-To: <20120125201438.GA17032@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


>> I can see how this would simplify the loopback part, but doesn't it make the
>> 'regular' playback/capture functionality more complex? If my DSP is seen as
>> a CODEC, how do I represent the CPU-DSP interface (DMA or shared memory)?
>
> You'd need a DAI for that interface but you'll need that no matter what
> you do, it'll just be a very simple DAI that needs no configuration for
> things like AIF format.  With the soc-pcm setup you also need the front
> and back end DAIs so it's about the same, the benefit comes at runtime.
> My primary focus for the CODEC<->CODEC links is actually things like
> basebands rather than on-SoC DSPs, it's just that if the hardware can be
> thought of in the same way it should simplify things a little.

Bear with me here, I am still somewhat confused.
- Liam suggested either a hard-coded DAI configuration or machine driver 
logic to remove the need for virtual front-ends
- Mark suggested to consider the DSP as a CODEC with some work to 
re-implement the host-dsp interface.
Is this CODEC<->CODEC solution on top of the Dynamic PCM patches? Or are 
we talking about two completely different approaches?
Thanks for your feedback
-Pierre
