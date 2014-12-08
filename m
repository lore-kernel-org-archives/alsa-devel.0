From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v3.19
Date: Mon, 8 Dec 2014 15:41:35 +0000
Message-ID: <20141208154135.GB11764@sirena.org.uk>
References: <20141208133826.GA11764@sirena.org.uk>
 <s5h388q9nkw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5914597486679019079=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C01260453
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:41:58 +0100 (CET)
In-Reply-To: <s5h388q9nkw.wl-tiwai@suse.de>
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


--===============5914597486679019079==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KVy3XSgRgEDVTe6j"
Content-Disposition: inline


--KVy3XSgRgEDVTe6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:18:55PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> For fixing a build error with CONFIG_SND_JACK=3Dn
>   sound/soc/codecs/ts3a227e.c:223:2: error: implicit declaration of funct=
ion =E2=80=98snd_jack_set_key=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]

The device probably should be ensuring that the jack detection is
enabled - the device doesn't do anything except jack detection.

--KVy3XSgRgEDVTe6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhcauAAoJECTWi3JdVIfQnnEH/0zTTH+g0B8722VgQuvE4dIa
tBscrA8W9Chw9i5Ste3I3qJBichaZSnHSP+wifytTlRcqC/diPXmJJScAlIklptq
mYFf6zy/g4ET3KMEKVlp507Zu2dVPAOe/wpxRJyPoJV/tYx9+boxd+gUr1LmxyK+
cv0koEWBHDpEjNfwOl3CHRXUagHtsjU0/I2G/joKPSWBl2upCxcsl9fbwJq3kWZ9
ASIJa2QA3g4AtPMglmO4YjEsqSblNb28iFbHnMJnoWHyOvq8VMrxD+xhiNLAp2Cv
f/YdBjFTWzbmlmpDp6BMLTn9ZxDswWNSXs6+BLJogUDTshatKr4UxfzZGlqEPCI=
=mgL+
-----END PGP SIGNATURE-----

--KVy3XSgRgEDVTe6j--

--===============5914597486679019079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5914597486679019079==--
