From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-pcm: add dma support
Date: Tue, 20 Nov 2012 17:57:30 +0900
Message-ID: <20121120085728.GX10560@opensource.wolfsonmicro.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
 <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mu6rDKe19l+MneQx"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--mu6rDKe19l+MneQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 04:38:18PM +0800, Bo Shen wrote:
> Change xfer_size name to apply to PDC and DMA aswell.
> Specify overrun bit in interrupt mask.
> Add dmaengine specific routines and replace PDC ones in
> pcm_ops if appropriate.
> Uses cyclic DMA API for queuing samples.

If you're using dmaengine you really need a *very* good reason not to
use the core dmaengine support...

--mu6rDKe19l+MneQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq0XxAAoJELSic+t+oim9khoP/i2TYwmErCeIXa+V3s2dGZJH
XBRTxpajBS7NJhHLV5S5M7cTe987kePpdEzmGoQqb/Z3UMeoyADPzitrEXJu19KZ
bhGMLiRRmpRY/i0DQ1iQ3hFVVua1CFcQi+J2INHrXRt3k7QlajGwEF7F5lS/KiRO
84OwgQ2ZaFFK1jbZwtSd2YhdPw0tD22VyEwhw+6Y2j3dd4KoS75CKTt/72O1aYkc
fVvR1bZG+P6zkNtMATb9iqs0P5hsL4Hw40fhaXz4MuLTBmBZGstcHNWM3pjHgFY2
nrpa68Rfj68gm017SaoyghoLpt5HJ/q7nJ76G2UQsIfPCbd4aKW1L+ycEANEwzku
wZWQ1RAk4fMTE7aPZvOtrbepAawpQBJ66TBGJNOG0XMn/EFmolp5In1on8Oq59x4
eBTh3+eQwlHy10lUdMWAeNSOF0upc04nXsRnCC6+Yueodi461sga+dwK0Nrzhldo
Y/kzWn2oy5h3SW/PZPiPOMpXIUuWRcYmzV1EoxtJfGsUr/UD1TDTkwHh4bIl9mKQ
//moeRgKf9MomVaVpRuVWbU02IrPVP6TBgB7RH4b+AtVRpLj4pxiG0JkyC5dWyca
wxkdUfB5lhfcslBmdnJIY9jBhvXMYZtsvc3s7E9Sv2KWK8S/bYjcLFynvK2E/fCN
TuQ67ZAE+cLw/GbtqRqH
=xZYv
-----END PGP SIGNATURE-----

--mu6rDKe19l+MneQx--
