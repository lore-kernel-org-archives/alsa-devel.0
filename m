From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: fsl: correct get_dma_channel
	parameter name
Date: Tue, 28 Feb 2012 12:34:49 +0000
Message-ID: <20120228123449.GE3683@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0088237818955974367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F75A103E6B
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 13:34:52 +0100 (CET)
In-Reply-To: <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============0088237818955974367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 10:09:36PM +0800, Shawn Guo wrote:
> The second parameter of function get_dma_channel is actually a property
> name rather than a compatible string, so rename it for less confusing.

Applied, thanks.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTMnjAAoJEBus8iNuMP3dEwsQAJIdVYUJDtpGAcrHPwuXq7rT
5ilsF5tGmHyIkUO3jlOn86soXWQhnAwxHt0Mw0CBw8afstLo8W6zMhK0W5HKXtCX
ftv8LatzHfODcCwjntKCHrcA2/Hza99/CQTsdt8V4DwI72ST8TAWarxhJq7iybSx
pfTHcBiSRnikUuAyOuwqutDM8SgfifRGYiuDSGowLsBZrMxVMUFqvF2jiUUjXkHN
e9KvVuif95zZ6Qm0N/wnCxVkNiBW8nTWKhq229v5NSQt9Pjv/O80seethCyordDW
GCPq8/GhyjJb9+ztQCOOyea75IQebid48CPNMy+eOB+jK0yCsLN5Wp/hPLgYjxYe
wqsCjVMtAn0BHLzBcw3DWtdFNKIjuTylCTBjvhJ9dBYzG5fY+hZtYo0L8yHWDH6K
kNKVVeMnKwdIl4tUhJndoEhlRQwp6dz9X3gx7ppS65kGe9/Aeb3ZtZjW56ZVm1ND
NCO41rhRvGp5rPPJN2hA3b8mKUKWblda55JC6X/pTAKvEn1Etwmu3YDPZxaSVaOl
oW28uJaoib5/Re/rrp/p+0gpfAi2Q9Texp7khGWuD3J0NUrPKgoaUeJKV8DS/Fsm
AVTmSQZ9Ab+iBoS3eqVFwyK3glQWCO1EOPV85OOZ+sNJKQOq+nJ7JjYBa8+X7laP
wUEN3VN91qyh4h0FaPH5
=mVMH
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--

--===============0088237818955974367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0088237818955974367==--
