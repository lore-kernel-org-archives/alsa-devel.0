From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/7] ASoC: hda - add asoc hda core bus,
 controller and stream helpers
Date: Tue, 26 May 2015 19:51:51 +0100
Message-ID: <20150526185151.GA12911@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683029337919424177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAF6264F39
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 20:51:58 +0200 (CEST)
In-Reply-To: <1431341645-2457-4-git-send-email-vinod.koul@intel.com>
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


--===============0683029337919424177==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 04:24:01PM +0530, Vinod Koul wrote:

> +#ifndef __SOUND_SOC_HDAUDIO_H
> +#define __SOUND_SOC_HDAUDIO_H
> +
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/hda_register.h>
> +#include <sound/hdaudio.h>

...

> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/soc-hdaudio.h>

...

> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/hdaudio.h>
> +#include <sound/hda_register.h>
> +#include <sound/soc-hdaudio.h>

This includes no ASoC specific headers, what is ASoC specific about it?

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZMDGAAoJECTWi3JdVIfQq9oH/joC2ytKY967zI5xzRoeT0/w
FovVOhZJT0h4Gpdjxld0IeNOl0Z8Pi5/rWieFWbp3sRcZMk4BMY7vVdVlol2Nl8C
47RwKewRq6axKHkMwNv4Srk0B4UD5rvOF7kh7Ta/0Bgd7RHtRheuKTb1SZJBB7S3
jqryFPmh+x38r6Mav9q532mCRg9pg/pLmwnMy/RfQYvO2DF9MTy7ZdCQOcTROVEe
nG9Ci1+oTz2lS0T3suMaYNB5OkK2yAbG1EwTdIrNeVxhDPOQLZ12eQLK5scHwDPF
gTUpz1gW+2L4l6VOeYruLHyx0xUZN5o02Zg1VsFE3akCLXy+kG/ZSAg0WSw+dA0=
=1tca
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============0683029337919424177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0683029337919424177==--
