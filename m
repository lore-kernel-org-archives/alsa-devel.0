From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 14:47:55 +0100
Message-ID: <20100810134755.GC6416@rakim.wolfsonmicro.main>
References: <20100810133818.GL27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8DB24459
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 15:47:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100810133818.GL27749@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:38:18PM +0200, Sascha Hauer wrote:

> I'm wondering what exactly a snd_soc_platform is. Apparently the
> snd_pcm_ops/pcm_new/pcm_free are specific to a platform. For my
> understanding these operations are more specific to a cpu_dai. Looking
> at the tree it seems that each cpu_dai has exactly one possible
> platform, which seems logical to me because the cpu_dai knows how to
> transfer the data.

They're for the DMA bit of the CPU.  While most platforms have a single
DMA controller (though some have more than one) it's moderately common
to have more than one DAI (eg, dedicated I2S and DSP mode controllers
rather than a programmable serial port, or an AC'97 controller) so it's
useful to share the DMA code.

> My problem on i.MX is that I currently have two possible cpu dais
> (imx-ssi.[01]) and each can be configured to use dma or fiq depending
> on the dma capabilities. So the cpu_dai knows which pcm_ops we have
> to use, but currently it's the soc glue code which has to decide in
> platform_name. Am I understanding something wrong here?

This is mostly a holdover from the existing (current mainline) ASoC
structuring at the minute, that also has the DMA configured per machine.
This may change depending on future hardware requirements, though.
