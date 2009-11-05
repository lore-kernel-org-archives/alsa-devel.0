From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Thu, 05 Nov 2009 20:08:30 +0000
Message-ID: <1257451710.3576.292.camel@odin>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
	<1257432930.3603.902.camel@odin>
	<20091105212822.2fab9974.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 765B6243C7
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 21:08:33 +0100 (CET)
Received: by ewy21 with SMTP id 21so965071ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 12:08:33 -0800 (PST)
In-Reply-To: <20091105212822.2fab9974.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-11-05 at 21:28 +0200, Jarkko Nikula wrote:

> 
> Actually BCLK doesn't have to be fixed as it is derived by dividing the
> CLKSRG with CLKGDV. This can allow to optimize the BCLK and frame size
> to be smaller when CLKSRG >> BCLK.
> 
> Would be nice if both the divider and frame size are calculated
> dynamically based on CLKSRG frequency and sample rate.
> 

This does sound like a useful feature and should probably exist in
soc-core for other platforms too.

> > I'm now slightly curious about how pandora handles different rates since
> > it uses the McBSP in master mode too. I guess they can only handle a
> > single sample rate ?
> > 
> IRCC correctly the external master clock used in Pandora was derived
> from the codec and that clock was following the sample rate.
> 

Makes sense now :)

Liam
