From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Sun, 20 Oct 2013 10:03:33 +0200
Message-ID: <20131020080333.GG10079@pengutronix.de>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
 <20131019102809.180dc4ff@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 48C47264FE8
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 10:03:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131019102809.180dc4ff@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 19, 2013 at 10:28:09AM +0200, Jean-Francois Moine wrote:
> On Fri, 18 Oct 2013 21:12:59 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> =

> > > +	if (IS_ERR(priv->extclk)) {
> > > +		if (PTR_ERR(priv->extclk) =3D=3D -EPROBE_DEFER)
> > > +			return -EPROBE_DEFER;  =

> > Maybe the better logic here is:
> > 		if (!PTR_ERR(priv->extclk) =3D=3D -ENOENT)
> > 			return PTR_ERR(priv->extclk);
> > =

> > ?
> =

> No. This patch is associated with an other one which returns
> -EPROBE_DEFER when the external clock is declared in the DT and when
> the clock driver is not yet initialized. Then, the kirkwood modules
> must be probed later.
Yes, that's understood. My suggestion behaves as your's for the return
values -EPROBE_DEFER and -ENOENT, so the deferred probe should work,
too. The question is only what you want to do for other errors (don't
know if they can happen at this stage). I'd say, on a dt parsing error
bail out, too.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
