From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: dapm: Use DAPM mutex for DAPM
 ops instead of codec mutex.
Date: Wed, 7 Mar 2012 19:46:05 +0000
Message-ID: <20120307194604.GH3107@opensource.wolfsonmicro.com>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
	<1331116707-10016-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3958042088819792971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D22A104120
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 20:46:06 +0100 (CET)
In-Reply-To: <1331116707-10016-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3958042088819792971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBd94+RIx/Fx7UDH"
Content-Disposition: inline


--yBd94+RIx/Fx7UDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:38:26AM +0000, Liam Girdwood wrote:

Applied, thanks.

> +enum snd_soc_dapm_subclass {
> +	SND_SOC_DAPM_CLASS_INIT	= 0,
> +	SND_SOC_DAPM_CLASS_PCM	= 1,

I think I'd rather this were called _RUNTIME or something, we may not
have a stream involved at all in some cases.

--yBd94+RIx/Fx7UDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7r2AAoJEBus8iNuMP3dSsIP/ip2nR9Om6NN1UY45t0bIwCH
O/gYCTLcAZZqD2mHwevvpD5lBpHn5vgRu45sQi02U0Rjm1SHlzygffHHxetcXcqq
eK9xgURxs6oQS70mAZO/Oxdcr0tWFVUOjHzKUbFr6K5GNaatR/S8kmXJXMzgaPZ+
2mfCHfl2X/64dlK0fzBu1G02s0gGQUWuCVm93zwIk9xiNBbFcXHp7HtMFMnoV8Zt
uxX2NlXHNSw3p3+Ptgu0r7YL1axDxvJnnO6Wj1Op/iCPs29CUQK3J6jkUF9Iz6I4
D7Im87psP0FdNwdmxmLGO63vlbzpax0fUimlpJJYUsfRCF5dcf3eXPwNyQwAO/Zu
X8HkdBHmEpIOhW0YLNzSFFBmjRQsiGxDeO/yuQfIuqNZVAMUSO9ct3FnK13mK/7R
5E1VONLtKYjNSKAkIN8eB87gX3P9pOGS4Esw8BHb0w7rVcbb1UNQdtzOI5xmqsl9
7N5rlACC3Pp2UMNYzZfKVPUVs61oqDi7jWL3EmYy9+NOg38HU2FDfOD5Uy9fJQES
h8Dt7Xde8fD3i44TgRvmXg4rSs9VxMRb9TjxOflD1SBaXafkTMJOIfoR9tyIizSI
ApauXT27vRvqa3ZZek6p63wqzTpvWwYTE4mwwCzDoatFv+CtPzNE9udiHCLSpAdR
/8MEMFd8odJk9PUj1v12
=xTuh
-----END PGP SIGNATURE-----

--yBd94+RIx/Fx7UDH--

--===============3958042088819792971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3958042088819792971==--
