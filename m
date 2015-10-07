From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels
 capture and lrck-mode support
Date: Wed, 7 Oct 2015 10:39:40 +0100
Message-ID: <20151007093940.GA12635@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
 <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk>
 <5614D162.3020500@rock-chips.com>
 <20151007092714.GZ12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4091100801951982881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81047265AE8
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 11:40:14 +0200 (CEST)
In-Reply-To: <20151007092714.GZ12635@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sugar <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4091100801951982881==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="25DAq431WDHkgiLI"
Content-Disposition: inline


--25DAq431WDHkgiLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 07, 2015 at 10:27:14AM +0100, Mark Brown wrote:
> On Wed, Oct 07, 2015 at 04:01:38PM +0800, sugar wrote:

> > if (dai->symmetric_rates)
> > 	regmap_update_bits(i2s->regmap, I2S_CKR,
> >                            I2S_CKR_TRCM_MASK,
> >                            I2S_CKR_TRCM(val));

> Yes, something like that.  You'll need to check both links in the DAI
> and the DAI link itself rather than just your own DAI but we should have
> a helper function for that - I'll add one, look out for a patch shortly.

Actually no, now I look at the code you probably want to just clone the
check from soc_pcm_apply_symmetry() so have that be:

	struct snd_soc_pcm_runtime *rtd = substream->private_data;

	if (rtd->dai_link->symmetrict_rates) {
	}

instead.

--25DAq431WDHkgiLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFOhcAAoJECTWi3JdVIfQ3BYH/jksuQKPUoRCFSp/t4omPzpE
0u0yvdinPsTIqYv1ROEMj5sq6vEGSMT7eips2fdbhLFITZsaI2FN/74Y/5UzIqM7
5Rw3wvRAk6TMN6YCCJks+/81NvO79/ieDSYRuhog/zckj9GPqqTSdHi8XM1T6M+V
Q7mkd5PWwx2ZCB74hzOx7AaO+PhLnC7MWbRKUNgGMfwPIUlN0TUV4Zs8WCpstf6b
f9oQ+gGE/xBQTN3i+M0QnuHbgC5aXcx6714+vNKhYNGaWAy5W0qhh9PAy2VwuwmS
kXZmT7DjWEBy4rB6n1IPTJw2TNA0BVnBLzuoVq7ZSWFMheOS5KW2tRFQoWmL/H8=
=UAVk
-----END PGP SIGNATURE-----

--25DAq431WDHkgiLI--

--===============4091100801951982881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4091100801951982881==--
