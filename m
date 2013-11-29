From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Use consistent byte ordering
 in snd_soc_bytes_get
Date: Fri, 29 Nov 2013 15:09:59 +0000
Message-ID: <20131129150959.GD27568@sirena.org.uk>
References: <1385731991-8401-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0596596623951559943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FC5226171E
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 16:10:03 +0100 (CET)
In-Reply-To: <1385731991-8401-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0596596623951559943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KqIDP7BYbqnwKRO+"
Content-Disposition: inline


--KqIDP7BYbqnwKRO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 01:33:11PM +0000, Charles Keepax wrote:
> snd_soc_bytes_put treats the data in the binary control as big endian
> words, however snd_soc_bytes_get uses the endian of the host machine.
> This causes the two functions to be inconsistant with how the mask is
> applied on little endian machines.

Applied, thanks.

--KqIDP7BYbqnwKRO+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmK5EAAoJELSic+t+oim9jQYP/iY2Y992qhxHk3j9hSDqmQnN
2Waa5tF9T5zRGuexckm7h1FA65XmSNH18zrB/AwyWQ7aR6vx8dOizCeTqWaoOBuL
kdH7NnM7ecnFLwWnNWvzuXWF+X5MrKIT3eZjufFHjjXcFSP6W5/GIgV9DOQAZIor
LSnsJqGDrCnIebHtjdhDvs7FTf1epCOG5NNYLthWfPzEDFI4XssPa3qg39IIrzaB
idd/7Hj3tq34g46+uGmc5kcp8G5zFe0vh2mCX70gVnW4XN2aFYuyKGch02WpBVp9
xhcflGps39BJ8V+KyyrsILTjcDluiyd3C2UCsSj+lSueD54PN+yI1DoTezspTeK5
9kzUvfw84oJ1GOIXgNCjUYyvSrNDvkenJ3CBoqOGzFPu8J/u9k/KVazKHBteg5Pm
qKt033Od0ZmcRgD20eKh+iLAl7UOq9aCg+eQ5TJ+z3bZAD24VmQBeyvpTLK+xuMU
e+9eZxnC10rVdsmxielOiBaF2SfVdd7UrZyd6dGd7mDvOP36S4XET+YR11ml56tS
RWtCXXQBhS4En4IFKs45+k7DiGDoB1rztZjPZid2enhfeuhMCS8GdXRz3685TvWJ
xcCHbaoAab2uehK61qU/1IGOLto4XRFIZKFiZxYsc2r0HCZQkqZLOkZ2kmB8jJpR
VpKmU3macOoHFd/CtnRQ
=jt9i
-----END PGP SIGNATURE-----

--KqIDP7BYbqnwKRO+--

--===============0596596623951559943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0596596623951559943==--
