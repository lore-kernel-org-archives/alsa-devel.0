From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai driver name
 in snd_soc_find_dai
Date: Tue, 22 Aug 2017 15:31:20 +0100
Message-ID: <20170822143120.o4iyxhwq2zfkkie7@sirena.org.uk>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-3-jeffy.chen@rock-chips.com>
 <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
 <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
 <CAErzpmsg9fi0-ukHG13-dy2r02892h+oPXmtsusCbu-xLzazFQ@mail.gmail.com>
 <20170822142111.zlosryhkyi75htod@sirena.org.uk>
 <s5h8tib8yq4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nkpykufwscqwqc2b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8tib8yq4.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Donglin Peng <dolinux.peng@gmail.com>, alsa-devel@alsa-project.org, briannorris@chromium.org, dgreid@chromium.org, dianders@chromium.org, mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, mengdong.lin@linux.intel.com, lars@metafoo.de, Jaroslav Kysela <perex@perex.cz>, Jeffy Chen <jeffy.chen@rock-chips.com>, =?iso-8859-1?B?IkhlaWtvIFN0/GJuZXIi?= <heiko@sntech.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--nkpykufwscqwqc2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 04:26:59PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > We should fix that then.

> Hmm, as far as I read the code, the NULL dai driver name is valid for
> a single component.  The dai name is determined by fmt_single_name().

We'll end up using it in debug stuff at some point, it's better to just
require something be there.  I don't expect us to require it for
matching.

--nkpykufwscqwqc2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcQDcACgkQJNaLcl1U
h9ByyQf/cB0bk6XgtuEXSuY6b+TvLYiKu88FROw1d3GpAC1tGD92ho1g8vUiFKq5
XCbuGGiGquTZ2X9OVvWVKSv9ezTGfsGgojG+PwyxQPlQQ88wGL5zww4ip3yqQkxU
jlm6Wz+IWApJ/7oSGL3SmlZKb2A8PU0wCOEAZeAEfTMVS9KNZuGuF9JONx/qtrfq
ayNcNYxMsYA5R+9JWQSdAkXLa282OJODl/YkjT+2530rwT/sfkb/oApXBHqXFKef
w5Vx9cYSUcxWu20JdaTQyTHqanbu259mBUYPGZkwKe8/xPjp6CXHR3jmwe7XXn8N
u4ByvHCwlIQu7u8wie+yEaeKUvaw0A==
=4ULT
-----END PGP SIGNATURE-----

--nkpykufwscqwqc2b--
