From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Add device's module
	clock selection.
Date: Tue, 31 Dec 2013 16:59:47 +0000
Message-ID: <20131231165947.GL31886@sirena.org.uk>
References: <1387783538-5318-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362333701458662172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F163026030E
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 17:59:51 +0100 (CET)
In-Reply-To: <1387783538-5318-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0362333701458662172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jZUYryPdXB7p5neD"
Content-Disposition: inline


--jZUYryPdXB7p5neD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2013 at 03:25:38PM +0800, Xiubo Li wrote:
> Try to get the device's module clock if the dt has no clocks and
> system-clock-frequency properties.

Applied, thanks.

--jZUYryPdXB7p5neD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwvgAAAoJELSic+t+oim971gP/iNO4EQCaDJNOubtELWS/Sy8
g8GaK49gHiS3Nv/rAkz+UvHSf5rWjOjIXjHHkf5iT79yg4SkHieIayA/rX3Pdii2
pPGbjrt6QRi1CvbkS0/RPH1SrtHdvtaybPynP9wnREgTHS0NhaOfiiPTIZggA3Ix
U6qEf5ev0dGzrqYG7uT5FTFlD0YpH5m6QVdUkvrPxF3Ukxjq147AlYKaZjGoRPgY
TyuD/om3oHCEj3hIcVyL/YBO75pkrZN+iAVXNTRt1gHX7YoYhPg7uy7zHClASsWb
W16lOG2Tg1A8WNvloFDZ+09YlvMLK5GS/k5ve5n9qtgYuS39g7JbetyB6ScVl+MX
y1zn3BAYoTfdCpr8M4X36kEsBOsGg6h3a2aIBJST67omzck4HwREHAvPh37d3eTe
6llP3rlbS4WNEPdsKXrFjEj+RI+pSysdn6DddqUQwFR4u/cXMQRo54lRdXAl45qt
doB+/7trt/gDCo7AmIYGGOcHlkG8OcddHZs7xBV81u5MMb1dZyVAW5RPt9rKlYIZ
qXBjlnXUulhrJC+mCjz+UM7ZqSyYLhZ5o/diKcJIg35GT79908C8qlLEfdWPQkt6
ItPUe8h74HSRtUS+wq225RKv8qsorLtIO3ILf61s++dMYpLah10BkW8qeYIFJE7h
BR/VTtmrj0XuLtpinqYY
=LoFk
-----END PGP SIGNATURE-----

--jZUYryPdXB7p5neD--

--===============0362333701458662172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0362333701458662172==--
