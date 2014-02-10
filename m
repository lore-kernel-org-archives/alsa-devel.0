From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] sound: soc: fsl: Add support for Novena onboard audio
Date: Mon, 10 Feb 2014 14:45:01 +0000
Message-ID: <20140210144501.GN1757@sirena.org.uk>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
 <1391749517-11787-3-git-send-email-xobs@kosagi.com>
 <20140207181433.GM1757@sirena.org.uk>
 <52F5EA67.1080008@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qw1jpiGhEv1c2/gd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F5EA67.1080008-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--qw1jpiGhEv1c2/gd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 04:27:19PM +0800, Sean Cross wrote:
> On 8/2/14 2:14 AM, Mark Brown wrote:

> > The CODEC looked pretty simple, can this use simple-card?

> I had never heard of simple-card.  It doesn't look like it supports
> device tree.  Novena doesn't have a platform definition, and we run

Yes it does, please look at current code (you should be submitting
against -next but the DT code is in Linus' tree).

> Can you think of why this would oops on removal?  If I disable
> headphone jack detection (by simply making data->jack_gpio an invalid
> gpio), the module removes cleanly.

Nothing immediate springs to mind, sorry.  What's the oops.

> > There's supposed to be support for this sort of thing going into
> > the clock API with some sort of generic binding.

> Can you direct me to this patch?  Is it supposed to be defined in the
> device tree file?  As of right now, the clock is hardcoded to 24 MHz
> in clk-imx6q.c, which is why we need to change it here.

I'm not sure it's actually been written yet, sorry - I'd ask Mike
Turquette what the status is.

--qw1jpiGhEv1c2/gd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+OXqAAoJELSic+t+oim99UYP/RaiwiMzleOqnALAt30IYBpy
JHWzc3hrlKZgtAkMv5/Dqt03f+fB/ukLOGw2AUY/C233hlhJGD40lkEfv6a3N7G2
r8MPD5400AOowsMjTSU9Un5aVCsbvKPXq3RSyj2PqjBreKh2IqEB2Q0fJ2XfZlQE
jn73c/NgPCtvtHqDVuKYPbQ+eCtiSo0PppU76dMifmNfA1iaRmIQoj8ZtQbi6hM6
ihhodLxcU/2n1TIloXm9s92A3shOqWPD0b3t2MYik9xKWn7h6IjsekJXE2DDI2Gv
Qt+aeA4xl75b5AEP7a8yIQgP+uvNpOX6Zn0NNZILry0EPDGcHc9OmiA0n+dJ/VDr
Gp8gM7GoQb8JeduflVG1WWme7c6N3agWrJc4uW4UvZppAr84JY93cbf13swv7KQB
N+4Ozmba2/QYlNW25vMvlK+Sy3LzKg+m4UQGQthbIcJQLnui5R2EW+wgTjvtRoWB
hqgkE4/wHhrSX/eZKFYHz0Et4WgYHG15i9CmuvUnN3HlO5eenuiqfZ88yxo2vMXi
jWI8eIMrG+QZ3EqqrHhw7u7igSX3v0o7i5mFYCvP9S+18OmsQrROu3MJkccCybRP
jQxkFdd9HBPG/rID5lEq2/Y2gPjW7JC0T+JIvBEjPxKXvN3pMd2F72geF0ZMa4vL
veJc9H/fgOgKD6keBJJB
=kExi
-----END PGP SIGNATURE-----

--qw1jpiGhEv1c2/gd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
