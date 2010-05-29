From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Sat, 29 May 2010 18:59:27 +1000
Message-ID: <20100529085927.GB657@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<20100528122711.GA2486@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 92B5B24533
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 10:59:34 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OIHtC-0004cr-43
	for alsa-devel@alsa-project.org; Sat, 29 May 2010 18:59:30 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OIHtB-0002bw-UO
	for alsa-devel@alsa-project.org; Sat, 29 May 2010 18:59:30 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OIHtB-0002bs-T8
	for alsa-devel@alsa-project.org; Sat, 29 May 2010 18:59:29 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OIHtA-0004c7-Kc
	for alsa-devel@alsa-project.org; Sat, 29 May 2010 18:59:29 +1000
Content-Disposition: inline
In-Reply-To: <20100528122711.GA2486@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, gnutoo <GNUtoo@no-log.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 01:27:12PM +0100, Mark Brown wrote:
> On Fri, May 28, 2010 at 12:06:25PM +1000, Stuart Longland wrote:
> =

> > I have a userspace application that mmaps the registers for SSI2 and
> > AUDMUX, and sets this up, so no big deal ... the clock it receives is
> > about 12.1MHz (12.093MHz according to the frequency counter here).
> =

> In production this should be done in-kernel.

Indeed... I spent some of yesterday afternoon doing exactly this...
which involved some hacking in arch/arm/mach-mx2/clocks_imx27.c... and a
_very_ ugly hack to get at the SSI2 registers in my machine driver.  It
works, but with a few bugs, and will need a big cleanup before I can
even consider putting it in mainline.

> > When I try to play audio; the AUDMUX configuration is as follows:
> =

> > Port:   imx-ssi.0
> > Raw:    cb205000
> > TxFS output from SSI4, TxClk output from SSI4
> > Port is symmetric
> > Data received from SSI4
> =

> > Port:   SSI4
> > Raw:    00001000
> > TxFS input, TxClk input
> > Port is symmetric
> > Data received from imx-ssi.0
> =

> This appears reasonable at first glance.
> =

> > I'll have a look at the Eukrea CPUIMX27 and baseboard SoC support in a
> > moment, since it looks very similar to what we're doing (in that it's a
> > TI I=B2S CODEC hooked to an i.MX27 on SSI4) ... this might reveal clues
> > as to what I'm doing wrong.
> =

> Have you also checked the pin mux configuration for the i.MX?

I'm not confident on how this is configured; but I have in an array;
tx27_pins[] (defined in arch/arm/mach-mx2/mach-tx27.c):

	/* SSI3 */
	PC28_PF_SSI3_FS,
	PC29_PF_SSI3_RXD,
	PC30_PF_SSI3_TXD,
	PC31_PF_SSI3_CLK,
	/* SSI4 */
	PC16_PF_SSI4_FS,
	PC17_PF_SSI4_RXD,
	PC18_PF_SSI4_TXD,
	PC19_PF_SSI4_CLK,

... which is later set up in tx27_board_init():
	mxc_gpio_setup_multiple_pins(tx27_pins, ARRAY_SIZE(tx27_pins),
			"tx27");

This is what I've seen done on other boards (my mach-tx27.c is based on
mach-mx27ads.c).
Regards,
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
