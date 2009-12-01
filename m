From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
Date: Tue, 1 Dec 2009 16:49:20 +0100
Message-ID: <20091201154920.GW27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
	<eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 573A62456A
	for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2009 16:49:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 06:09:24PM +0100, javier Martin wrote:
> 2009/11/30 javier Martin <javier.martin@vista-silicon.com>
> 
> > Dear Sascha,
> > in "imx_ssi_set_dai_fmt()" callback you should add something like:
> >
> >     /* sync */
> >     scr |= SSI_SCR_SYN;
> >
> > This would enable SSI working in SYN mode which means that RX and TX
> > sections will share same frame and bit clocks. Right now I can't imagine a
> > situation where this is not desirable. Moreover, if I don't add SYN mode I
> > cannot get it working in my i.mx27 based board with an wm8974.
> >
> 
> Well, after a chat with Mark it seems that it is not so uncommon that RX and
> TX sections have different clocks. So you could add a flag in the platform
> data similar to the one that switches between FIQ and DMA so that people can
> choose if they want the feature or not.

Ok, will do. I myself use the asynchronous mode. The MC13783 I use has
two SSI ports, one for capture and one for playback. I route both ports
to the same SSI unit using the audio muxer.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
