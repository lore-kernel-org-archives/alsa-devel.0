From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 5 Aug 2013 15:42:01 +0100
Message-ID: <20130805144201.GF9858@sirena.org.uk>
References: <20130705133752.GX27646@sirena.org.uk>
 <1373270091.11222.12.camel@matrix>
 <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix>
 <20130717103651.GP22506@sirena.org.uk>
 <1374482594.13726.11.camel@matrix>
 <20130722100211.GP9858@sirena.org.uk>
 <1375110386.21326.6.camel@matrix>
 <20130729160157.GZ9858@sirena.org.uk>
 <1375689331.28910.5.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2239679732611317151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E32426160D
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 16:42:05 +0200 (CEST)
In-Reply-To: <1375689331.28910.5.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============2239679732611317151==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nx36dz0OaUKPu+g+"
Content-Disposition: inline


--Nx36dz0OaUKPu+g+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 01:25:31PM +0530, Ashish Chavan wrote:
> On Mon, 2013-07-29 at 17:01 +0100, Mark Brown wrote:

> > Well, it's a very unusual hardware design choice to have multiple I2C
> > endpoints in a single physical chip.

> I hope to see more of such devices in near future.

There's probably a reason why it's not a common hardware design...

> > With regmap it should be very straightforward to reuse the same driver
> > for both standalone and non-standalone versions, just a small amount of
> > glue code in the CODEC driver I'd expect.  Usually the bus level code is
> > tiny.

> The glue code that you are talking about is for the same virtual MFD
> component that you proposed initially, right? I mean the glue code in
> CODEC will help it to get attached to the MFD. In this case, in addition
> to the glue code inside CODEC we will also need additional MFD
> component. Or I am completely misinterpreting you here?

No, I'm talking about the same thing I was talking about originally.

--Nx36dz0OaUKPu+g+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7m2AAoJELSic+t+oim9vToP/0Q3LNX2WgJ1ACaUXleWetNB
yFvA6uBlDykm3JY+aaSU7w2HEcllhVeN29KoXyEk2Lpeok3anwNiS3udpUfLgq5z
unsXrsAdJ0rm9nPP2Yc5bxIE3QupfVIIm/XPSWD5T3aEvyUf6AOTTfMcceejz0zi
oR69Orp9u7opw6XSOLOSb6kuPg+LnckelMJPtBgXcfqypOni015IRLlQjAjeEPjs
tsNtrna5jXuwwuqqmLo0elRWLw99A7/R8xm15RfRu9iVDvHPcbBqBHDtbVwmCCbb
DIbkFCHIb1IRhPg/DHCn8u3sDfvWKl/7Gg1/DTdw+JwpDL73McY1N8PzWNe18p+z
LL7YCk7h1is/wtczreCfjBNFv/z7emBuzPBEYUP7WxisvWPTHfR24TQSi4mKXz/w
aGF+BV7Ysc1E26GDoQh2kI+6a1I6AKeabWKPC3pCESQOhIqU8N9PJ51Kh9TUFmUo
kcYpPQE3jPwPuTEOhEm6CA1f2MWcIuuEehv+X22KDpJq/GGF2LCx8GptaEOMguiz
rYmV/Y9s/E/L6NIqUOEUxjj9XXrNS0HJI2CnQlZJAArViljgQsHx6qdRon57c67U
JNYJ73Mg/e7HPxcMXMxJZ/Ak9WbzX+52fOQKi/hpSblTvT8znDQrMhXumxRpZRcA
CLyHMMTWz05H/cjviDCd
=aPKU
-----END PGP SIGNATURE-----

--Nx36dz0OaUKPu+g+--

--===============2239679732611317151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2239679732611317151==--
