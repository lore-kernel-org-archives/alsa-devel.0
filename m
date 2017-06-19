From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22
	audio codec
Date: Mon, 19 Jun 2017 17:16:06 +0100
Message-ID: <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8443653092073484838=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F22BA266C24
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 18:16:19 +0200 (CEST)
In-Reply-To: <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8443653092073484838==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5p3infmhvo7wt7s"
Content-Disposition: inline


--e5p3infmhvo7wt7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 17, 2017 at 10:09:33PM +0800, Shawn Guo wrote:

> +Optional properties:
> + - zte,pa-gpios: The GPIO to enable external power amplifier

If there's an external power amplifier this is a separate chip to this
CODEC and should therefore be separately controlled and integrated as
part of the machine integration.

--e5p3infmhvo7wt7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllH+MUACgkQJNaLcl1U
h9A5hAf+N6RWq0kTs/g0uBwfbTI0ll2kcpR5KHLu8gNR42LGstBjzk3NxVOmL/OM
2hmim4oCqu2gQy4D8cyP0voXssq+R0Wcnn46lc+MYQwKnefNzc3YXHoPvOT+H3E6
/b93LVPiODKVRQJzdzUJJEgYVdKOeJkaQ7W+6eVU2I2eDqGd6Xta4jWSbw3Q+Zdw
dvyhZIfyC58+RaRjNkL31pVz/aycAvd+WoFTpxfUgSvzoYBEjHvQXgGdAVHAiTaN
AqjLa2wEl7lTF6SjQQfuW+OcxUXJstcE33CwEauvOEXvBKNXKs4WNBNiTH0dcLP0
YjF8KAqMYZFc3eY33F5zyYcH9dDWTA==
=LCHo
-----END PGP SIGNATURE-----

--e5p3infmhvo7wt7s--

--===============8443653092073484838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8443653092073484838==--
