From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: tlv320aic3x: Remove deadlock
 from snd_soc_dapm_put_volsw_aic3x()
Date: Fri, 7 Jun 2013 17:56:28 +0100
Message-ID: <20130607165628.GB31367@sirena.org.uk>
References: <201306050849.47726.Andreas.Irestal@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3924234790166321004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9C2265772
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 18:56:39 +0200 (CEST)
In-Reply-To: <201306050849.47726.Andreas.Irestal@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Irestal <andreas.irestal@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3924234790166321004==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dvt/r6Ni5EVC4pO2"
Content-Disposition: inline


--dvt/r6Ni5EVC4pO2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2013 at 08:49:47AM +0200, Andreas Irestal wrote:
> From: Andreas Irest=E5l <Andreas.Irestal@axis.com>
>=20
> When calling snd_soc_dapm_sync(), it eventually tries to lock the same mu=
tex
> already locked in snd_soc_dapm_put_volsw_aic3x() and a deadlock occurs. By
> moving the mutex unlock to just before snd_soc_dapm_sync(), this deadlock=
 is
> prevented. This problem was introduced in Linux 3.5

Applied but as covered in Documentation/SubmittingPatches you should
*always* CC maintainers on patches.

--dvt/r6Ni5EVC4pO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRshC5AAoJELSic+t+oim9SnoP/3M8UUsab+sRPQn5QdUc8/fc
+JTjrsViVQ4A70Hx463p7IbfHqK+VneNvVoB7euOwitxg+LaSSrJg+gx3YlX12E0
DWB3JhjUpLKtOexTBZ813Ei6pxIwUZc65bMghQfoE1AWFdZB7T+LGrerRiRuKtu0
4AE6p9eARPU0a0uoj46OFEt1MIMFdJbz5wcbF5RVj4sYxYOMxuLCsSGps3UN4LWw
u3G3HWNLxQgH29oeEC5t/yxxzCv3uQQbt4QzwyZnvhYs2evxVsQaRDshiTIokX2e
K9C3icRLvoFnKNBxe3QkzxKZMQfNUhKIEJmBNcE/kSYivlsLZIBH/1m3eBL2E8Uv
biI+kTFsHDcgrdVACajFeences9NnZQQHVGgwLC+2j+nZWrvXqRmtiFVK/j6piQe
00IMLFlVSDKUpbxzRzaKBK9AQryRaYjElnGpGv4lL+Uv5vgKHHIoYqFPh2F0dO5U
TXTr+q59mjyJRsySy2VdZrsMdDfvb/v4WgGikoHOoXZ/l/XZNfSCuwNdPK6V6XF2
nWOx2VQ/pT2CX7RWoRkilB/p6csxjqOvdX4nedG2wTBaOTbr2lfELf6H7apepCtD
LUNkp4Cg71RujEIcPZpATP39hejF/zYojSpL+KjvCVo+/LFJEM5zPA8+aA0QApC1
0LYYZL9CH795Ib9GImf4
=pgCP
-----END PGP SIGNATURE-----

--dvt/r6Ni5EVC4pO2--

--===============3924234790166321004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3924234790166321004==--
