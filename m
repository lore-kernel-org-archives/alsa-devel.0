From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v4 12/17] ASoC: fsl-ssi: set bitclock in
 master mode from hw_params
Date: Tue, 27 May 2014 09:05:22 +0200
Message-ID: <20140527070522.GD20989@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-13-git-send-email-mpa@pengutronix.de>
 <20140520220802.GC12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2A647265502
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:05:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140520220802.GC12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, May 20, 2014 at 11:08:02PM +0100, Mark Brown wrote:
> On Mon, Apr 28, 2014 at 12:54:53PM +0200, Markus Pargmann wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > The fsl_ssi driver uses the .set_sysclk callback to configure the
> > bitclock for master mode. This is unnecessary since the bitclock
> > is known in hw_params. This patch removes the .set_sysclk callback
> > and configures the bitclock from .hw_params.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> 
> This isn't signed off either.  Are we positive that none of the users
> set the bitclock to something non-default - there are devices out there
> which require an unusual bitclock (eg, where it's also used as the
> master clock and so needs overclocking)?

No, I don't know if there are actual users of this set_dai_sysclk.

> 
> Providing a default as this does is a definite win, but allowing it to
> be overridden may be needed sometimes (rarely fortunately).  Leaving a
> stub set_sysclk() that just sets a variable and then using that value
> instead of calculating in hw_params() would get the best of both worlds.

Okay, I will change it.

Thanks,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
