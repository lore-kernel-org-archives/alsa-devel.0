From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: codecs/ts3a227e: fix sparse
	warning
Date: Wed, 4 Feb 2015 20:09:21 +0000
Message-ID: <20150204200921.GC21293@sirena.org.uk>
References: <1423070970-24164-1-git-send-email-prabhakar.csengg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5159039347212411029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 853CC2604D3
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 21:09:34 +0100 (CET)
In-Reply-To: <1423070970-24164-1-git-send-email-prabhakar.csengg@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5159039347212411029==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RGlnA7XMncgG2RXR"
Content-Disposition: inline


--RGlnA7XMncgG2RXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 05:29:30PM +0000, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>=20
> this patch fixes following sparse warning:
> ts3a227e.c:222:5: warning: symbol 'ts3a227e_enable_jack_detect' was not d=
eclared. Should it be static?

Applied, thanks.  Please use subject lines matching the style for the
subsystem.

--RGlnA7XMncgG2RXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0nxwAAoJECTWi3JdVIfQTxgH/1gtbI7Wg9S3S31HwXu4wRJW
2MuZQGCxI98NGjcOWeimDPeCYHbXgNwovXBJknU8uvQsXq5eE+58pS/RPCPJwCyu
k/uPWcITGYQ7fgKpULsCAtO4PHOyEjoUs4FyPbUtG/h30cn0XvPB7QIpDPZ3w197
ovEgU6qcr604HIKhq4fFOvxfHEsxmNZdgmG29wLZrcHxDk/FcmF2Eocb+esWoq0N
sPyLjiOf6uRAaJFgjVUGD+IDrbeQCcdBv8ylzdmuXqMspnvH3Hs92M2m++nYWTsM
oTAsgV2/K4FMEaXNA0Ul/rBRoT4NNhuadJpzpFPpt+r30inj61wKk7vgljheaLU=
=4SXd
-----END PGP SIGNATURE-----

--RGlnA7XMncgG2RXR--

--===============5159039347212411029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5159039347212411029==--
