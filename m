From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 19:28:28 +0100
Message-ID: <20140728182828.GE17528@sirena.org.uk>
References: <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
 <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
 <20140728163645.GA17528@sirena.org.uk>
 <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
 <53D67F0C.3010207@metafoo.de>
 <CAKON4Oz5t4duQoymgPufo24bAWHga3TKEE0wzGs4pLCW-9juvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6908885890812515855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFD462654E0
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 20:28:35 +0200 (CEST)
In-Reply-To: <CAKON4Oz5t4duQoymgPufo24bAWHga3TKEE0wzGs4pLCW-9juvA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6908885890812515855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oAOQDB2mA8gEsNZP"
Content-Disposition: inline


--oAOQDB2mA8gEsNZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 12:56:27PM -0400, jonsmirl@gmail.com wrote:

> So devicetree...
>     external-amp = phandle;

> then internally I'll hook it up to the aux_dev instead of replacing my
> codec. And yes, codec is not completely empty it has widgets for the
> possible output pins.

Right, and also allow the user to specify some DAPM links to connect the
amplifier to the CODEC otherwise it'll never get powered on.

--oAOQDB2mA8gEsNZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1pZIAAoJELSic+t+oim9xYoQAIRT03KeSc3P91VDWrWa+kHi
KqSEjlRCq6VyKGRmgrjF3ODAh29NeQoQNjeg2b8knsvdGwKFbyqErm+XWJ2gCqps
9jZPRidCrW88x7E9eHg5UIC9aeP2Mn4iARtGCz/4Atdp/ne1YQ80p7k35YPumSvw
dxopjBHgWMhFP/RNaCvzeerKSa4MuXR19P0DVq3eEFfFxV+yvJN5AV1S585aNcUy
2CATas347RQz9WEdstimEQjuJmvpio5sY8TOyHQBlocf6VScxgy0ULx0StZKkKaa
sNvHdn06hZ+mdRdY4izqKNXyx4OOtoOwdR/5cGRwMBX6GSDcDakikG8mkY7hMYZg
OGMbpSpErG8CnGC4gKAxMkhe2MkM2fTVmsBdoww/zyroGvyS9NUNe9zIUwpfrHDc
YCnmHeZYErozKR7YK5XW+q3yN3SrKEbosBgLgT/HimDaCfBeBooh4TgY/QjQgJb7
G9upKjNzbWrReV3cqklGNht7YztPodCfgTZ1Xfhizr6GD0gIYAqyN3aa27kZ3Gmk
32TR9VByIudJBA88/T1YATtMO8oejItrMmuxWx7plm3Wkocxiw/RYJjG8Q1K1n8D
ZWKPmEt6Z9VNAGWnIHK2z1poxmswYVWzrIHUq9NEumUpromMIcH5tox1ON/VBNkN
zw2vAmQDp8wOfdBN7LBD
=RbAk
-----END PGP SIGNATURE-----

--oAOQDB2mA8gEsNZP--

--===============6908885890812515855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6908885890812515855==--
