From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Date: Thu, 13 Dec 2018 15:31:27 +0000
Message-ID: <20181213153127.GN10669@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5318335275096821029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BCDD926789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 16:31:29 +0100 (CET)
In-Reply-To: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org


--===============5318335275096821029==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ASoC I2S audio support
> + *

This looks otherwise good so I've applied it but please send a followup
patch converting the entire comment block to C++ style so this looks
more consistent.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSe04ACgkQJNaLcl1U
h9AApQf/ZYZreo/i4fqhX4ZisqCS87wTmjedquBnDbFr4A908f5mKat+VrZEor9g
qfdXB6YMTRb1BPFQrFqv93f/OxjbZeM7Gztv8B7n7shGQ9Oh1Xg0pPLYSsvZLZEm
ZTt2TwTyXgm2A0xiiLbTuXlin/tilgBcNUK2GvMPaD0vEftBJJplV+WkxTe71U4F
T5Umnu41+7kcm0EGdNyIu2q1/NZAVkvvyZGKeJtRIHNdT6XKbczxHsN/tDp8Xalv
LqTlJiSNDOsG+G5zKuTZc3Ae1M8sx3NNWs3Tybe0dyC3tbuGiny6pNkkOYNs2OoV
rxwnrk5IqefawbCi6uDMdfNRXwMvxQ==
=36PQ
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--

--===============5318335275096821029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5318335275096821029==--
