From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] Add i.MX sound support
Date: Mon, 30 Nov 2009 14:19:42 +0100
Message-ID: <20091130131942.GR27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
	<20091127095416.GK27548@pengutronix.de>
	<eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
	<20091130124305.GQ27548@pengutronix.de>
	<eedb5540911300513j3730078v1393b9b42dca497b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1E2A710382D
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:19:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5540911300513j3730078v1393b9b42dca497b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 02:13:47PM +0100, javier Martin wrote:
> 2009/11/30 Sascha Hauer <s.hauer@pengutronix.de>
> 
> > On Mon, Nov 30, 2009 at 11:43:23AM +0100, javier Martin wrote:
> > > Hi Sascha,
> > > have you tested capture direction on an i.MX27 based board?
> > >
> > > I have been testing your patches in the place you suggested and playback
> > > seems to work fine but I have several problems with capture stream. I
> > found
> > > a BUG in the audmux_v1 code
> > > and I have fixed it but I am still having problems with capture. The file
> > > keeps empty and nothing is recorded.
> >
> > Capture works fine on my boards.
> >
> >
> >
> > > Please could you try the following on an i.MX27 based board?
> > >
> > > arecord -t raw -c 1 -f S16_LE test.wav
> >
> > Does it work with two channels? Do you use DMA or FIQ? Could you try the
> > other variant?
> >
> 
>  Unfortunately, I can't test it using two channels because our board has a
> wm8974 mono codec. Please could you point me how can I change between FIQ
> and DMA? I thought FIQ was only for AC97,

It's around line 662:


	if ((cpu_is_mx27() || cpu_is_mx21()) &&
			!(ssi->flags & IMX_SSI_USE_AC97)) {
		ssi->flags |= IMX_SSI_DMA;
		platform = imx_ssi_dma_mx2_init(pdev, ssi);
	} else
		platform = imx_ssi_fiq_init(pdev, ssi);

Just make sure IMX_SSI_DMA is cleared and imx_ssi_fiq_init() is called.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
