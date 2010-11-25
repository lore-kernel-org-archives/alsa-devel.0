From: Andrey Rahmatullin <wrar@wrar.name>
Subject: [BISECTED] 2.6.36 regression for ALC892
Date: Fri, 26 Nov 2010 02:18:03 +0500
Message-ID: <20101125211803.GA4236@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784965840126915246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from haley.wrar.name (wrar.name [109.74.195.39])
	by alsa0.perex.cz (Postfix) with ESMTP id E857310397A
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:18:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7784965840126915246==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello. I have an Intel H55 motherboard (ASUS P7H55-M PRO) with ALC892
sound codec and a 3.5" front panel which doesn't support newer HDA pinout.
So the panel is connected in "AC97" mode and this mode is set in the BIOS
setup. In 2.6.35 and earlier the panel's headphones jack was working. Now
it isn't. I've bisected this down to
ce503f38bdb59c9175a9076215a3ba579fad4e64 (which is present in 2.6.36),
reverting it helps. I've got "Too many connections" messages without this
commit, indeed, but I had no problems (though I use only a pair of
speakers connected to the rear panel and headphones in the front panel).

--=20
WBR, wRAR

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJM7tKDAAoJEOih81koZvPBMOMH/1gyvCfqG4XOv6OR0DXtTSaS
UA5q87SKRKYrWaPNB8VtutQ6feAwO//tBxHos0grtuD1OTKcDyktMZcmSWdeT17h
TE33Nom/ynQeZ1OLMiJKV9j0/3MGsH6wDnTClVqUHL5hVaIjDSMCFHGWDxBW0voE
Kylpa1PBouykl8x03fPCZ8+uX748L/+ZkmNYpW2Yx1h4YExmaIsSPKs3jkq+l8+X
suMmS6GZnKRMOT03Qe3eA03WHNPO89CJMvdl1YZctvDxPPW3gBF3vK0eSKhnO1i3
y9/Zb+4C0aYpxvkj5glguLWYlcAPYxfDXpt5Z+VzTgyiy/UGUlO8SDLF5mo/REU=
=+vo2
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--===============7784965840126915246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7784965840126915246==--
