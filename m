From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 15:42:07 +0100
Message-ID: <20100810144207.GD6416@rakim.wolfsonmicro.main>
References: <20100810133818.GL27749@pengutronix.de>
	<20100810134755.GC6416@rakim.wolfsonmicro.main>
	<1281449769.3059.62.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B112A244B6
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:42:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281449769.3059.62.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:16:09PM +0100, Liam Girdwood wrote:
> On Tue, 2010-08-10 at 14:47 +0100, Mark Brown wrote:

> > This is mostly a holdover from the existing (current mainline) ASoC
> > structuring at the minute, that also has the DMA configured per machine.
> > This may change depending on future hardware requirements, though.

> With multi-component it's possible to register both FIQ and DMA platform
> together. i.e. ssi0 could use DMA and ssi1 FIQ. 

Yup, although I think for pretty much all hardware the decision about
which DMA driver to use is going to be fixed by silicon consideratons
(eg, in the i.MX case it'd be odd to want to use the FIQ driver when
{S,}DMA support is available) so it probably does make sense for the
DAIs to be able to provide at least a default DMA controller.
