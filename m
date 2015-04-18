From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: wm_adsp: Add support for rev 2
 firmware file format
Date: Sat, 18 Apr 2015 18:26:30 +0100
Message-ID: <20150418172630.GC26185@sirena.org.uk>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1428928085-20250-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8053569542927901189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72711265132
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 19:26:37 +0200 (CEST)
In-Reply-To: <1428928085-20250-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8053569542927901189==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YjUCIDG0UL7zSTfa"
Content-Disposition: inline


--YjUCIDG0UL7zSTfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 01:28:04PM +0100, Charles Keepax wrote:
> Version 2 of the firmware file format includes length fields for the
> various strings associated with control creation, to reduce file size.
> However this does increase the parsing complexity slightly. This patch
> adds support for the revision of the file format.

Applied, thanks.

--YjUCIDG0UL7zSTfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpPFAAoJECTWi3JdVIfQRgoH/Rh+jx6SVmtYhatoXmTh29BE
MxpXE4CfRs8ye4q81/LD0UUmbtG8gZfKJvCnrbHAfJXfEZNkFAypTGlkJHOzmyt+
ch/fVxF/rpoppNgpqvMDnNvphPA11fNXltOkNlnyS6A0dlYNES+l7qVcc3HJiqbp
2LobcUXBBJm6OrMREvd8s9GmMnRXKTuDRmcFORyQtEMc09LKDpDhwE44OUxfBrL1
nKCHj/xYAnWiBB6lQAvhS/7c7v4+1vSXWXtC5SJDlgnA5cPsEsH5uMeU84ANZJTA
oB+t0/kYEbGraQ3JaiKU3v7Gbq13LQqbt4w2yW9xiigcyGb2Xg6akSZ1e/LuHVw=
=2lZr
-----END PGP SIGNATURE-----

--YjUCIDG0UL7zSTfa--

--===============8053569542927901189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8053569542927901189==--
