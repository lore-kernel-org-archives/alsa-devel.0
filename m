From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/4] ASoC: fsi: Add FIFO size calculate
Date: Thu, 25 Mar 2010 08:56:14 +0000
Message-ID: <1269507374.3758.2.camel@odin>
References: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
	<uy6hi2q0f.wl%morimoto.kuninori@renesas.com>
	<1269424018.3798.29.camel@odin>
	<uk4t1unsy.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 881DE24541
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 09:56:20 +0100 (CET)
Received: by gwb15 with SMTP id 15so3525347gwb.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 01:56:19 -0700 (PDT)
In-Reply-To: <uk4t1unsy.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-25 at 11:39 +0900, Kuninori Morimoto wrote:

> 
> > > +	dev_dbg(dai->dev, "fifo = %d words\n", fsi->fifo_max);
> > > +
> > > +	for (i = 1; i < fsi->chan; i *= 2)
> > > +		if (fsi->chan > i)
> > > +			fsi->fifo_max >>= 1;
> > 
> > Is the if really needed here. You may also want to calculate the shift
> > size rather than looping too.
> 
> This calculate number of sample data.
> And it is depend on channel size.
> If chip fifo size is 256, the number of sample data will be...
> 
> 1 chan : 256 (256 x 1 = 256)
> 2 chan : 128 (128 x 2 = 256)
> 3 chan :  64 ( 64 x 3 = 192)
> 4 chan :  64 ( 64 x 4 = 256)
> 5 chan :  32 ( 32 x 5 = 160)
> 6 chan :  32 ( 32 x 6 = 192)
> 7 chan :  32 ( 32 x 7 = 224)
> 8 chan :  32 ( 32 x 8 = 256)
> 
> Above calculation is needed. but yes un-understandable.
> I don't know a method computable by one line.
> So, I will add tiny comment/document here.
> OK ?
> 

Yes, this sounds fine :)

It wasn't understandable from the original code.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
