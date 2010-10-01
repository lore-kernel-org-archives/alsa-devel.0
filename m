From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: Remove -dai suffix from i.MX SSI
	driver
Date: Fri, 1 Oct 2010 08:52:11 +0200
Message-ID: <20101001065211.GB784@pengutronix.de>
References: <1285879759-15750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285883482.3101.131.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 716511039D3
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 08:52:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285883482.3101.131.camel@odin>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 10:51:22PM +0100, Liam Girdwood wrote:
> On Thu, 2010-09-30 at 13:49 -0700, Mark Brown wrote:
> > While it is a generic serial port in practice the i.MX SSI is only supp=
orted
> > in Linux as an audio port (the i.MX has dedicated SPI controllers and s=
o on).
> > This means we don't need to disambiguate against other uses of the hard=
ware
> > and so can drop the -dai suffix from the driver name which fixes merge
> > issues with the i.MX tree in -next.
> > =

> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
