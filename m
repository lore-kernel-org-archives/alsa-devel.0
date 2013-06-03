From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: davinci-mcasp: Remove redundant
 use of of_match_ptr macro
Date: Mon, 3 Jun 2013 16:46:25 +0100
Message-ID: <20130603154625.GP31367@sirena.org.uk>
References: <1369221817-5123-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938457582073193963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 87656261ADA
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:46:28 +0200 (CEST)
In-Reply-To: <1369221817-5123-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: n-pandey@ti.com, alsa-devel@alsa-project.org, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1938457582073193963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2013 at 04:53:37PM +0530, Sachin Kamat wrote:
> 'mcasp_dt_ids' is always compiled in. Hence of_match_ptr is not
> necessary.

Applied, thanks.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrLpOAAoJELSic+t+oim9E+cP/0ZiHr5xODZn/5PfuwS3b1dt
LOi3yrt6tS5nU2qYaxQijH8IotThxtltqS8y8Lj9ku7Vmfih2Yecwir6EvRWorM6
R79Sq1QPu9mlImeswds5vR4kaOKJN1IWhrA0rEiYNjVVarWgm+NAalXPVW00vORU
P45MQYrkFPgV8EFAR6jLyM+xaVuvaOcjA54m4MeRrmyAzDcM6a2ye5qkpxtg13wx
qJmz9srHWHvgw/oqzQVzmKNew+w3QRrO3Bn2j8ktSim2OvOa44QjzY9gMp7g4TbD
UKDoKfP2i9gLwRzZ2sBcDifdkyku8a5HfpMNJhniPTVeXI9xZZ5lHRfHdBLtke6e
SXhDK5sp2VsgMv0cdEJ9PMiDjbaFvDYCrg3PXJySmJ8y3thb4CC6ydnHF4MRrQY1
9hQuEqxqRorh3RDJj49Biij1BiAyipxZo+5ztQQHvs7TjJX3N4oHNAiyjx6igWFp
s8ePoTjF5n9TYQK1XwLNybxsDDqAkCT9NKdqeXtkbB3XDYEegAiVvkam/IrkmHyf
4Z0uFDNr4A9NWsjQbMZ8MOxf4UMrqrWLwZZAx6/Rq7lC0nK5h454eCNNZuwye0dk
wMsEpOobEg9EOWtMh2/dxoSJ6MnEU4XgU23SS8WZDfMiFOcnUgcPa02zGaoAb7kl
HJVCFjgoFQhPya4fdlD2
=bdti
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--

--===============1938457582073193963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1938457582073193963==--
