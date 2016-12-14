From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add Class G function options
Date: Wed, 14 Dec 2016 14:55:47 +0000
Message-ID: <20161214145547.scy4ugzhirnxjm4d@sirena.org.uk>
References: <1481609526-21933-1-git-send-email-benzh@chromium.org>
 <5851056F.1080303@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8938037345072875321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A193266FCE
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 15:55:59 +0100 (CET)
In-Reply-To: <5851056F.1080303@nuvoton.com>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AC30 YHChuang <YHCHuang@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, AC30 CTLin0 <CTLIN0@nuvoton.com>, Dylan Reid <dgreid@chromium.org>, "yong.zhi@intel.com" <yong.zhi@intel.com>, MS40 MHKuo <MHKuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--===============8938037345072875321==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qr6g54b277jdk3zr"
Content-Disposition: inline


--qr6g54b277jdk3zr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 04:40:15PM +0800, John Hsu wrote:
> On 12/13/2016 2:12 PM, Ben Zhang wrote:

> > +static SOC_ENUM_SINGLE_DECL(
> > +	nau8825_class_g_enum, SND_SOC_NOPM, 0, nau8825_class_g_src);
> > +

> The register SND_SOC_NOPM can't use at the enum put and get function
> in the older kernel. Ex. kernel 3.14. The driver has to modify the
> DAPM in the platform with older kernel.

Older kernels are not relevant upstream.  If you need to backport that
should be handled separately.

--qr6g54b277jdk3zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRXXIACgkQJNaLcl1U
h9BVOgf/bwyjb1OYarcGgMgo6cD4IpF+AD2Q0J3xLrDqwdOYPdMLbRyvoINhQDGy
DePvAcOlk3Wx07KtlSDL1eji0bi0BqfsxH/f+CVdR+86IkbOHe3yHR0L4In53Jpk
neSlf1uat1ocXJiv+z7GMJcnf9XtUvQOKQZM6WCnqRwiIjZX/CccfgiJmtOe35cL
X951aWNOM32vPqfIYVo6lMzHMJvYuG2hKl+S33eftI9kkE2j1FC9ZOiukTKcAcfi
fJVK0o3ro0W7xWpDKLKn0/xwzt4/CW1hjndnNNazoXtvMA5xcHGdJLbGYgpHyViJ
S7ouesB5j9nZVqxVxX1Wi8O6tndcJA==
=hig2
-----END PGP SIGNATURE-----

--qr6g54b277jdk3zr--

--===============8938037345072875321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8938037345072875321==--
