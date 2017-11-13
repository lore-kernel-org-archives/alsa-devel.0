From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.15
Date: Mon, 13 Nov 2017 16:30:14 +0000
Message-ID: <20171113163014.qtdfgpqiign5xahk@sirena.co.uk>
References: <20171113115242.pmc7asf4yumj5ubk@sirena.co.uk>
 <s5h4lpyb2e2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4517852019348302246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05AAD267379
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 17:30:17 +0100 (CET)
In-Reply-To: <s5h4lpyb2e2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4517852019348302246==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xbpmiqny37rdj6p"
Content-Disposition: inline


--3xbpmiqny37rdj6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2017 at 04:54:13PM +0100, Takashi Iwai wrote:

> BTW, one thing Linus requested in the last KS is to avoid merging to a
> stub branch when you're managing topic branches.  If any, just smash
> the rest branches into one of your branches, instead of merging into
> the upstream point.  Just a reminder for the next time.

I saw the LWN writeup after Vinod mentioned it but what he seemed to be
talking about was the practice of doing incremental merges to master
each time a topic branch is updated and instead requesting that
everything just get merged down at the end which is what I do.  Unless
he says something directly I'm going to assume my understanding is
correct, it's how I send all the stuff I send directly to him so if it
was bothering him I guess he'd have said something.  I can't see that
picking a random topic branch is going to be especially helpful either,
it'd end up being one of the fixes branches as they go first which'd
quite likely already be in his tree anyway and end up looking like an
empty branch based off a non-tag which'd probably upset him more.  It's
also the mechanism I'm using to merge fixes from him so there is stuff
on there relative to the other branches.

If it's an actual problem I'm sure he'll say something.

--3xbpmiqny37rdj6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloJyJUACgkQJNaLcl1U
h9DBKQf+IXXlMnVze4jLaJxiQKopOcPZIuwiTjiMYSpy9DAgP5FFxPNBYjujxkK8
hHuu1m5TjUM7x6RQGrxyy2EjLxmJlxkgEjrYmIErm8PE8wlnwK0Ccig96g/jDyB7
DgK+Vft5d2vuJCHUlYlFeBrXLFHUI6F49so8ea0vabPailMucQ5jzToNWmWUtcrr
ucQBix8W3U2xU/Gl97GNa69QXpK5RRuCvjSHrsWTCfjGy/WpO0IiW4hcTLLTYXD5
kzlzdC7l+hm5Ya2L6X0qGf1m1o7EJ5+p5E1EbMySTci6xhMXmgkIlsqBpNqvL9fn
4M/rhgdc0OKkFgC7UsJ0kBLSr1acrQ==
=8cxo
-----END PGP SIGNATURE-----

--3xbpmiqny37rdj6p--

--===============4517852019348302246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4517852019348302246==--
