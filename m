From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/7] ASoC: hda: Add skl dsp init and
 registering with SST IPC lib
Date: Fri, 24 Apr 2015 18:36:57 +0100
Message-ID: <20150424173657.GA22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2660720055861506128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4816F2605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:37:02 +0200 (CEST)
In-Reply-To: <1429390653-8194-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2660720055861506128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4gDbFG3ar2iXiHcT"
Content-Disposition: inline


--4gDbFG3ar2iXiHcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2015 at 02:27:27AM +0530, Vinod Koul wrote:

>  config SND_SOC_I2S_SKL_MACH
>          tristate "SOC Machine Audio driver for SKL Onboard I2S"
> +	 select SND_HDA_DSP_LOADER

Looking at what this is modifying it really looks like there's some
other patch series I wanted to look at first?

> diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
> index 0cc2ac69a9ab..914ea05da6aa 100644
> --- a/sound/soc/hda/hda_skl.h
> +++ b/sound/soc/hda/hda_skl.h
> @@ -1,15 +1,3 @@
> -/*
> - *  This program is free software; you can redistribute it and/or modify=
 it
> - *  under the terms of the GNU General Public License as published by th=
e Free
> - *  Software Foundation; either version 2 of the License, or (at your op=
tion)
> - *  any later version.
> - *
> - *  This program is distributed in the hope that it will be useful, but =
WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e for
> - *  more details.
> - */
> -

Oh? =20

--4gDbFG3ar2iXiHcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn84AAoJECTWi3JdVIfQ0PIH/1mQ+HqMTDiFZ8AEE1LRQttK
j/RzAz3JVCTaL7bnFov/QAySYeJgmcbk+uY7qSLX8eoPsb6PbI2ZGq0bLM0pmCA5
UiRxZtx1ATc8XYekivr5BBm05Jg+fzUacl05JnXhAM1zPzDL5f6U63v1RLvVdDoG
LTy5abuZzLp+SSDB4/EnkNvctCtfmpnPcRxGby19itRZGWR8w0xgOex68nu/wE7d
akhR0bLJ2oD9Yt/r1iu0+BxLEwV+5HuLaZFMb9phZffDpPfOaddBNX319BeieR1q
+ISQHS6nzhaKgLYEIJHCXDVdeJgXHe+zb8AWVHCbihyDr0cKmCaR53rgyFdnJ0o=
=2x4F
-----END PGP SIGNATURE-----

--4gDbFG3ar2iXiHcT--

--===============2660720055861506128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2660720055861506128==--
