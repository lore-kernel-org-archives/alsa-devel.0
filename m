From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: atmel_ssc_dai: refactor the startup and
 shutdown
Date: Fri, 30 Jan 2015 14:20:47 +0100
Message-ID: <20150130132047.GO26617@finisterre.sirena.org.uk>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
 <1422610724-7222-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422610724-7222-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, Songjun.Wu@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2015 at 05:38:43PM +0800, Bo Shen wrote:
> In startup function, enable ssc clock and in shutdown function,
> disable clock. And also remove disable ssc in shutdown function,
> as ssc is disabled in prepare function.

Applied, thanks.  You probably want to convert to clk_prepare_enable()
too but that's a separate thing.

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUy4UuAAoJECTWi3JdVIfQC/8H/3QoN/rcdKYpeN2R+lh9iar4
pjEqzuDABh5V4FR1ei0fvqaw6GaCwSbdvPsbRuHw1m9iJS/UoTdUGBw/ARY71duw
wRYvgV1VcK7oVJXBtO2vZJhiYSixz+ufv/UmpJQfoTDG1pcSicb5MVkomiiIG3CX
S1pdLuHIb8MH019C2ItNRVYR5frTYfLFpwRm00Yp4tIKpaIF/jpT6DPoAUZjXT6J
t0U2hdhjlBJ0pPmN9NRafCkdZMDjx/EP/h8Q2oueGVEJ9n0YigaDU+CYmxkaP0Ne
ECbinGDcHlxIBdHgTjjZo3DpQKhqDO/kOI8yeTpL3L16lSc6ejAfJS1AyamNiJ8=
=bq/T
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
