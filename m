From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ts3a227e: Check and report jack status at probe
Date: Mon, 5 Jan 2015 15:29:58 +0000
Message-ID: <20150105152958.GU11764@sirena.org.uk>
References: <1420457219-23098-1-git-send-email-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pqKHkMk2SPBxSVyL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420457219-23098-1-git-send-email-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--pqKHkMk2SPBxSVyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 07:26:59PM +0800, Cheng-Yi Chiang wrote:
> ts3a227e does not trigger interrupt to report jack status when system
> boots from warm reset because ts3a227e's power remains on during warm reset.
> Read jack status at probe to get current jack status.
> Note that if system boots from EC reset, then this issue will not
> happen.

Applied, thanks.

--pqKHkMk2SPBxSVyL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqq31AAoJECTWi3JdVIfQJZUH/0r75S/sWlc2xiFw+o+YS5sE
NPhUD3yYOMLK6eJLZqJ8z1yTKPhruVLDD+eYzmF5gPu187v97ZqAna/laB6vzapC
m7+U/+LqV3hTKvokvpPCnFPy7wKDRDBYoUhCLuBB5Zq+5K6/E4v/BLIAQmWczWI+
TZaiPOuPaLcrYDRywOntmqg6ZUWJ9ntUAQ1gxANlZSdW0WvuyErPenjych5C+ES1
jNyL5+CztxJm7StJ7Amsnoc+4FgYgJAgTW9Yf7X6cJZjiPF7zFQdPt63s2M8fKog
W+iGmMFBOhqySEBGiLrk+DFooFh7UQ7vSj8X+13kFag5GyosskbzNbjMNxdct24=
=cnlN
-----END PGP SIGNATURE-----

--pqKHkMk2SPBxSVyL--
