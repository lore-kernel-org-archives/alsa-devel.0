From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: s6105-ipcam: Fix incorrect
 placement of __initdata
Date: Thu, 8 Aug 2013 14:28:41 +0100
Message-ID: <20130808132841.GE6427@sirena.org.uk>
References: <1375960938-29005-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3194393211605167860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E69C26084B
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 15:28:44 +0200 (CEST)
In-Reply-To: <1375960938-29005-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, Daniel Gloeckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org


--===============3194393211605167860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wr26kid6E8rFCMyi"
Content-Disposition: inline


--Wr26kid6E8rFCMyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2013 at 04:52:18PM +0530, Sachin Kamat wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.

Applied, thanks.

--Wr26kid6E8rFCMyi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSA50GAAoJELSic+t+oim99lUP/2ZbQFM11V841JaNDAvbBRAr
x6+PRETuTNd0yQisf+5CouUFwagfJ3ZMY7TEJRYIzlX3HmT2AH1yO8BQKHWESL8N
c+TVWUdxjIHDKFqiwz0ZA3oLPxR5oRoafhr/VN8jNm4ox1PN7pCmvtaW3sikUsQz
a37PXoYPTTRuV49ntLiswtmestJep81nc4W8Xoe0uUm2N0YGZ6F+iak3yTP20oF8
frveLMFnvEZdLtyYw1mViIq93TGvzIL5mj9ffHzhZ6Cn2m81SbO/qphNrLDFakO+
Jglo7mZVIBCBISBIILNG8Mm8RnVQ6KBeAbjYaL+HX9jURtZ3iaWanqs/OPqlXHdV
vmN/QT+NfR5GFzbV0JtG66fLLM2TpBDhtXcafMs+yxB5ccBJuSYPmwWNktUuNR2s
j2+SQPS/HJF9RSEHqJoGg5tnWysfcN6n0cN4ID3IrFqSeZddcAZHn3CtZpNVH5eI
t4D27YfJOlFJlv26knCd7ZVOgCUpPH/jB4DMqmqpzGu2dqY/qDWvKbVP0gKt0mui
40ycWv7w/o0m4hO4wfj7TxJ9i1WqOFmTRkf71JLgYOAMuje6fvV8Wml2BozFeYcG
InzHrVMegxv0mAjoRNpCeGHIkEdMZMc0IIFQsXVdgMftvBAzKzEb2ort4f1pVVO6
K0lYWWp7hOvieHxLSCJ7
=fKHY
-----END PGP SIGNATURE-----

--Wr26kid6E8rFCMyi--

--===============3194393211605167860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3194393211605167860==--
