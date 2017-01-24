From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ux500: do not moan on deferrals
Date: Tue, 24 Jan 2017 15:45:32 +0000
Message-ID: <20170124154532.xgygzqa24q3cefli@sirena.org.uk>
References: <20170120132011.1147-1-linus.walleij@linaro.org>
 <20170123181516.tr55l7mmqkhr25s6@sirena.org.uk>
 <CACRpkdZd4UZKYhB7KazM2+LDtA=CiwG97u3vjhPa4fXPGAUNJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4988796152510233387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D4F266CF6
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 16:45:41 +0100 (CET)
In-Reply-To: <CACRpkdZd4UZKYhB7KazM2+LDtA=CiwG97u3vjhPa4fXPGAUNJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4988796152510233387==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="am43hjnhvpsbnlgo"
Content-Disposition: inline


--am43hjnhvpsbnlgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 01:49:15PM +0100, Linus Walleij wrote:
> On Mon, Jan 23, 2017 at 7:15 PM, Mark Brown <broonie@kernel.org> wrote:

> > I know I took the other patch doing this (along with some other changes)
> > but in general I'm not super comfortable with just silently ignoring
> > probe deferral errors as it makes it hard to debug practical systems -
> > the device is there, the driver is there but it fails to instantiate
> > with no indication as to why.

> You're right. Let's drop this, the only improvement could I guess
> be to print explicitly that things get deferred instead, unless by now
> every kernel developer in the world knows what -517 means.

I'm guessing so but yeah.  Actually one thing I'd really like to do at
some point is introduce an error to string conversion function and use
that more widely for printing error messages, it's trivial and makes
reading log messages *so* much more easy in general if the computer does
the decoding for you if you get -EPROBE_DEFER instead of -517.

--am43hjnhvpsbnlgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliHdpsACgkQJNaLcl1U
h9Bi2Af7Bk2xHzx6V4NuMevx8QCbKsPj92b/O2NNV5jvq+0hiIKcUN8H3QPgXEtx
BYbLBq4fPFncjZqHxK40el1HrRaSC/07LgtqZDJGR4M0o9NpAeVWsazHykmLInfh
PJev9xtG19DllL8JmjmPuPY6opBnJIdT/pEmZF/hibffVIzwr9dCzM/kqPEry5Rv
CZ8l7yAmYF8TXyqbEahQq3iCcxoN3RlRv9spsh9HXZg2GX3t+ACjgYtSmQkZpV8Z
/eEvMmSRSMbR5uOyn7MseAauC035XnoBYaPGgnpSZjPx4NP/XkjkGZmVW+Eyg98C
SiC4mKJQYgJ9srLlpV9BAzEEMLBJdQ==
=1LUQ
-----END PGP SIGNATURE-----

--am43hjnhvpsbnlgo--

--===============4988796152510233387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4988796152510233387==--
