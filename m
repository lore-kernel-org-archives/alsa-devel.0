From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ALSA: ac97: add codecs devicetree
	binding
Date: Fri, 22 Jun 2018 15:43:37 +0100
Message-ID: <20180622144337.GB15386@sirena.org.uk>
References: <20180621154356.5438-1-robert.jarzmik@free.fr>
 <20180621154356.5438-2-robert.jarzmik@free.fr>
 <s5ha7rnditx.wl-tiwai@suse.de> <874lhvnlx1.fsf@belgarion.home>
 <s5h8t77hz8y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5438009486415750664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF682676B0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 16:43:43 +0200 (CEST)
In-Reply-To: <s5h8t77hz8y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org


--===============5438009486415750664==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 12:49:49PM +0200, Takashi Iwai wrote:

> Hm, some of these users (e.g. drivers/usb/core/*) do call
> of_node_put() properly at releasing, but some look leaking to me.
> I don't think we have the common code in the driver core to release
> dev->of_node, at least.

> If any, this should be done in ac97_codec_release(), I suppose.

Yeah, I'd expect this to be handled in each bus.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlstCxkACgkQJNaLcl1U
h9Bbdwf/TnACvLBod1Z4z6L39QVRhG7Gud/6osipDCfZHAgnSaNdm9uGXovl16FB
LfjKnlRib6KOmA6yzImHzyZpFxYCbRYBWCxC7ZSDl7Pi60EZOuaxPflBF4h7Ywzs
UQmbrnAl+ihLp+bLWy8k1frZ19z0e+J7UkZvNJrFf2FQP1c6dY+ugG4cGZvl95rj
ezI+rUamPBjwvZ123qSqXsvdp2j8iHYcRYv32M0Jm5t5+jyrDR0lo4MXxPKj/lR4
mYLtL0tF9HdkgD3B+Xvg4aJ3716XY4TKnnj6XCyAyvCNwTNZMOXHZ6tMLLltdOrO
lA1LJiSK/9/l9Jk0Day9uFNUPD2uCg==
=x2fN
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

--===============5438009486415750664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5438009486415750664==--
