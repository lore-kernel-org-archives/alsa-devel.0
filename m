From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Remove redundant cast
Date: Tue, 21 Oct 2014 22:24:38 +0100
Message-ID: <20141021212438.GB2344@sirena.org.uk>
References: <1413903675-3363-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413903675-3363-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2014 at 05:01:15PM +0200, Rasmus Villemoes wrote:
> Both path->name and e->texts[i] have type const char*, so the cast is
> slightly confusing and certainly unnecessary.

Applied, thanks.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURs8VAAoJECTWi3JdVIfQ+jgH/13sYOK9yAppjGlyOLkAu7aI
VwO6zIfmYVP+yg1j+1foRqHLwiKCTJ55TYla68j7ZopieOa61Y6XSrrerovJhKRa
QvGZ9s9n/l9i4geXibGaa2bFo6c1cv1qAzc0dDhPkRWePFV8FYCgzmUxI9OWr53U
lOru4mw3BXq7elnyM8hg2n+3BaVmEvpNHIqjZy5KKstrbJSB7QW5Ehtr/wIeHoKi
H7IL7VUT/seSlIyBFgt6x8AID1ZhYBh+MRBqan2bkwSri7q+oH/XMd2KavYzrXqt
b3OEcxyeg+9kwORPE9J+i4xtQfac18HgB/sU0RlMs5gHXSb0SorgAX5t+dX1mQs=
=DWqT
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
