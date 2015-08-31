From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.3
Date: Mon, 31 Aug 2015 11:20:07 +0100
Message-ID: <20150831102007.GI12027@sirena.org.uk>
References: <20150830151032.GE12027@sirena.org.uk>
 <s5hfv30li6l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5567475801577980393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE45E26063F
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 12:20:20 +0200 (CEST)
In-Reply-To: <s5hfv30li6l.wl-tiwai@suse.de>
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


--===============5567475801577980393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zh71TqSqNUxNGGUI"
Content-Disposition: inline


--zh71TqSqNUxNGGUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2015 at 08:55:46PM +0200, Takashi Iwai wrote:

> sound/soc/codecs/sti-sas.c:227:13: error: implicit declaration of functio=
n =E2=80=98devm_reset_control_get=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
>   dac->rst =3D devm_reset_control_get(codec->dev, "dac_rst");

> So some changes for 4.3 are missing.  Could you postpone this branch
> until this new devm_* gets merged?  Or we may pull devm change as
> well.

What configuration do you see this in?  If the function was just not
there my tree wouldn't build...

--zh71TqSqNUxNGGUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5CpWAAoJECTWi3JdVIfQ784H/0FSrMotwvns7SCwzbiQbniz
Bn7jzxRgJ2pFePOxXTlHKnsbt6F0i+vd2PhZLmha29WHS+3bRm32R+McSivCr4LH
c/VRcC92aoYJ/K+AIXd7Nn/Ul5iThxHFBjvq6le+iH10KODJJsAKyNGkmqm03X5c
+3eDqoM1fFK0bOpjDUbi0Hzz3V8lImOUpBFZujuBufwVoLN/WrD50jypvgHrr3j/
iilEvHM8XKAQVKhQOBOsBvwddesUgn3yxcBf8WLtB2SQqQpk8prOK28M7DmTCN+J
DjTXmvp45utXMVVvrVLM/sjDASqSyDn3kS4fyljjW1Xst+MdOC+z90wpaVoH/o0=
=F5RK
-----END PGP SIGNATURE-----

--zh71TqSqNUxNGGUI--

--===============5567475801577980393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5567475801577980393==--
