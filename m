From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Remove dependencies of boards
 for SND_SOC_EUKREA_TLV320
Date: Sun, 1 Jun 2014 12:00:51 +0100
Message-ID: <20140601110051.GF5099@sirena.org.uk>
References: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7542602032218376551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B9326517A
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 13:01:08 +0200 (CEST)
In-Reply-To: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7542602032218376551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GVmdUcABewnKtUm9"
Content-Disposition: inline


--GVmdUcABewnKtUm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 03:11:01PM +0400, Alexander Shiyan wrote:
> Eukrea-i.MX51 board was converted to use DT, ie we no longer have a
> MACH_EUKREA_MBIMXSD51_BASEBOARD symbol.
> Transformation of other boards planned for the near future, so this
> patch removes all these dependencies and restricts build of this
> driver to ARCH_MXC.

Applied, thanks.

--GVmdUcABewnKtUm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwfgAAoJELSic+t+oim9jPcP/1/OYdMske6ihPVTAKKW9pX+
qF8fXstUnmWOjcxQXgbBG703LQGS51m1XUOOfSm/V61HyGSIBQuGE95nGFsivq4v
rCOkPu7EUYi5ou8glV/tXgtzW9iOv22GmoQw+gRoVmokHD43SJq6tRvV6yY2ewu5
M0fG7ksxII4hqyy9hz+FKE5CdzEKkoGtrUdNRpBL8p+aB6kFjo/mx8eaCBDI11b4
iB8xIJ4L0KCYjlE8fNADfE5MFafnRwjFsOh0XegfIPcSa6cHLFezaezd7DZ+Hjpd
VUSCx6H+8FfeXHeY9oJwj+3N2TySSPkRh7ZBac1Y8QkpKiAI1zdDGpVY7piur86Z
+9dF66KChIgfsAnohDP60FjF744VUtBpBBlrK4uundsVYU0tjUAmNWVFDgPs24WB
ZsulZnqdqk+W3kiiAqeZGYOXEo6iQniTfXPdyveYWRpI0VrRETWBhbd1PczVRanX
MCQWk9iGmhzXFugPKeZd8HG8ySV5HM5aGy71yK9nqDyGAMcooVgynUC9b8NfAxVO
CMMuGP1Itq86J9DooSuLQmIZLM0CkLiyTdIEEz0M7SxS80huVX1Eq9/5PLx0GfL3
aooXtrmpIl+uhA+kiT8FPRuU4eQ/sD+fHzfOo8vaIBgKAxmk+2cjV6P4P9YMK1dl
EodX/3EOpTjbMLmBZctf
=PmWs
-----END PGP SIGNATURE-----

--GVmdUcABewnKtUm9--

--===============7542602032218376551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7542602032218376551==--
