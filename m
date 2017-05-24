From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] drm: dw-hdmi-i2s: add .get_dai_id
 callback for ALSA SoC
Date: Wed, 24 May 2017 18:38:49 +0100
Message-ID: <20170524173849.h7jkmkrwk47pn6kd@sirena.org.uk>
References: <87efvnosnb.wl%kuninori.morimoto.gx@renesas.com>
 <877f1fosji.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7101278665882627258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D40626680F
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:39:03 +0200 (CEST)
In-Reply-To: <877f1fosji.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Archit Taneja <architt@codeaurora.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, David Airlie <airlied@linux.ie>, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============7101278665882627258==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7ry6pxh7hnsyemh"
Content-Disposition: inline


--z7ry6pxh7hnsyemh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2017 at 01:40:47AM +0000, Kuninori Morimoto wrote:

> ALSA SoC needs to know connected DAI ID for probing.
> It is not a big problem if device/driver was only for sound,
> but getting DAI ID will be difficult if device includes both
> Video/Sound, like HDMI.

As far as I understand what's going on with the graph code this seems to
make sense to me.  How do we want to go about handling the patch?

--z7ry6pxh7hnsyemh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlklxSkACgkQJNaLcl1U
h9A3owgAgubZNqzW6X14qoY2SVNqIP0Qb9kB37bIY4p4pul9sDwcYCryKenL4Orv
jDZDtztVo4bkm0izsLgY/tKvxwvM8GQJhCRbgd3IAa3BaBTryxJCGStr8FfS2BSp
fieT/QpLDbaEmRsK5FSmeD0+aGv0RFTxwS+DXUhAT8AAbselWnbcA7f/ajCBdjQx
Vr0X7VGfiVlEFOADDQCy2cM2o3lySDKhwzr9dQhHwLZoh/f4ZS8QOk8v6Q/cFKn7
cfKvIRvW2sgDsjcKVDky2pDsYCSFQxlYOszH84nlEmZsQiJljXds7R1GOUUUx+5a
T7345ppDJvWXvG7+Qo3iSqwApXKDKw==
=ed4A
-----END PGP SIGNATURE-----

--z7ry6pxh7hnsyemh--

--===============7101278665882627258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7101278665882627258==--
