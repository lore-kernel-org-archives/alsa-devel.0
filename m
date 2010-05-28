From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Fri, 28 May 2010 13:27:12 +0100
Message-ID: <20100528122711.GA2486@opensource.wolfsonmicro.com>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DACE24402
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 14:27:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100528020621.GA12531@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, gnutoo <GNUtoo@no-log.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 12:06:25PM +1000, Stuart Longland wrote:

> I have a userspace application that mmaps the registers for SSI2 and
> AUDMUX, and sets this up, so no big deal ... the clock it receives is
> about 12.1MHz (12.093MHz according to the frequency counter here).

In production this should be done in-kernel.

> When I try to play audio; the AUDMUX configuration is as follows:

> Port:   imx-ssi.0
> Raw:    cb205000
> TxFS output from SSI4, TxClk output from SSI4
> Port is symmetric
> Data received from SSI4

> Port:   SSI4
> Raw:    00001000
> TxFS input, TxClk input
> Port is symmetric
> Data received from imx-ssi.0

This appears reasonable at first glance.

> I'll have a look at the Eukrea CPUIMX27 and baseboard SoC support in a
> moment, since it looks very similar to what we're doing (in that it's a
> TI I=B2S CODEC hooked to an i.MX27 on SSI4) ... this might reveal clues
> as to what I'm doing wrong.

Have you also checked the pin mux configuration for the i.MX?
