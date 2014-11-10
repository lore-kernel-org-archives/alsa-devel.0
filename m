From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix kerneldoc errors
Date: Mon, 10 Nov 2014 19:58:02 +0000
Message-ID: <20141110195802.GO3815@sirena.org.uk>
References: <1415637045-20868-1-git-send-email-tiwai@suse.de>
 <20141110175508.GD3815@sirena.org.uk>
 <s5hlhniswhy.wl-tiwai@suse.de>
 <20141110192211.GJ3815@sirena.org.uk>
 <s5hioimsvpm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0933890751589492695=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3517F265B6D
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 20:59:23 +0100 (CET)
In-Reply-To: <s5hioimsvpm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0933890751589492695==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNBQKW1gq53AWuRo"
Content-Disposition: inline


--CNBQKW1gq53AWuRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 08:26:45PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > If we are going to do this sort of stuff and have people looking at the
> > output I'd prefer that we did do those annotations (and move things
> > around).  This just happened to be the first change in the diff but I'd
> > guess there may be some other things that are undocumented because
> > people aren't supposed to be looking at them (as well as ones that were
> > just missed).

> I don't mind in which ways.  Showing and hiding have both pros and
> cons.  Please just fix your code before I pull for 3.19!

Well, I think someone who cares should fix it!  :P

More seriously it's on the list but I'm having a hard time seeing it as
being super urgent - it's more in the nice to have range for me.

--CNBQKW1gq53AWuRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRjKAAoJECTWi3JdVIfQwboH/jqNPfMlZVo4Ofb+kvLE+ILu
nAO5N1QUGaPBjst/y24VGRvD0b/Sb9O8WS+qgKvKqfGQpncK4fOpI3ZWzKfFhPSF
s1xTJMfDzKqnm0kU1EuMpKiJK4thYvRvXjyJgKq8gD3XfdKp21OHNDXYPJNRpn0k
VenzjO5eVAOjOYMAQF5pzSRSZR9Z2OY9yXqTddnJ4Ty9Qlooa7xE91ePCfqEy9D3
laoWIw7b8EMEvLngdHlCST98WjU8QF2csyftHfIiTihvK8ngbv7aM8D/ZLXlmp6f
q71q5igAGme9/xr1ZDLBI9SUL4IcvEB/15wSPw7LcP21nnrWnKQRto6W697wvho=
=23da
-----END PGP SIGNATURE-----

--CNBQKW1gq53AWuRo--

--===============0933890751589492695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0933890751589492695==--
