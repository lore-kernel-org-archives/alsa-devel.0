From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] ASoC: Track which components have
 been registered with snd_soc_register_component()
Date: Mon, 24 Mar 2014 11:48:37 +0000
Message-ID: <20140324114837.GJ2269@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-9-git-send-email-lars@metafoo.de>
 <20140324111805.GI1665@opensource.wolfsonmicro.com>
 <533019C1.6090402@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5584955920630912441=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78ED22617B5
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 12:48:54 +0100 (CET)
In-Reply-To: <533019C1.6090402@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============5584955920630912441==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 12:40:49PM +0100, Lars-Peter Clausen wrote:

> My plan is to let it take a pointer to the component itself. I'm just not
> too sure about the implementation details yet.

The question there is why you'd ever want to only unregister a single
thing that the device registered.  devm_ does make this a bit more
academic but still.

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMBuRAAoJELSic+t+oim9KxEP/jsPPn1qRTFMlqEHH0UombzB
9Zv24E2cFAOlzBliXgefgYopolqm76alcU8Mk17K5GKn1GrByhEEdPRL8anfxM/s
t/nMWKSBsAPRSRe19Y473s07AKggyVbKk6TGgX6hVz+AqpEd72g3itVLFQbL2O6B
OY7anR4HSX42QwzW7t/442qtsDJvQme/U0NG5EUJCEMBoZKHBrOJGP+cc/PgsRSt
Nd4B+s9KQtd9h4jXGjgwVigPS2O7UnBm7mVkgtsoaqnUm1ZdD8OVfghfEOJ8yYBG
We4DRAENeoqo3jm2951foHpQhc2gquPAKQNHvigiVMmFSYw9/Z2N3ZXbvrcCiv2v
lSPZqxYFweYnpB2Bt5EfKHuSThNa+s93nu5fSdykHJjhGx0F5HSwtBGwNTGnWcv/
/um6x+PdK85LPzXHEr+obDy2kPth6zSSOFS3T86zgnl24lRZ9WzyzZDDzYwbSzro
e3eIvRK7z1et7miRvBHiM3p0fOoLvBDFvSMsU/y1mCGywAzU5KCFV0MX57BfokHd
HZ4c3fLGggyB5UbHNGq3dSTY9D91yqMBgQjnqa2iJi4R0pcbLbPfNE4bdiunAZBp
eD+3QmhF3OdyNJypfASAk7vvVig/8zA+pSiJjnprfFVNGBy3n3Q7kDLhoWhFytCx
M5sz8mX1mG4xdHqgoPOQ
=2RqG
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--

--===============5584955920630912441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5584955920630912441==--
