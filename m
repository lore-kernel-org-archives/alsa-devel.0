From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver
	as	using symmetric rates
Date: Mon, 11 Jan 2010 18:38:59 +0100
Message-ID: <20100111173859.GW6923@pengutronix.de>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
	<20100111113631.GE3440@sirena.org.uk>
	<eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
	<4B4B48FA.6070402@freescale.com>
	<20100111162508.GB26771@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 48F372434D
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 18:39:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100111162508.GB26771@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Timur Tabi <timur@freescale.com>, javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 04:25:08PM +0000, Mark Brown wrote:
> On Mon, Jan 11, 2010 at 09:51:22AM -0600, Timur Tabi wrote:
> 
> > I think the default should be synchronous unless asynchronous support
> > is specified.
> 
> I tend to agree for the i.MX hardware - for the ones I've looked at each
> external SSI port is four wire so you need to hook up two to achieve a
> six wire configuration that can do asymmetry so a direct hookup between
> the external port and the SSI controller seems fairly natural.  It's
> also the situation for all the default hookups the silicon provides.

As long as I can overwrite this flag in the board support I'm fine with
it. On our MC13783 based boards we have two external SSI channels (one
for record and one for playback). I merge them together to one six wire
SSI port using the AUDMUX since the imx-ssi driver currently can handle
only one SSI unit in FIQ mode.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
