From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Fri, 10 Aug 2012 22:14:56 +0200
Message-ID: <20120810201456.GL25520@pengutronix.de>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 573922665D3
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 21:45:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120810195638.GF1451@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Aug 10, 2012 at 09:56:38PM +0200, Sascha Hauer wrote:
> On Fri, Aug 10, 2012 at 08:50:08PM +0100, Mark Brown wrote:
> > I'm trying to use -next to test AC'97 register I/O on an i.MX51 board
> > but I'm seeing the CPU hang during probe at:
> > =

> > 	lreg =3D (reg & 0x7f) <<  12 ;
> > 	writel(lreg, base + SSI_SACADD);
> > =

> > in imx_ssi_ac97_read().  I'm somewhat suspicious this might be because
> > the IP block isn't clocked properly, I do notice the recent conversion
> > to the clock API which looks rather involved but it's possible something
> > else broke.  Does anyone have any bright ideas what might be going on
> > here?  The board doesn't have the reste functions defined so this is the
> > first interaction with the hardware block AFAICT.
> =

> No idea currently, just adding Uwe to Cc because I think he has seen
> something similar on an i.MX35 board recently.
I havn't debugged that yet, but one issue I think needs to be solved is
that since the clk conversion there are two ssi clocks. And from a quick
look the ssi driver only handles one of them.

Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
