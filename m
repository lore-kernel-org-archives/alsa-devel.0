From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dapm: support user-defined
 stop condition in dai_get_connected_widgets
Date: Fri, 13 May 2016 13:09:05 +0100
Message-ID: <20160513120905.GK22038@sirena.org.uk>
References: <1460638999-30598-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8325707798309944415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80197260526
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:09:22 +0200 (CEST)
In-Reply-To: <1460638999-30598-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8325707798309944415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2016 at 02:03:18PM +0100, Piotr Stankiewicz wrote:

> + * Optionally, can be supplied with a function acting as a stopping condition.
> + * This function takes the dapm widget currently being examined and the walk
> + * direction as an arguments, and should return an integer, as follows:
> + * - >=0: if the walk is to be stopped (this should indicate the number of
> + *        endpoints the widget has),
> + * - <0 : if the walk is to be continued as normal.

This seems really weird and uncomfortable.  From the naming I would
expect it to be a boolean function and I'm struggling to understand when
it would be useful to report multiple endpoints on a widget (edge
widgets normally being single objects).  The whole counting thing is
mainly a combination of debugging and an artefact of the implementation.
What's the motivation here?

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNcPfAAoJECTWi3JdVIfQubAH/Ap40KM4Qd26bnvCYOcKhYSV
nUmTPbPAEJCWxmBfRgWnwDop5OXhZAPKfQ3PnCUSs2qvsVGFvvu0McAmkLg9QPVE
x8NzUmY3IssnzTwygRmvbnNaUQ/OBaDNTXx788/C1zxqitnnWij2dBj+ZBmRfue8
WktgmJeW1neHK4ZV44a0v6NsZHqy2yhb9ernNd/QpEn8XV3yKcTOUreaR3sp7aRJ
JdqCAJFjueFYjv5jKmeuD24EyAagiJtoH9NLjRUFpiVPqPmvKxbORkOIWiom4LP7
XG6nxlDUilAU052Z9gVIqSiHbxxw37Gm8De9yyRimsaGa0qlXWohX2Ypq+4UzkQ=
=RfjD
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

--===============8325707798309944415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8325707798309944415==--
