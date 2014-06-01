From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5640: Add RL6231 class device
 shared support for RT5640, RT5645 and RT5651
Date: Sun, 1 Jun 2014 20:04:47 +0100
Message-ID: <20140601190447.GO5099@sirena.org.uk>
References: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4777632923199214605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F8582608D3
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 21:05:02 +0200 (CEST)
In-Reply-To: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4777632923199214605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YqkpBxMMfeZoT90/"
Content-Disposition: inline


--YqkpBxMMfeZoT90/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 03:01:53PM +0800, Oder Chiou wrote:
> The patch adds the RL6231 class device shared support for RT5640, RT5645 and
> RT5651. The function of the DMIC clock calculation can be shared by RL6231
> shared support.

Applied all, thanks - this is a nice cleanup!

--YqkpBxMMfeZoT90/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTi3lMAAoJELSic+t+oim9D0MQAIFsn2m8tZ3A4cCD8pCI3RlY
Qp/OJ5+KSyYvQ37TxVYdZqaRjxb2cuJLZTLMK8ufmJtKY/FfrOz8xTp1bASgGvH6
7UD7PfEEkiRsy3iYzD4CPQgNEHm6UXEje2x4s65HkEGWlB/kaklW9Vbdp3WruLO1
pAwKMx+4TtaoSx2riupo2+5phs+gmqM+DTjr6Ul5Gkfj6mD/IuzrRK9ICXnz0EzV
FzG/nWIoUd1b6kX2C6+T6fuEC4bWe0rQK+rcr4jg6u0doFmfCfE5FRdmaH7Qrm5m
WnXwPmExjyY7JUx77/+zGVCJThXpOehw5l2YTohDrJZJyQbummcpkhYzVyN2bCCB
1f9FYcCbCXygSFHX6X/zco1HMLN6b9ZGKCIfp179NG0MY+uXFn3dOSfWzzzr2gpY
/VKbMPaIgu7cwIjBazryYspW97DyHm/YTI/m5KP9/6WvghkmwAEz9yiHvE644Xha
vKODMW1inzQ22UZJ+kIgrxWqAjD3DiBq3K3FPqVj+qMF5icg6cWGfp380b5OEKyR
NI2xpFTNQOxRk8kJr0k6UDFkTwsEE04okIbDEJZ/fbqSRsLNsyn2G1145td43P4I
JP1u8QOUgybSsCqCKm2Pey5vdqXFC7GIlsvT6yWyoQeZQc7QNAglmyzDYgJjbn5C
wh2SfeZevUqt+AibfwzY
=7vY0
-----END PGP SIGNATURE-----

--YqkpBxMMfeZoT90/--

--===============4777632923199214605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4777632923199214605==--
