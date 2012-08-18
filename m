From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Sat, 18 Aug 2012 09:42:16 +0200
Message-ID: <20120818074216.GG2232@pengutronix.de>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 09542265CA8
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 09:12:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120817222738.GH18871@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 17, 2012 at 11:27:38PM +0100, Mark Brown wrote:
> On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:
> =

> > Also, for the playback to work you need to install the SDMA firmware.
> =

> This is deadlocking during boot, I'm getting nowhere near trying
> playback.
You're on i.MX35, right. I had to add

	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");

to arch/arm/mach-imx/clk-imx35.c to be able to access the codec.
(Obviously this is a hack, and to do it better, you'd need to change

	clk_register_clkdev(clk[ssi1_div_post], "per", "imx-ssi.0");

to use ssi1_gate and fix the ssi-driver to be aware that there are two
clocks to handle.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
