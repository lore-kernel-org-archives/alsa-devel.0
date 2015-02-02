From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel:Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5645
Date: Mon, 2 Feb 2015 19:05:21 +0000
Message-ID: <20150202190521.GZ21293@sirena.org.uk>
References: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1706723011821225798=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 778BD260575
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 20:05:29 +0100 (CET)
In-Reply-To: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, kevin.strasser@intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1706723011821225798==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NXoVGAkaRY1DAl/n"
Content-Disposition: inline


--NXoVGAkaRY1DAl/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 31, 2015 at 03:22:39PM -0800, yang.a.fang@intel.com wrote:

> +	/* Select clk_i2s1_asrc as ASRC clock source */
> +	snd_soc_write(codec, RT5645_ASRC_2, 0x1111);

We should have an interface for doing this from the CODEC driver rather
than just randomly writing directly to registers - that way we don't
have something else working behind the back of the CODEC driver and
potentially interfering with it.

--NXoVGAkaRY1DAl/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8pwAAoJECTWi3JdVIfQAvMH+waxXdT9RG1lqW2frHuZY0LC
8PEa40bILYMHupoRgMoMlvOt3OCQS0xH5ifD+CjUWiX0gRA4jmNDkw56sXHGM0Hs
fyhXa58v3/tb/F85MAKp5mUfA051rztI8DdIgbBp7foLva2/OVpAdo/F0mQFa8N/
qTE+VfziMUGrTwyZzLXF6TD5jG1YVg1WvmJ3nHNLnEKDga41l++IGYMFVWHipLFX
rjP1NQytw3pgJ8uUnwos3Hb/Ze2zhDueNYShVBJMomN7+cp+Dxo1QSqewmo8LvGW
KsJwCvikZgsvY84ZIE9G8JfJj7jdyQVCoCP64F85kznhUK0YwA4Z9kg0j5Lnt4M=
=K/F5
-----END PGP SIGNATURE-----

--NXoVGAkaRY1DAl/n--

--===============1706723011821225798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1706723011821225798==--
