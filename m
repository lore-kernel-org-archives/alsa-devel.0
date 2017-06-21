From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22
	codec driver
Date: Wed, 21 Jun 2017 17:13:21 +0100
Message-ID: <20170621161321.mstpidbyq55q4mmj@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
 <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
 <20170620031953.GC4818@x250>
 <20170620124059.r55r363y3y3if6jg@sirena.org.uk>
 <20170621160340.GE3372@dragon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2059033749609203488=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6592669F3
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 18:13:33 +0200 (CEST)
In-Reply-To: <20170621160340.GE3372@dragon>
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


--===============2059033749609203488==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pbwij4n34u3taeyi"
Content-Disposition: inline


--pbwij4n34u3taeyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 12:03:41AM +0800, Shawn Guo wrote:
> On Tue, Jun 20, 2017 at 01:40:59PM +0100, Mark Brown wrote:

> > Sounds like a fairly standard use for a supply widget.

> Yes, it can be a supply widget.  But it's a bit that controls device
> overall power rather than any particular component power.  Since every
> single operation of the device will need this power bit to be on, I
> think it makes sense to configure the bit in .startup/.shutdown hooks,
> rather than creating a widget for it and attaches the widget to a bunch
> of components.

Do it with DAPM - this means any analogue paths will work and there's no
possibility of refcounting issues.  You will need to create a bunch of
links but that's pretty easy and it's all data rather than code.

--pbwij4n34u3taeyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKmyAACgkQJNaLcl1U
h9DJYQf/fgMVHgjfcyRKuFh1GfkzIDVLusnp2y/nafOCKaBefMa1xmVvYpRzAUnN
yfLwvFiVBiSOTt5yo3bbZQswuGxLwDAD3ePxHST7AHyYWOf6lUiRYH3qbb7fOjzn
J1elDZUusVH0fVwRpe8dmKAdHn0l1bqAd3AV0T66jiIUg19c79Jt2jrz8S9kFYwp
5FY7ASHi7XcrWhYNkGxOaVOrglfKCYd2j/89WNzOamIvPMwLg3VEYzdEGqKHphHg
DgY/NdiZFK0LH18au+6MwdYN1Esdej7VWPgiNL3RXHdb7CBZErf3P2pWqXq2Z750
3O25zdKJmF56z2+ngBGfkbdZZiJBzg==
=P694
-----END PGP SIGNATURE-----

--pbwij4n34u3taeyi--

--===============2059033749609203488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2059033749609203488==--
