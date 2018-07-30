From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v0 3/3] ASoC: max9867: Fix volume controls
Date: Mon, 30 Jul 2018 11:11:15 +0100
Message-ID: <20180730101115.GD5789@sirena.org.uk>
References: <20180728154134.GA9665@lenoch>
 <20180728154415.GD9665@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7755700708803966733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF34A26779F
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 12:11:16 +0200 (CEST)
In-Reply-To: <20180728154415.GD9665@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7755700708803966733==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 28, 2018 at 05:44:15PM +0200, Ladislav Michl wrote:
> Build proper audio paths and fix volume controls to match datasheet.

This sounds like it should be split up into separate patches for at
least the routing and volume control stuff.  It also needs a bit of a
better changelog as I'm not sure what the issues with the volume
controls were or what was improper about the old audio paths.

> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  I'm still unsure about control names, please see yet unaswered mail
>  here: https://www.spinics.net/lists/alsa-devel/msg80006.html

Always CC maintainers on mails - you really shouldn't rely on anyone
seeing anything that only goes to the lists, they're quite high volume.

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte5EIACgkQJNaLcl1U
h9BQMwf8DBJYpdjjj3PvJaJOWfS0KR/O0t1EAHBkvE/Y2IRVnjFlLhVxLDRZXaOG
ghhu8/FFetCnG3woFn/EmGAD2Vk3pvIe5lXbieWSG52fF6E0+iSjQx3Bb1SwUoFD
GdwoRGaeqKy/q/v64fkABmkEYzCUMsUeyafYI9IWV1py5nbMBQRS1PvNOf4Qg7O0
+8lTu0emry2whse/prRy4mQfaV2tOTs4yfjUouyMsI0BL2m0XI/OrEFAn0bM8U/X
Zt6+5AgaJDFUuttK6GMzKIHtnCyOFCbRbbSdP84Xu76b7yGp0+22C5c7Gkugkeuo
yAzsYrGGwL3ROPV17+5LLGbyIJ/6IA==
=OE8a
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--

--===============7755700708803966733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7755700708803966733==--
