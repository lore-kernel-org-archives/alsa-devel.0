From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Move DSP Rate controls into the codec
Date: Fri, 19 Jun 2015 11:17:51 +0100
Message-ID: <20150619101751.GI14071@sirena.org.uk>
References: <1434631399-30102-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YjQsDnI/3MvG4QUn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434631399-30102-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--YjQsDnI/3MvG4QUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2015 at 01:43:19PM +0100, Richard Fitzgerald wrote:
> The rate controls are codec-specific, it's not possible to
> generically say what the range or the meaning of each control
> is (or even if they exist at all) - that depends on the
> particular codec.

Applied after I managed to figure out what this was generated against
(which appears to be a combinaton of topic/adsp, topic/arizona and
topic/dapm).  As I said last time please indicate dependencies.

--YjQsDnI/3MvG4QUn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVg+xPAAoJECTWi3JdVIfQbToH/3R9L38yJ0u19kOEefYZcB4O
HsgLE3WUZoHf3v60p1q+5DCZKj233QGmPaT09w0zf0MkXPDwoKUCmL78Cekn0jDx
JqTZVI8CT2li3E7odckssVy7BCrQBcBg/9rcUarZD1Ue2T/DTFwQ3+NkFUIZfxJ5
yvWsAw5wQxiF8n14bTYX83F5UYDqteWbiwj5E7HTRlaOdFPvhAKHGzghqSfPW0cG
K1C0bY9Hnd0y/lNh2b5jYXCQ3atqsfm9GYFnBUtj/srALZp8VaNGp65KXROsLNXP
mr19xqgtEYGpwT38gPLJ2kGRY+9b+v1Aextzv2ni0HYVYv4mRIg2jA6ZiruUKvY=
=SlDy
-----END PGP SIGNATURE-----

--YjQsDnI/3MvG4QUn--
