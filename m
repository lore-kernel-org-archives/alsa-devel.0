From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/16] regulator: madera-micsupp: Mic
 supply for Cirrus Logic Madera codecs
Date: Thu, 6 Apr 2017 11:57:44 +0100
Message-ID: <20170406105744.f5qpmmi2pjvc7n2z@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170405134054.kz3j56vza4pqki75@sirena.org.uk>
 <1491400437.4096.5.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6717022043634860279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F358B267283
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 12:57:59 +0200 (CEST)
In-Reply-To: <1491400437.4096.5.camel@rf-debian.wolfsonmicro.main>
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


--===============6717022043634860279==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5wfkgd3jlpzi3vd7"
Content-Disposition: inline


--5wfkgd3jlpzi3vd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2017 at 02:53:57PM +0100, Richard Fitzgerald wrote:
> On Wed, 2017-04-05 at 14:40 +0100, Mark Brown wrote:

> > Again, this appears to have only data and minor code style changes
> > relative to the existing arizona driver - is there no opportunity for
> > code sharing here?

> I'll have a look at how it would work out.
> My thought was that these two regulator drivers are so small it wasn't
> worth creating an entanglement between arizona and madera for so little
> code.

It's a fairly small amount of code but it's an extremely high proportion
of the code in the driver and doing something a bit unusual, not just
boilerplate.

--5wfkgd3jlpzi3vd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljmHycACgkQJNaLcl1U
h9DhaAf+MgOeQ1O1F7YETxiO6bPPXlueOsp5OuXiyDXFjzO/9ekNHkmsjxrSQvpT
8dcJVUx8lEHEvBB5zDs608/EobDSl+TKPT6Ud1O2ouczXHFxj627/6+bU8s9avNi
V593V8cSNP9/9qzB60+iBOsLRvtICY2YPGmIuftVBI1bJFIDbxzMZvYApY1+q99Q
KZiUuGM2VRlHPfDQhHODX1dlN8HNtVzMHmN1ldE1u2Catl3VAus9Cjo62g69tCkM
7KuHk3plxKPLdZD/lej8/OW1GB1qy/gS03Ui4eRgOJJz4jBGDzty4zQP1myiIXW2
MevGyBfDke4KCZNx3kQ7V6Y4AgTRBg==
=/bkc
-----END PGP SIGNATURE-----

--5wfkgd3jlpzi3vd7--

--===============6717022043634860279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6717022043634860279==--
