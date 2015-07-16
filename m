From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Thu, 16 Jul 2015 16:05:00 +0100
Message-ID: <20150716150500.GO4039@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl>
 <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwbuP8dfxhLLLUfV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437056116.28351.19.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--LwbuP8dfxhLLLUfV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2015 at 04:15:16PM +0200, Paul Bolle wrote:

> Let's put it this was. If one does
>     sudo find /sys -perm -o=3Dr -name uevent -exec grep -H MODALIAS=3Dpla=
tform: {} \;
>=20
> or
>     sudo find /sys -perm -o=3Dr -name modalias -exec grep -H platform: {}=
 \;

> (both lists should be similar)

> on the systems this patch is targeting, will
>    platform:rockchip-snd-max98090

> then show up?

Why would this not be the case - what is the difference you beleive this
driver has to other platform drivers?

--LwbuP8dfxhLLLUfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp8gbAAoJECTWi3JdVIfQNTkIAIEQVBz7bjmsue5OsI3iap1/
nnyFhqOCSVovmfAPsdb3hChFOkZDiuCkyPWr9NI/4nldNBiQ0QtPzyg4DM7WDDuu
89zrpc1hGakN1eLCE7sCJ3V+ppODYLPZJgYVFfqlrtF1VgGYltDaGmp3E+tqo6Je
+U/zZZ7xvLkwhcvVafVBevdhJyRSB8a5tWrpyVvyZF2oRU5x+X0/NCfvZnvfY1yK
/c9ldUeFLemqyRa7L+T73rjIHp+A1G7XMjHxm8nInVFKh8YwflhC55PZYCZm//jL
D4PQ5JALymDFJY9zZvx0qvmaCaU76IB5HA4RjFZsEclPq2zIzVpn24kwql8yaGY=
=SjUi
-----END PGP SIGNATURE-----

--LwbuP8dfxhLLLUfV--
