From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7 linux-next] ASoC: rt5631: constify of_device_id array
Date: Sun, 22 Mar 2015 18:04:09 +0000
Message-ID: <20150322180409.GQ6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-5-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-5-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:48:59PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwQZAAoJECTWi3JdVIfQbGUH/iuxRAi87eF7HXMnQ8t2LMVD
lqNJ1jIPNJazUPDY0CzaflpwcAwZBAOyW9RHgpWv7eTGlY8xbXjC2TVCyB0FwpaO
t2dF6dpN8YQS4JGYccC/lmSld0+gd8Imuh3EYEdd/s60vlcnhswgbeuXd8nJ83yp
Wk6RFZNCVM06UcbRD3HUyCFtftdTwjSmsTrR98rBSt4Qwg9ZxtDagbnt2ulq49em
w25mA7Rn96Yd+RmSBmEs6vyYmjUPNHBquY/ibEOt55GcGt4YPwN1DhPUYpU/J7N9
zfLG7IiJ+fXUwh+hsHhd9r8qgSIczfENYA0ddfPvRiVrj7/kpV+UFNErHF5Hc1g=
=SNm9
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--
