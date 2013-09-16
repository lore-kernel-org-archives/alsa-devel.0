From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: Add missing break
	statement to bf6xx
Date: Tue, 17 Sep 2013 00:47:34 +0100
Message-ID: <20130916234734.GH21013@sirena.org.uk>
References: <1379114437-25090-1-git-send-email-valentin.ilie@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3204869519916613218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C28D0265049
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 01:47:47 +0200 (CEST)
In-Reply-To: <1379114437-25090-1-git-send-email-valentin.ilie@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Valentin Ilie <valentin.ilie@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org


--===============3204869519916613218==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2013 at 02:20:37AM +0300, Valentin Ilie wrote:
> SNDRV_PCM_FORMAT_S8 isn't supposed to fall through to SNDRV_PCM_FORMAT_S1=
6_LE
>=20
> Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>

Applied, thanks.

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSN5iTAAoJELSic+t+oim9gq0P/A9HFPvZ1GO5zbtwGu7jzPb6
nxihZp9QKf2Kblo2a/AC+Cfec6id3059WEvvfzFoJ9r1rGeeCnLf+E84zBvQSiwG
AFJVOk4GwspVOucan2hBlRR/51SmOMxRqlzt1hi2UcEH2ve5P4rC5yIiY9BrkgJ8
7gfSs4ZiY5SUIE4h91BBkeewVFSq6Ubxc0tANX0WrzXF/aDy789Kfi0dscj8oxcg
pFysM7CQxDU62nrWYvhYyA4cllMfcFNQeRi22poPk+7vECt1DgXB3gPAi2VZxRT1
YcN0JFWbarJl9X46aWT+/l0YhLScLrIBqJ36eH9MVN+j1gk6a+W9lklFYKn6scS2
NdEVha6QydcAlNN1l1supp8ZnISkEztxIHvobsaY9a48dp+8XzSLlp8zILITFFZO
DTxWG/Rjxc5h96PxxDBCWx9LiXaj3yx2boCwAliBKLqkBYAIxZuOEHHK/7hfpBju
mbEyehtbyCvjNHaCgEBydG6gXGN0bLSns4UUSJWhLMu0bkwwL1yZrzKhUI176fZ7
l9yObaHIFxPHMbuUzgP3pfmORb4MGxamR5uw8D7t40DCwTdmBgNI1T1Xx5vm6Or1
Gy6g19bezt1HyX0B7s0zGH6tdSaSSgxwCNIEqYGoLQn7XwHCOS8L8QcYCw3NQCBK
Uz+b85D+nfrfmqo3dRm6
=o5oB
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--

--===============3204869519916613218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3204869519916613218==--
