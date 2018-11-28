From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: max9867: Fix power management
Date: Wed, 28 Nov 2018 09:22:53 +0000
Message-ID: <20181128092253.GC6828@sirena.org.uk>
References: <20181123142507.GA7347@lenoch> <20181123142729.GC7347@lenoch>
 <20181126125719.GB9715@sirena.org.uk>
 <20181127173727.GA23636@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2911709343503810802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31DA9267AF4
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 10:22:54 +0100 (CET)
In-Reply-To: <20181127173727.GA23636@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2911709343503810802==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2018 at 06:37:27PM +0100, Ladislav Michl wrote:
> On Mon, Nov 26, 2018 at 12:57:19PM +0000, Mark Brown wrote:

> > > While here move suspend and resume functions to more common place.

> > It would be better to split this out from the rest of the change as it's
> > a fairly large bit of code motion relative to the rest of the patch.

> So something like this is preffered solution? (untested)

Yes.

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+XmwACgkQJNaLcl1U
h9AGGwf9EaaxHUdxQd21jtfln/q9P19LwhbvUJlOkwFQxG9EqDwlGQm/Xukc66V2
p3B2YP9lXyJC+a+UwuQLI836jjgUVFS9qDSN7wSBXXDjNWzpBa+kkX0aTgDxVYaA
AHFgF1eUhFpGH+Lf+/71dH1Qa06sOfpi6LB8DQtveLDT6L11R28c6nfuGRams3tf
Rd2ocFmoSE0YDbDsh8KpuyJjfKpyK3Bchs0hy8tdmeS9zohEblFpyDSqV+rWmAX2
j+kcgQV2AQM2d+LTI60DTeSIwBvc5IqBcNO+V7dFXqJ7A811Y3xAbIpjKXR7MLTq
/pINro1bGbQXExHXiu5nSn5+rT2l7Q==
=H1YL
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

--===============2911709343503810802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2911709343503810802==--
