From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 01/13] ASoC: kirkwood: merge struct
 kirkwood_dma_priv with struct kirkwood_dma_data
Date: Mon, 5 Aug 2013 15:49:50 +0100
Message-ID: <20130805144950.GH9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63sR-0004lC-0g@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4664692688193968343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 942C726160D
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 16:49:53 +0200 (CEST)
In-Reply-To: <E1V63sR-0004lC-0g@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4664692688193968343==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DFTwFFacoTaWDCuy"
Content-Disposition: inline


--DFTwFFacoTaWDCuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:22:03PM +0100, Russell King wrote:
> Merge these two structures together; nothing other than the I2S and
> DMA driver makes use of struct kirkwood_dma_data, and it's not like
> struct kirkwood_dma_data is really just used to convey DMA specific
> data to the backend; it's more a general shared structure between the
> two halves.

Applied, thanks.

--DFTwFFacoTaWDCuy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7uLAAoJELSic+t+oim9xd0P/0uuHU9zdeWszUE/H5N5j2PD
kWxqyz/qV262a8sAtc9o4at6VgG/i7MsDjNF8xjV8CLXBKCuMLEQ998gPxalgKvj
E6kcz/gXfgmEeFe3qwgdpH/Eqmfnb0vSRUWO2IAjSNv7OhFE2nAHYNT1EW7VXQHJ
NtKSfFor+KL7CMyqZw1ijwgm0PbQIEmNjBrAH5mFimf5lT9I0kPU5e9o+8CwRLMp
ZIjETyRyEFiUH1iTlztlwh3SzPZntZf7mXXtPYL+gZfzXvfFwrpXDcSmBIVm/y9c
cm5H0EEFQe/fVCkoLFskROTCZRHbERij/6aZMZ6xFFQV0tQ8bE872wsStKmAfTWK
EEn4mFMGxbKuadkB8GIJX+xLFPvQygqhrSk6iZvpBSBLRTtyftfb1yVgQEzA84Hc
qKCDBk1jOZy2nCGmP1zYvdVNWrAXo1moxFoWx2VNedY8YASPfHutJj3qkT/ce+Cn
EzpT2uqCoPvPTb4ciYUr++x5eVg6Eb4sVgkwz4w4ZVcFnpDPhCRghBDSOCXmsCYw
YDnXww0G4DfZfcVDTzjMcOqgPN13dCcny2Z92IaAER8f/06vFIUEBnZhUrEzPhw7
KW3QJquUuPATosFpIkc3iImNf6cZJNyKrwSIexZGkptDxOSe9X8b35gySoR906/0
4m77u6MwbK81nXw8XZdx
=17gp
-----END PGP SIGNATURE-----

--DFTwFFacoTaWDCuy--

--===============4664692688193968343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4664692688193968343==--
