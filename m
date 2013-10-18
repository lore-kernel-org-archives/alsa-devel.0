From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ALSA: pxa: slightly refactor reset
	handling
Date: Fri, 18 Oct 2013 01:19:37 +0100
Message-ID: <20131018001937.GF2443@sirena.org.uk>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
 <20131017233607.GW2443@sirena.org.uk>
 <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5965193699380378338=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC2A2616F6
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 02:19:39 +0200 (CEST)
In-Reply-To: <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5965193699380378338==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d2qMbd3vrLwy6XmO"
Content-Disposition: inline


--d2qMbd3vrLwy6XmO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 03:53:31AM +0400, Dmitry Eremin-Solenikov wrote:

> Maybe it was some coincidence/whatever. Maybe it is some hardware issue
> of exact mask version. When I first started hacking around PXA, it was known
> that tosa sometimes does not reset the AC97 codec for the first time.
> However it looks like nobody bothered to debug that, because in most (~3/4)
> cases reset went through. Now some kernel changes made kernel hang
> looping in the interrupt, if the reset is not properly handled.

Ah, now you mention that extra detail I do recall Wolfson CODEC drivers
with suspicious extra resets - probably this issue was why.

--d2qMbd3vrLwy6XmO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYH6WAAoJELSic+t+oim9VmIP/1SsmhyMib8V4sYvBQrbxFoB
oOdaoFJ4tqCLgBTBzxsQFUzE1f5DurlAYvGzFHg4HU5ZEMDg8LRvbuKEtUGdfSqY
OVqteSHnnHihRs2anwuKnotiNjFD2ZPVMo4kKsuMnEmilMIo95FnlzFXYEJoUhXM
onUoOxu/ty5ydmzVz5RoFzvYJSwcRkl5SAue1WDsGcGm/s2x7738e+TQ1Ve7zvFP
okOIPfjM/Dpl8iOARzBgl6niPYjVrWP0p8YrrteHph9+Sp7EildT+fm+WGf+1D35
OdmrEO8frbdxLvDuTv6jU9cU1mF9fBk91XpVgzDfDsCAKU6HS1qhUmWQPbqfVZ7O
0gJ4Fu3r1Nj7JRbOq/nKCiySDWl/eJSmm0MELFJxQ98gZpwlOt798ge61qYjtQ5i
xYzTsczWlYoePfNJ46wzmOGL+WzBG+ufFlP96W7S2hzMKvUsguqMWdlDeDiDQWDZ
PBMzQenFF6S+VIOOadLmsV/UuWjKCR+PglkHDZm/gGy87ZWmem1WaE8Y8jfv6qGV
npkJ1L3WFsHsiiYS9TMc7xUx73xvRRQ0/SGs4dsUhHX7uBWmjl2IA1uNRJmNZgbz
dICY/9KcIxXG7qOZ7GcpUpgkZbc26h2MDorMMNVzosiSgIDK5loeLOFbxvoWoUOn
BKplEpbJl9knziRRRCYL
=CyK4
-----END PGP SIGNATURE-----

--d2qMbd3vrLwy6XmO--

--===============5965193699380378338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5965193699380378338==--
