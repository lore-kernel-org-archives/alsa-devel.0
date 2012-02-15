From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Convert pin switches to use
	snd_soc_card
Date: Wed, 15 Feb 2012 08:36:09 -0800
Message-ID: <20120215163608.GI2996@opensource.wolfsonmicro.com>
References: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329300564.7841.3.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2836829990498173435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DB571039BD
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 17:36:14 +0100 (CET)
In-Reply-To: <1329300564.7841.3.camel@odin>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org


--===============2836829990498173435==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 10:09:24AM +0000, Liam Girdwood wrote:

> I covered all the machine drivers who directly used the old API with the
> original patch but I'll also do some further audit for indirect users
> like the pin switch.

Hrm, what about those that use the table based init?  I just did a spot
check on spitz and it's still expecting to get a snd_soc_codec back.

But now I need breakfast...=20

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO97yAAoJEBus8iNuMP3ddu8P+wdMw3ywwBZYnslkyv0wBBBB
RhaKBqjNKoV/S8Nge7HjuuhPEKgQmLXRLoTgxOSPXWHGqEMaumXltnfy4nsGdW2V
ezJnQ7A3bx5+LJj6voDg9wGyNS0gegwXBHI5eKmJbHD2n8JdCHgQ+rM9xoSLC93G
3hAHf5hM7mALPJ1KRqx0VVLolF/z3X+Ql7AA5kOHke9k7r0urGIXnAIFDyOwol9R
bpHuvNqPM35d3UnzlCXdXAJCLdH0kY4WCfT/pVkDNUVcIQxFiKajAE0htdQ4F2Uh
f6hgILmdmcIutw4adq7SNUa70VsvPaHK2N5JEThm23+clbfBo7GAAYpEXMkSaTYo
pCdDldBFTwbUdHHzE0fcTlpXkmk7iCtbiaX0LlK8PxckGuuCS9NdhYEwnWFGdJjF
2tmpFcRnAdS/QR1ykjYcRh+dDTthbY9dCG1T0XkQ5EsLmQ1y2ZbhBH1XjQCJQXmk
p+2TDpn3rfLsDx89/2c0ILArCLCPlMnrC4H8oGHe4dz6ebECnR0gcHXcfbRGSrW3
vlpkko4pwTcd3nZ7KLx98Z6brbSs3Ld2vDOlnxznh95mUPEhZvtWepqFMH61fgmX
A5rYQQ+fZt1VpOLXAXHjS+PsNSvPpR8Z75bptUtzYj6eE3+DxPArKnoy/LfsrSzQ
M7bYddyDLxoz4s3UCde1
=RWbO
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--

--===============2836829990498173435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2836829990498173435==--
