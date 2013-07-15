From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/10] ALSA: pxa2xx: Fix unlocked
 snd_pcm_stop() call
Date: Mon, 15 Jul 2013 17:00:05 +0100
Message-ID: <20130715160005.GN11538@sirena.org.uk>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <1373893582-17116-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409879340966095134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D90AF261616
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:00:07 +0200 (CEST)
In-Reply-To: <1373893582-17116-7-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0409879340966095134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1HuzLmPZrG5RH6bG"
Content-Disposition: inline


--1HuzLmPZrG5RH6bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 03:06:18PM +0200, Takashi Iwai wrote:
> snd_pcm_stop() must be called in the PCM substream lock context.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Mark Brown <broonie@linaro.org>

--1HuzLmPZrG5RH6bG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5ByCAAoJELSic+t+oim9j94P/1itA1wWS6vcSipa90ubA+6Q
1nGe+kFYeaQQcYdp6FSIP6smXNjuk0p02wBs1QC9VjfgIV5qVFcvIXCpvU2y0YkC
lsEQI/vMhDTpzYTC8IQl5cX5+0jhVVKH6A35VcQzCfpAhCqL3CID+zRktPN/L6da
DfEsPyqRCV3A7VTOwZSABNynISECt4aBmtbM2DU79v/ek8Tf+xzzDRtKKCnOpTHj
RKdIObRWRxISfkyb+zEeD59xN3rmjerzYcuUBREcVRGFfbXd7Fphjq7uq/LxMOvR
WHf6h+COLzUO0ZEYY6+di9sR1aGvaimalj02aVahWztmd+ibIUHRY5Zt7tFHjfJ9
gk8/9xYmrFhrPU8rUl4p5eXH9sR/rjINReiFifiPn+1gtPxrPNTcw0BEjgGIMA6o
23UpWZ27xIMuhAOW/T3jX6dEvKH6MxidHxl9QEaxK4V3wyYr8LzxOSXmTDIUXcpc
3rFLFcSUAqt2wWeC/s8rU4ZbBdhAnZFHIOf8eomP+PJnoHeMxC+86V98kl/2cFQh
6giQhwoZF/AZbw4FIExGHwZnb+7EXxjVTPNObfTFBZYatFy+x9JxHPxNDDyOwoe3
775EpFPCoQSqlVdOJtGLnPAIeHsp7QLmDXkYXN54LNCfbu5xaiBiAH5X5tbSI/hS
CHA9U3pFyszGRGSRRrZ8
=0XY5
-----END PGP SIGNATURE-----

--1HuzLmPZrG5RH6bG--

--===============0409879340966095134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0409879340966095134==--
