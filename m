From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Thu, 31 May 2012 20:09:12 +0100
Message-ID: <20120531190912.GF24139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6871156806207525790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 125E3243E2
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 21:09:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6871156806207525790==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 766812e6d5e2e23be1e212cf84902d5e834dd865:

  ASoC: sh: fsi: enable chip specific data transfer mode (2012-05-19 19:41:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.5

for you to fetch changes up to fbe42f66c66c279b4ed9b8f515058a09bc731c49:

  ASoC: fsi: bugfix: ensure dma is terminated (2012-05-30 11:04:12 +0100)

----------------------------------------------------------------
ASoC: A few bug fixes for the merge window

Small driver-specific updates.

----------------------------------------------------------------
Fabio Estevam (1):
      ASoC: imx-ssi: Use clk_prepare_enable/clk_disable_unprepare

Kuninori Morimoto (3):
      ASoC: fsi: bugfix: enable master clock control on DMA stream
      ASoC: fsi: bugfix: correct dma area
      ASoC: fsi: bugfix: ensure dma is terminated

 sound/soc/fsl/imx-ssi.c |    6 +++---
 sound/soc/sh/fsi.c      |   25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 12 deletions(-)

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPx8HQAAoJEBus8iNuMP3dldkP/jHw/0AGwktqqJUFXj12hnC8
k9DqMMKk4enWqsyodGpdgAtoPQe7HLmilbcu3/5Wux5OD5taLuORMM7S2EpxdOAT
pBPgbY330T4F1KmZ+pVb+cRJ0RoIvQHn+X+e3IAA8HLXSTRW/fpzj5wVXUI10Vkz
vrMEV+fD8scq1qTrkY43upHUn6gjIn9/Usu5QkxMPRsE87DdkcjUTth2hLpQ4zAn
aDyH+Kj1UlmH2eJ3IkUKwVPBYAVUQkmZPUbTD7Ndl0jAhSnGy3teN/IDic/t32ds
zHYn/XFmtIO6CJds6nLdsVcjYXuIEniDkNk89cvIeTRVteZp5lEFny8ixsg0V2sv
u2skMSr6mCIKTo20Rxvn/fIUdNy+X70qKlxlBu9rRd0OwnFGd+6t5rzQRrkmTv/h
ETp5GxdBmJ1K+6pmyItmDiUwjjIdiRmnIF+VnB5n1ysnQ3NlcWHC0xd7E6iNZcL/
tnX1rpMQ7K7buR5DnAe35IfO2AlE8QGPU7A0JjsNGGasKhJdy1U1Xf+4htDqInmk
TH8FIq5lwEbwJQivPd/d/Ojg1ZTwF+dxGfWQU5g5qAgoFQpac1m7GjuPcTLf+R7I
vbEfND7p1mWqoPa3RlB7Ccg8DxDxZVmQzugzLzWNC9edL9bgsugjnV/9sE3+1jJ1
Rpx5nkdb7YRTent9/LKx
=JJxf
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--

--===============6871156806207525790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6871156806207525790==--
