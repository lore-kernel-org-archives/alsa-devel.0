From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/4] ASoc: Use ref_count for soc DAI &
	component
Date: Mon, 15 Feb 2016 13:59:41 +0000
Message-ID: <20160215135941.GJ18988@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-2-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8702130883084761203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F2EE2612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 14:59:51 +0100 (CET)
In-Reply-To: <1455538772-24926-2-git-send-email-vaibhav.agarwal@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8702130883084761203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 05:49:29PM +0530, Vaibhav Agarwal wrote:
> This is preperation to allow dynamic DAI link insertion &
> removal.

Which there is no proposed user of here...

> Currently, DAI links are added/removed once during soc-card
> instatiate & removal. Thus, irrespective of usage count by multiple
> DAI links, DAIs and components are probed or removed only once
> while maintaining 'probed' flag.
> However, in case of dynamic DAI link insertion/removal we need to
> ensure DAI/components are not unnecessarily probed multiple & not
> removed mistakenly while in use by any other existing DAI link.
> Thus, ref_count is used to maintain their usage count.

Please use normal changelog formatting - either consistent line lengths
or blank lines between paragraphs depending on what you're trying to
accomplish here.

> -	if (!dai->probed && dai->driver->probe_order =3D=3D order) {
> -		if (dai->driver->probe) {
> -			ret =3D dai->driver->probe(dai);
> -			if (ret < 0) {
> -				dev_err(dai->dev,
> -					"ASoC: failed to probe DAI %s: %d\n",
> -					dai->name, ret);
> -				return ret;
> +	if (dai->driver->probe_order =3D=3D order) {
> +		if (!dai->probed) {
> +			if (dai->driver->probe) {
> +				ret =3D dai->driver->probe(dai);
> +				if (ret < 0) {
> +					dev_err(dai->dev,
> +						"ASoC: failed to probe DAI %s: %d\n",
> +						dai->name, ret);
> +					return ret;
> +				}
>  			}
> -		}
> =20
> -		dai->probed =3D 1;
> +			dai->probed =3D 1;
> +		}
> +		dai->ref_count++;
>  	}

I don't understand this at all - why the complete reindent and change of
condition, don't we just increase the refcount when we flag as probed
(and why do we still have the probed flag after this)?

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwdnLAAoJECTWi3JdVIfQHl4H/15fK2YRoFsT9aPK/RC1uhOm
auxhygRjyqeXOVHPrv9F4HhCRuysqmWS1SwUwNtZwgHwg/2xTir4uRcWsM9hzuDK
90rono8HbS49wQCGBFupfeD+qef/JaCfUet+8U3zOv2URZy/c0BkSjVCbuf3GnOZ
Il9kyZVZNYIVVq0KbhTGIpZ2QouM269xMkuhKc7CgUvFZEiY8uJniqGWEzG2LDXb
vBf5hAynZ7q3Hdr327bKtu8KJtUrlYlimonrhztZyYCp37lrjlAFyzuScVL9ycp2
uauRuKG38+SsUNLSXLN5W6kR/AZBfVmhU4SjNfRHeJS+Az/HTaPy4fuBTkc6cP4=
=y/Ta
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--

--===============8702130883084761203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8702130883084761203==--
