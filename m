From: Mark Brown <broonie@kernel.org>
Subject: Re: What is exact definition of "normal/inverted"
 FSYNC signal polarity?
Date: Mon, 31 Aug 2015 19:02:50 +0100
Message-ID: <20150831180250.GT12027@sirena.org.uk>
References: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6760628635714737050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E87A260527
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 20:02:59 +0200 (CEST)
In-Reply-To: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: =?utf-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, lengo@google.com
List-Id: alsa-devel@alsa-project.org


--===============6760628635714737050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XpNX0AP0or0vBirh"
Content-Disposition: inline


--XpNX0AP0or0vBirh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 09:40:04AM -0700, Anatol Pomozov wrote:

> I am trying to configure TegraX1 SoC and Realtek5677 codec. These two
> drivers have different meaning of FSYNC polarity in TDM mode A format.

The simplest thing to do is look at the datasheets for Wolfson parts
like the wm8731, they have some very clear diagrams of all the data
modes we support.

--XpNX0AP0or0vBirh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5JbJAAoJECTWi3JdVIfQzE4H/2K4ENKpLj8chgCMurpXpkLT
M5idlJjCl0oPmCIFXb7evEeIZavqyDveRfMefjqLG3h/Zl2cwb0cS92Is5J+Mswv
+HkNqYjF30STWCgB+BjkZZUztB1Muq+jbA7mVFuGyDbkQ9MIAbHubwtjzBxrhPBa
XGcDJr0JVWqlAZ4pB3UFgJC11CvOP0hX3OLVdKIknZmzCTXt4IHvvcVj4CqROyCw
6F/4nLgvINvg5NMHaA6677OQ7BusCpxQ/mQSIp7L9uy4qWQKQJmcHdf1fTKWaeG8
aiLZLz9w9W97mxBlt/izpAC7av6JPw4qgt6vK/EXm3woN1H84nm+hpMsixr6yHs=
=AbRZ
-----END PGP SIGNATURE-----

--XpNX0AP0or0vBirh--

--===============6760628635714737050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6760628635714737050==--
