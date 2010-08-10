From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 15:49:29 +0100
Message-ID: <1281451769.3059.86.camel@odin>
References: <20100810133818.GL27749@pengutronix.de>
	<20100810134755.GC6416@rakim.wolfsonmicro.main>
	<1281449769.3059.62.camel@odin>
	<20100810144207.GD6416@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D05A244BD
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:49:43 +0200 (CEST)
Received: by eye27 with SMTP id 27so3685803eye.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 07:49:43 -0700 (PDT)
In-Reply-To: <20100810144207.GD6416@rakim.wolfsonmicro.main>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-10 at 15:42 +0100, Mark Brown wrote:
> On Tue, Aug 10, 2010 at 03:16:09PM +0100, Liam Girdwood wrote:
> > On Tue, 2010-08-10 at 14:47 +0100, Mark Brown wrote:
> 
> > > This is mostly a holdover from the existing (current mainline) ASoC
> > > structuring at the minute, that also has the DMA configured per machine.
> > > This may change depending on future hardware requirements, though.
> 
> > With multi-component it's possible to register both FIQ and DMA platform
> > together. i.e. ssi0 could use DMA and ssi1 FIQ. 
> 
> Yup, although I think for pretty much all hardware the decision about
> which DMA driver to use is going to be fixed by silicon consideratons
> (eg, in the i.MX case it'd be odd to want to use the FIQ driver when
> {S,}DMA support is available) so it probably does make sense for the
> DAIs to be able to provide at least a default DMA controller.

Yes, exactly - this was just an example showing two different DMA
controllers.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
