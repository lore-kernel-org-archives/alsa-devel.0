From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2][RESEND] ASoC: generic-dmaengine-pcm:
 Use SNDRV_DMA_TYPE_DEV_IRAM as default
Date: Thu, 7 Nov 2013 19:56:14 +0000
Message-ID: <20131107195614.GY2493@sirena.org.uk>
References: <1383806716-23469-1-git-send-email-b42378@freescale.com>
 <20131107113218.GU2493@sirena.org.uk>
 <s5hy550tp39.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8532985890951637338=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2432C2602AD
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 20:56:28 +0100 (CET)
In-Reply-To: <s5hy550tp39.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8532985890951637338==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1tcKVLXPU0QafK6"
Content-Disposition: inline


--+1tcKVLXPU0QafK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 12:42:50PM +0100, Takashi Iwai wrote:

> It's an ASoC helper, so would you take into your tree?
> Lars already gave an Ack.

I can do but it depends on the IRAM stuff which is only in your tree
until the merge window is done - seems better to either just apply there
or wait for the merge window to finish rather than have me merge in the
changes?

--+1tcKVLXPU0QafK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe/BVAAoJELSic+t+oim9CK4P/1KCgFrORIF7KRSb2yjLoLj3
LbLxeX8/S0KnCDyAYXP93aqRiXWJVEOFKB9roWruB+5LHdcp7hfvsPkSNonQJgp4
DIfVZtViKoi+GGv8SHW2qR91f44ViZVVx3O4f2Iaz7ur9/pICo7zFIBdAoAyYpnn
x5STeXXuUZYAGHv+HshcXBLHeqrV+qRLZGW/chvoXMwk494Xq5QB+Jjh4yoK4iqg
drGOdcRUiYbatOlUJJGYQsJSQwcJBCkAvCq2pI7ZLqCYNIcSpkaS2SFSXxlmG6w5
MvBge3iNGBw1/YXuB2R8UlNWSZ8cAaU2sra6iS60E64dchVI5SpF6WIBm7dQXFXd
D+lgfPbTi6QTTkgpcieg+jTEX5fSCFrLEiAWiYYbVO51pdrprRnwr5Yb//YsLpTl
CKLFx1uEz1AT/3x5K/bu1wBu8cVAjHEI3cxnPa5+qcEB1KzesWY3q2rg5zKotW0u
V894j4wgnpqnQDEAVxjozP7LCWSOh0YTOFmTqDpe000daxqNYNCF5WzNeRfNZZug
ePBrN/Q/Zp0vX2H8co4vq/NAqxxEqZYmzzIKK7qWYZrtgc54lix8UFYul1ftZaTc
h7ieY34CAxqDQxl6VWM4byb8FtY4aqvsrHS5MiX3h4D1+BBW4G7MutEmrfwZRyA2
mRs+LOiNdgc+PeZ9N16l
=iMSQ
-----END PGP SIGNATURE-----

--+1tcKVLXPU0QafK6--

--===============8532985890951637338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8532985890951637338==--
