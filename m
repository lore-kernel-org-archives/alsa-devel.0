From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: S6000 ASoC drivers with multi-component
Date: Mon, 29 Nov 2010 10:42:29 +0000
Message-ID: <20101129104228.GM30360@rakim.wolfsonmicro.main>
References: <20101128120702.GA12683@opensource.wolfsonmicro.com>
	<4CF3819B.5040507@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB48824517
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 11:42:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CF3819B.5040507@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: Chris Zankel <chris@zankel.net>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 29, 2010 at 11:34:03AM +0100, Daniel Gl=F6ckner wrote:

> But trying to build a s6105 kernel from vanilla sources made me realize
> two things:
> 1. Nobody ever tried to do that before as s6000 support has been merged
>    incompletely and in some cases with merge errors (variant_irq_disable
>    declaration, I2C_BOARD_INFO in struct platform_device[], clk framework
>    missing completely).

Actually, Liam did try and fail when he was testing the changes.

> So for now I could just compile-test the ASoC changes. Actually booting a
> kernel will probably take more of my spare time..
> Would you like to have patches for the found ASoC bugs now or do you pref=
er
> waiting until I could make it work on hardware?

Just send stuff as you find it, no problem sending multiple patches and
it's less diff to carry.
