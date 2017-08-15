From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Correct the interrupt
	property
Date: Tue, 15 Aug 2017 12:53:09 +0100
Message-ID: <20170815115309.glj52jx3kpq4jxq3@sirena.org.uk>
References: <43a7fb98e7252d0b7b73cdabf1eedd0bf896d68c.1502784169.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3177391050010024541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F0941266EB0
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 13:53:11 +0200 (CEST)
In-Reply-To: <43a7fb98e7252d0b7b73cdabf1eedd0bf896d68c.1502784169.git.ryder.lee@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3177391050010024541==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gzdig5tpx7iqh6fk"
Content-Disposition: inline


--gzdig5tpx7iqh6fk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2017 at 04:07:02PM +0800, Ryder Lee wrote:

> This patch update interrupt property since we only use ASYS IRQ
> in the driver, and this may confuse people.

> -		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;

What harm does having the extra information in the bindings do?  If it's
possible there might be a use for the extra interrupt it seems better to
have people describe it.

--gzdig5tpx7iqh6fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmS4KQACgkQJNaLcl1U
h9D93wf+L7m9x7+OQo1mJABVGKFZXqqKwWJifYg/pQX6ZZ0AdYWINzfxk9TynL6j
PmTmduO9PDR3EOf6Kf34Bk8MEcuN2VwQt+EyIh+ETh71IIM9MBxdwY238cOl6stZ
QkEFINtxibMbB3OY2c2+J3GO4VeOeZ81Ti50mpG9aiyjtydSKVNNGjnRZ/+pGdU0
UDh4YWRYCDa4FEW69i7s0bdp2kUW4kX2eWMgwjKDprqplnxMLSB+++la10QcOqNS
Fwk6PDUjC9Ei3EqLCZsFCjQ1Bo96rIW4a7TNC8CZPy1mBqr8VPiEwyK3A6CoHAxO
i+5qWyGUcRwrn0uK3yanApM3dvkkjw==
=qQPk
-----END PGP SIGNATURE-----

--gzdig5tpx7iqh6fk--

--===============3177391050010024541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3177391050010024541==--
