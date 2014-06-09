From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Mon, 9 Jun 2014 21:24:03 +0100
Message-ID: <20140609202403.GX5099@sirena.org.uk>
References: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3145531271276964652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5922651A2
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:24:19 +0200 (CEST)
In-Reply-To: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3145531271276964652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zq1NejLgb6rxdd6z"
Content-Disposition: inline


--Zq1NejLgb6rxdd6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 04:05:31PM +0300, Peter Ujfalusi wrote:

> Correct the hw_params callback to configure the codec correctly in case of
> S24_3LE format.
> S24_LE is not defined as supported format for the codec.

These should both be supported by the time things get down to the wire -
the memory layout shouldn't matter.  I really need to get round to doing
the rest of the conversions to use params_width() which should ensure
this.

--Zq1NejLgb6rxdd6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhfgAAoJELSic+t+oim9oKAP/1cf1U9VCTYKKaSrFpQzIEzQ
ROtw0Ln2kKEVu92qrqcAxLd0lFiYzUUn37urPGf90lypKRxzAdBMGLviwtOi+Ims
lgDNCTunNBieU2ZJaLffevQ6F2c1k9RKiv1LXFGsLzk+syhitEXipId5M9q9U58u
M4MNJAwybvLwVNqOKGUxBE0k3RhVfuryKkJ4N8MEzN4uJlUPnQLaJ0OrSRjMDc25
yhya5Zkc4YUWNMJtbY+vUcKH/DBkT5vT0JxlMxRqQ5Wo/TVMSd0WLx1YqUkof6UP
R0T80Wbq+F8CP5x7FSdXftU6WILLAW/t/6idWy67H4emLyOAC0yqmpDyr8G2Mk8q
xDmG9VekGpLlVCOMJDR1Hbe6lSHRd4zbvA+g8rtNDjG8ynLg/ySEh7XSr0bmrAlb
f1unLhcvfEvJxzRGRWof7iS88yFups8CmsjLuWf/oXKFEHngxzvQ5FRqUYKtFN6Q
lSdYKq5oqvl0lEQJlxosW/YRPpNNkkmVsHOweGYnRoWa8Q0M/v4AM9R1ar0ufg+7
hcIjmbOhxzdS3yJoFPbEg0iBU4TBqDDRZ2zIQVMyAVtgQ2eFFwed7y9iehEnGwcH
MDWfHDu9yVjjgXRvoKCgOfEpqPwrVc1lhPEM+h7P0NXM7++Z3YYvZ7ALWmrpSjDP
tzK1RfsRN/5xZ9xl8lz7
=4NV7
-----END PGP SIGNATURE-----

--Zq1NejLgb6rxdd6z--

--===============3145531271276964652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3145531271276964652==--
