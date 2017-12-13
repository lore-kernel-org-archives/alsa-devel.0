From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 08/13] regmap: add SLIMbus support
Date: Wed, 13 Dec 2017 16:06:11 +0000
Message-ID: <20171213160611.GO6416@sirena.org.uk>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
 <20171213092537.GB12631@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830032031747735616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 531E4266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 17:06:14 +0100 (CET)
In-Reply-To: <20171213092537.GB12631@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============1830032031747735616==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Content-Disposition: inline


--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Mon, Dec 11, 2017 at 11:43:02PM +0000, srinivas.kandagatla@linaro.org wrote:

> Mark, can I get an Ack for this patch so I can take it through my tree
> with the other patches in this series?

I'm actually not seeing a direct dependency here (there's a depends in
place stopping the regmap code building if the Slimbus core isn't
enabled) so if you want you can go ahead and apply the main stuff and I
can apply the regmap change separately, it'll avoid Makefile/Kconfig
conflicts anyway.

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxT/IACgkQJNaLcl1U
h9D9MQf/QHSr2rl3OP0HU1ZguQ6AIupgZ8lI2DgNOwfPYZDJd9ufp1n7crUkYf0g
wy62tiZ0/glrVyZ7Pckpob8rWJ7UfmFg86Lct5c4NYO2pT1dYYI1iYvnGcvnt5tD
5lPBlAxuh/sETGj9gxKi2rdaaMnEP/pcWjJAcWIrENVNS5tz4bY+nQsGK80SVMOz
m4qlNNJaVUPvT4tT+OdUWZ78nmkvpDqM3gqAZld931ujSYwfaUdxaJSkUGAxSjgh
x/vaCAHPawqv2nvj42NZW0trhrohlVZ0bFgAvFOs7YGILA4/vzMxhMAiUqQgLydF
+LB78AsRwHoIHwwmNyqafT7EvN01gQ==
=TkHe
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--

--===============1830032031747735616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1830032031747735616==--
