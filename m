From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: assign DAC Ch to match
	headset L/R
Date: Wed, 30 Mar 2016 16:32:31 -0700
Message-ID: <20160330233231.GY2350@sirena.org.uk>
References: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
 <20160330173920.GO2350@sirena.org.uk>
 <CAOV7ByLnc63QJyJhxLoCuD590bcg_mvhcb2cPK=zd=QYy__maw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8962295831833901880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B234D265041
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:32:43 +0200 (CEST)
In-Reply-To: <CAOV7ByLnc63QJyJhxLoCuD590bcg_mvhcb2cPK=zd=QYy__maw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8962295831833901880==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5DFjIrIHbGf/FHYW"
Content-Disposition: inline


--5DFjIrIHbGf/FHYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 03:55:49PM -0700, Ben Zhang wrote:

> The channel selection is already exposed by DAPM widget "DACL Mux" and
> "DACR Mux". The issue is that hardware default register values after
> reset have the channels reversed as R/L. This patch is for

And nobody managed to notice that this might be a problem before the
part was released and relabel things?  Yay.

> initializing to the normal L/R channels after boot. The default should
> be normal L/R from userspace point of view. If userspace wants some
> other settings later, it can set the muxes to get R/L, L/L, or R/R.

This is yet another case where clearer changelogs would really help.
It is a lot easier to review changes if they are clearly described.

--5DFjIrIHbGf/FHYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/GIFAAoJECTWi3JdVIfQeOsH/jA75lx0B/Gar3soeNfpnbfW
EKTt6ksbm62iPQdBsgdPw0AHgzOorBK+7C9L/RETCREt2F4aG0Tf5zkl07LK3QKD
WxQFx2p0htSJEE+hyZakm3niWPWnpqymhUcrDCW352NJOkcRZrQdBAe0XGr0/W7j
n51x974TlqWA8iTO9BtR2z3SH+cH0aQUwi6eDewc2GrIwUZDSVdS+LFCJUIH0sjd
HHGjKM3HTwQjqBCyPDj59hlOFOHQwm1WILtJklGttmIJ/FACPenI+qFubNzIl8E3
sciQhQFLBcz351nOLEE4qgIxBKVx6mROd7P/FUjYhJQKh3WOiPLZEaHrim3oyrI=
=GoEU
-----END PGP SIGNATURE-----

--5DFjIrIHbGf/FHYW--

--===============8962295831833901880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8962295831833901880==--
