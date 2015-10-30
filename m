From: Mark Brown <broonie@kernel.org>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 11:57:10 +0900
Message-ID: <20151030025710.GU28319@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
 <561CADA8.3040903@canonical.com>
 <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
 <s5h1tcug5w2.wl-tiwai@suse.de> <56226F21.3040902@linux.intel.com>
 <s5h6125cwl2.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1510180836390.24963@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018764817462978651=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC7BA265D6F
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:57:16 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1510180836390.24963@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, James Cameron <quozl@laptop.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============1018764817462978651==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YSDgblk1kzV93dSz"
Content-Disposition: inline


--YSDgblk1kzV93dSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2015 at 08:41:42AM +0200, Ricard Wanderlof wrote:

> Is there any form of statistics on more precisely what type of failures i=
n=20
> this area occur in the real world? Speakers have been mentioned (and I=20
> think were the original issue that started the discussion) and are a clea=
r=20
> case. One could imagine output stages being overdriven (even with no load=
)=20
> in some way, or mismatched signal levels which could cause an opamp to=20
> fail for instance. But have any such cases been reported? It would seem=
=20
> very hard to diagnose for one thing, unless a hardware manufacturer=20
> explicitly noted it in some documentation (which I suspect would be very=
=20
> unlikely for say a motherboard or sound card manufacturer).

Speaker related issues are overwhelmingly the most common thing here,
either straight burnout due to overdriving or mechanical damage caused
by vibrations.

--YSDgblk1kzV93dSz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMtyFAAoJECTWi3JdVIfQOYEH/jibXungMCLsg93xnWVX8dHl
AFuYQjzLEr403ReX2uguRC/apMjn91dLsj0+t78BRG9DUf4uKGvREJ4MbxLcTJiE
YdBoi2i/EzIY8iJTjQ9wgeEE8WnSrsEKfpiRt+AIEFU9THUMMigqG9llzLoKVTtY
tQASzEjMHbATcaaXDrsHwTXX75HFoUjz4+B2e7UeH9SPVOJOCoa23eS5JgHf6eRy
weMtkDMYVn/I2C97LK2hFQtIQbu5I5YzpOGjX+kE31r5KeXlzllnWup8/9244gG8
8wqX40dApYZ7lOsgc8rN6vaAYGmwlTbhESK2NRs+8sWhPWKpMafXxSa7tr4aXfw=
=MUhu
-----END PGP SIGNATURE-----

--YSDgblk1kzV93dSz--

--===============1018764817462978651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1018764817462978651==--
