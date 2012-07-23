From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 12:23:04 +0100
Message-ID: <20120723112303.GO4435@opensource.wolfsonmicro.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <CABb+yY1-RyuCigCYM-dwsc1D1vSvy+QX1nunrc8G+3bT2n134g@mail.gmail.com>
 <1343039998.1726.4833.camel@vkoul-udesk3>
 <CAJe_ZhfnSkYz_zWbHTs43GtCdvisiq4xztV9xcbW6i0jj7boCA@mail.gmail.com>
 <1343042227.1726.4899.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2943664818793380709=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 622B0260324
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 13:23:03 +0200 (CEST)
In-Reply-To: <1343042227.1726.4899.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, Jassi Brar <jaswinder.singh@linaro.org>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2943664818793380709==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GYaKytDE8aa4+VVK"
Content-Disposition: inline


--GYaKytDE8aa4+VVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 04:47:07PM +0530, Vinod Koul wrote:

> a) constant delay in DMA FIFO, aptly represented by delay
> b) dynamic buffering on input DMA at DSP and during post-processing.
> This is before the circular DMA at output, and this patch attempts to
> represent this buffering.

The delay in the runtime can vary too, in ASoC it's currently updated
every time we call pointer().

--GYaKytDE8aa4+VVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDTPfAAoJEBus8iNuMP3dpKUP/RQQ8aIc0bxObYj3ybHtuQgc
15G4RvxbVon6+9TfAs7krmdmeYYXEa7zNE37qd6y44es4pxuIv7WcoYtsNwyW0Wk
feBr7VYRA9ZNI93XWn/IWLRtcj6kA2jZUNh+KAOM3labW8f3KpeEbFbptoP2nbkq
5K10YAcDm3ABS8pzVm6ZwSlHDODSY5yPv3MIGtiU0zM/8rlwgM+b5DMd6UEqY07I
0dHtZxHUrqMUfN5izVNKirrfutWtHxC570+anSOZ+iwUyTroMeV7ne6RVimJH49D
LTLUcq+jxAHxG2C2rTVJXO/VCL0CuXXwzTDdcjyhbgWlt/o6Te2XLuzBLdmAB9eu
yGL0JVdDAdTpoBJbxo0zJpWjmuZHskwhkK7ljoF+eljg54RyzDvexRuiLIRV0uUW
YZdmyxrKu3lujD9YxQSazbdkerHCwH4n3lDSomgqdQP+pumCzeLhGAR1BfYNSBIa
UefUNTuW99eojtKVp7Eu5BjnNurJPdxQgs3atTKy1VIoEdHfZvTdOhoOhGDJvoJm
xcY3YGXMqQThFle1sbRCqu6QwDf03Cb0rVP1Kzd031Bkph1VPQ+b7HG0X6mr08X/
pFmkPwYSws62F3zIt4Dwa3eB0hg479VEOsFI/FZa/MJhiFOpCnZv/KEQy55mkWNz
LJWBiBH7v0TBJxu48sUO
=8F0+
-----END PGP SIGNATURE-----

--GYaKytDE8aa4+VVK--

--===============2943664818793380709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2943664818793380709==--
