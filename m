From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 01/11] ASoC: topology: Make manifest
 backward compatible from ABI v4
Date: Fri, 28 Oct 2016 19:47:21 +0100
Message-ID: <20161028184721.ttqte2jot5crlz2y@sirena.org.uk>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <39acbd6c55ca9ac0855001d5a67d7d96fddd0c7b.1476166990.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516826825007277303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 472A8265D93
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 20:47:42 +0200 (CEST)
In-Reply-To: <39acbd6c55ca9ac0855001d5a67d7d96fddd0c7b.1476166990.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0516826825007277303==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wjcwa235dngeqyk4"
Content-Disposition: inline


--wjcwa235dngeqyk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2016 at 02:36:42PM +0800, mengdong.lin@linux.intel.com wrote:

> +static int manifest_new_ver(struct soc_tplg *tplg,
> +			    struct snd_soc_tplg_manifest *src,
> +			    struct snd_soc_tplg_manifest **manifest)
> +{
> +	struct snd_soc_tplg_manifest *dest;
> +	struct snd_soc_tplg_manifest_v4 *src_v4;
> +
> +	*manifest = NULL;
> +
> +	if (src->size != sizeof(*src_v4)) {
> +		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_warn(tplg->dev, "ASoC: old version of manifest\n");

The way this function is written it's not going to scale to any future
ABI churn, it's not set up to handle multiple versions at all.

--wjcwa235dngeqyk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE504AAoJECTWi3JdVIfQv9AH/Az5AIC6coDSZwMR1eiicR7u
rGQDvrqW3o89ePIIMP42eBWUmvWApGGKiNGbQBIxOHXRew6Ay9dBtG3qbtOgmfyq
Ml4iSh3vwJ4akPYOuz7EMkL5ZYBwYKY5CdFlYTiuLwBHXAlmyhqU76sWqMGJQLP4
xGrekeSCpkquzgSss7Hv4Z42EOEkdpiH7mTs+Gw9GIkYMDnG6VOK0tIYEM37TUaH
ZFZYR5Z5P9Em8Z0gWraSjU3JzbaMxkoKUZRfz1X7BcpW7wpmaCXG7f+mg2xPfaYy
E5yT751htAi6bhQfTlWHl1AdqZvwffn039rtesU3QE+8bbzq4skQBDe914ythx4=
=Tnxh
-----END PGP SIGNATURE-----

--wjcwa235dngeqyk4--

--===============0516826825007277303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0516826825007277303==--
