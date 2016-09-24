From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: erase pop noise by soft mute
Date: Sat, 24 Sep 2016 20:11:56 +0100
Message-ID: <20160924191156.e6mu2vlhhaltkeua@sirena.org.uk>
References: <1473839252-18868-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7430814626086127553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 314FB2665B0
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:59:41 +0200 (CEST)
In-Reply-To: <1473839252-18868-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7430814626086127553==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oifhoa2jdupt6j2d"
Content-Disposition: inline


--oifhoa2jdupt6j2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2016 at 03:47:32PM +0800, John Hsu wrote:

> + * Enable soft mute to gradually lower DAC volume to zero;
> + * Soft unmute will gradually increase DAC volume to volume setting.

> +		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL, 0);
> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_MUTE_CTRL,
> +			NAU8825_DAC_SOFT_MUTE, NAU8825_DAC_SOFT_MUTE);

Why are we not just exposing soft mute as a userspace control like other
drivers do?  It seems like there's some weird interaction between
sidetones and the soft mute which this is trying to work around but
that's not really explained, it seems to be the main point here.
Basically I can't figure out what's intended here.

> +EXPORT_SYMBOL_GPL(nau8825_soft_mute);

Why is this exported, how will it be used?  The function seems to be
called from inside this driver as well...

--oifhoa2jdupt6j2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5s/7AAoJECTWi3JdVIfQYngH/3MndJWwlm833q0CnSIQbhd4
r0WP9+4n/Z7HpHt6bvTH58v5e6TFOWlUX2MswWTD51N4D6wfzsysfkj6qtlAr7rv
LKpMVN/VJ0WfoS1f+6rj9yarNCZdCQZ/+IGRLg+FmyLLFiYgj/cE2z6VR+oRmvtQ
pQ9twW4M5GRqmR2V5jpGHWNTrUmfb5LELfiDkoh6jHQDZlFdJvn8vQPln0xWVzGr
xR2q8x9ezKOvrRxE9q2cGldrH2GueBSte1Ajf95ltKY3lIeTteaI/YEKSbAWUeA7
idkNs66irFn2BTCqBsA1tKDm/GZu2UmQ1WO0p1UAHMBBWunDwPG/jNld2A+zu34=
=Ujm5
-----END PGP SIGNATURE-----

--oifhoa2jdupt6j2d--

--===============7430814626086127553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7430814626086127553==--
