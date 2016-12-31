From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: nau8825: provide clock divide
 for codec mater mode
Date: Sat, 31 Dec 2016 18:57:01 +0000
Message-ID: <20161231185701.4ebiu7zvmbldfdjd@sirena.org.uk>
References: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
 <1482223627-23547-2-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6905034778833812031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FCB72670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 19:57:08 +0100 (CET)
In-Reply-To: <1482223627-23547-2-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6905034778833812031==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4s3i2dh6cvrjz7lc"
Content-Disposition: inline


--4s3i2dh6cvrjz7lc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2016 at 04:47:07PM +0800, John Hsu wrote:
> Provide the LRC and BCLK divide. The clock divide needs configuration
> properly when codec in master mode.

Why is the driver not able to configure these automatically, most
devices manage to do that OK?  Typically systems are fine with the
obvious divisions down from the root clock, the driver should at least
offer that as a default rather than requiring all machine drivers to
duplicate the divisor selection code.

--4s3i2dh6cvrjz7lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhn/3wACgkQJNaLcl1U
h9Dbzwf/UBjb6d2mje6nQPn9srAdpLPshHoXPVZbE5aOayBYxTry8yWhWpPDUcrO
Hff3WDX3CRTrMyH9gHFkt1EvnY/sH/JqBqiQo8Jqa6xiyYmoweRb3t966d4SoGMz
JcqaPnxSqHAC+Qjgkpw2L5rDwOHj2dKmTodRL3bxkVzrFGQqSFoO/BSI6cltPb6Y
qazhejuxQJT3tcgeF8SFfY1KjbcZwa/4RuMzqw7r07gR0fwkkJ6LG6ejVw7Jpbf7
lYkFJKYayA2KnBDsUkecJSqTSeVOi1w/zfRrJtRGkci9PHE2lsczyiVZtg+q+ai1
jVWmh30d21Wfq/1DCNPGJTqQpQop/w==
=42QY
-----END PGP SIGNATURE-----

--4s3i2dh6cvrjz7lc--

--===============6905034778833812031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6905034778833812031==--
