From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: sam9g20_wm8731: fix the issue for non-DT kernel
Date: Sat, 27 Oct 2012 23:14:23 +0100
Message-ID: <20121027221420.GN4564@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 22, 2012 at 06:17:59PM +0800, Bo Shen wrote:
> When register platform from DAIs, the platform device to PCM no longer
> needed. So, fix it with this patch

This should be squashed into the change which changes the registeration
to ensure that we don't get both methods used simultaneously.

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjFy1AAoJELSic+t+oim9qzcP/jdIwPbBBbNULnYn3rRpWaWY
ZporfDFAY4hgQLQfVinjPS+Br/xyxAyaqqta6m8BO5YIsPglj9c1BwSV1eXhGVks
HY/cwHPq31jGplZCOHxTfTkz4oMmLgr1M2YE41YobJ3ojLk1rvlaVWWQxPYmJ5KI
tC+aAedy7vl0jJxdtPTUFF5Mq4imngcDmcPzNWIePWzc7pDPFPtU7Mx2DNk82bkR
LdlC00f77/itilWDpgTTPEFmvtjwov7qczlC8zMDLiZwc52QcXSHCN3aKPWycNY/
qcTt/6bNelx9Wc1oBlDVCdtyo7G3kmd9T3bW93wYmN5ijDD9/p51mt0U2O3cY/q3
+ee54AWlHVnL6R1aiwWSi0VHAwloMAJNcVIyMPu5JuvMsh4IsrezAy2rrcXZfAlC
qEC2oMD2thXD5OHCZyzKl8N+ovp/TQIDfcIBGXJ10ajNzKs55RMsOvHSqCV7j722
7PedAYr6oszCbRzVTZiT1tgNyAheked3BEGGHpa7OTh2K0k37rOl2CikCoDE8kOr
ZvvPU/c8fJz0OkkLQPOujfzrXddEMqQ2nhGAp5oupMkW/fBR0/6mq19utX/efzIQ
WgEhNbgmvf07TPGdG9phhZCC0GwjlDWRUqVcNFEq8Hn1+gLN34tRWK8rzR7NJBvA
4iuqFNIWUzrAjA7hE+J9
=45bO
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--
