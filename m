From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: davinci-pcm: Convert to use
 devm_snd_soc_register_platform()
Date: Tue, 22 Apr 2014 12:51:41 +0100
Message-ID: <20140422115141.GP12304@sirena.org.uk>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
 <1398164594-29169-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7291650060715497813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE1C261AB0
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:51:53 +0200 (CEST)
In-Reply-To: <1398164594-29169-2-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7291650060715497813==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+/nih4Q6YcCBn4mo"
Content-Disposition: inline


--+/nih4Q6YcCBn4mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 02:03:12PM +0300, Peter Ujfalusi wrote:
> Remove the cleanup code related to the platform from the DAI drivers at the
> same time to avoid breakage.

Applied, thanks.

--+/nih4Q6YcCBn4mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVlfKAAoJELSic+t+oim9bjQP/27sVLog1T0IQRu1G7zKeE7r
VaVnjXNCYzdqUYTrIFupfsd+Js3JhqIRqJwshozdYnR/ZW16qvSybnxXeyz5I/Tb
JPJ66Lw2vVcbN/TvHWL2lJKyuVjxDKzMbPn/CW+b4HoaTXYcRFN+orrYC+0urmEf
VXSVEa3OqyiG0KohcqT5hJcGmiy+nb/+VdZSwSWUqWoOMeR8JKNO0G2KMrwIq2JG
Hr7xqMn02MXYQLmwYOKChIJOlooRPwRhBQ9tdzVCfk3h5xxjCXBujhK4CO//6DvG
2ah/f2bH2Qza8xQ2kBmMr9xnM/h874rCDpkd+M+J3q92jdDwsVhXvuXtARQ+MhVv
g7nxP7HVBnGbuDJsjB7+CSQswAPJ3npEEz/okSLGbA4iTA1nwTRHHFLVPSrywUlp
DQ6wxSPAspqcPvGFdBUhRLhpQRQaTeOnuiQztFqY1QWsd3V6Cr1L2mrJuOly95xC
LP4NTfnfwYbk5kfoYgEr6+i+fqtT1qQDzuDwLyDzSElyMfXixPgnMoctFayhw+K7
leyQGUcJdWFanJI38u1ffrI5fqPMuMbGY4WW+6sfMOs4UrLbY0B2vqwcMrDPR37E
AboYmD4D3SR1JqpeyOsO8B/KYqkECoBW89BITuw1fkVsXkyt10op3w4P/ho7yVA5
OYt3y0PJ5sEQVVAVbCw+
=CIBl
-----END PGP SIGNATURE-----

--+/nih4Q6YcCBn4mo--

--===============7291650060715497813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7291650060715497813==--
