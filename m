From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 15/18] dt-bindings: sound: Add bindings
 for Cirrus Logic Madera codecs
Date: Tue, 25 Apr 2017 16:52:57 +0100
Message-ID: <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9005742762722727329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3D6266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 17:53:14 +0200 (CEST)
In-Reply-To: <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============9005742762722727329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibw4kwd45lk3fi6z"
Content-Disposition: inline


--ibw4kwd45lk3fi6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2017 at 05:08:41PM +0100, Richard Fitzgerald wrote:
> The Cirrus Logic Madera codecs are a family of related codecs with
> extensive digital and analogue I/O, digital mixing and routing,
> signal processing and programmable DSPs.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +Required properties:
> +  - compatible : One of the following chip-specific strings:
> +        "cirrus,cs47l35-codec"
> +        "cirrus,cs47l85-codec"
> +        "cirrus,cs47l90-codec"

You shouldn't have compatible strings for subfunctions of a MFD unless
these represent meaningful reusable IPs that can exist separately from
the parent chip, that's clearly not the case here.  All you're doing
here is encoding Linux internal abstractions which aren't OS neutral and
might change in future (for example clocking might move more into the
clock API).

--ibw4kwd45lk3fi6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj/cNgACgkQJNaLcl1U
h9Dzfwf+K9DALVBhWKgWTELVOedgczqAhddAEMswkyTtko8j5t2ZIdDu2s42nKWn
EGJzJVAAPzZanHlcbA51HXQsE/NK7PtzSrED3AVvGd3EiTGJ4m6IsXiGJyh5xxLU
VYiD+FNlaBYPbD+HuBtoBTxPobWWzj09iOQtiGRvO0Z72ddh5/3oN5S0+61QKCHA
UZh46HbqNzPa5cIbfb/FQygzgfazOyo4z1piaZ1MDE+Y/2sscK1xlkwV78mGASjc
4F7sKb0K31Hl/UbzTqVTIZwfysDlCgz207/I4Z/OdA+APj3wzYTnyGgjtpwNFBt3
vh3qCGLZGl+Wj02NxgX9WJDli/PUwA==
=BHG7
-----END PGP SIGNATURE-----

--ibw4kwd45lk3fi6z--

--===============9005742762722727329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9005742762722727329==--
