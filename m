From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/10] ASoC: Change the PCM runtime
	array to a list
Date: Fri, 14 Aug 2015 21:02:41 +0100
Message-ID: <20150814200241.GP10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <0b1c3916360faff8a36cc860f5b6af802bd6778b.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0524788931817349640=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EF50266469
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:49 +0200 (CEST)
In-Reply-To: <0b1c3916360faff8a36cc860f5b6af802bd6778b.1439217448.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0524788931817349640==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3h+hNn3PVp185ISI"
Content-Disposition: inline


--3h+hNn3PVp185ISI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 10:45:28PM +0800, mengdong.lin@intel.com wrote:

> +	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
> +	codec_dai = rtd->codec_dai;
> +

For ease of review please split the addition of this new interface for
getting the runtime from the change to the implementation - the same
function can be written in terms of a list.  As ever please make one
change per commit :(

> +static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
> +	struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
> +{
> +	struct snd_soc_pcm_runtime *rtd;
> +
> +	rtd = devm_kzalloc(card->dev,
> +			sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
> +	if (!rtd)
> +		return NULL;

Why are we allocating something with devm_kzalloc()...

> +static void soc_free_pcm_runtime(struct snd_soc_card *card,
> +	struct snd_soc_pcm_runtime *rtd)
> +{
> +	if (rtd->codec_dai)
> +		devm_kfree(card->dev, rtd->codec_dais);
> +	devm_kfree(card->dev, rtd);
> +}

...things that we later explicitly free in (hopefully?) all cases.

> +static void soc_remove_pcm_runtimes(struct snd_soc_card *card)
> +{
> +	struct snd_soc_pcm_runtime *rtd, *_rtd;
> +
> +	list_for_each_entry_safe(rtd, _rtd, &card->rtd_list, list) {
> +		list_del(&rtd->list);
> +		soc_free_pcm_runtime(card, rtd);
> +	}
> +
> +	card->num_rtd = 0;
> +}

Why doesn't the free function do the list removal?

--3h+hNn3PVp185ISI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzkleAAoJECTWi3JdVIfQBjkH/0M8cG7PINYPg8FUVZ8YAu6C
lapJ8BQQP2xQR1K/4rhGRXLgk4i5MdgCLewXVEuO2trfD703S0aqjjgOy+Jif4fF
bEpsBx1+oojBXbymA89V/xBbaeuOs3eiJ6YA+nf1tiNA3cWJ8P1zuWPQvGZ6Cnc2
drIbx7/pRF3LswZX73Cpf7CKwvjDwNan6ysxRmBDJKL8qA5UICbLjifxYnuu92iX
jyJBk0Pcb1X3dUG8bO5h6uH1K3fv7Wmoy3OUviwWBYTV5O5XHALLYelIwYH0uln1
FoJ6+gvYOQdfqxKGEMYDxUKLDXIgYEj9unzLJcDb/SG+fkVqTOYocFPayE2hIQY=
=oThH
-----END PGP SIGNATURE-----

--3h+hNn3PVp185ISI--

--===============0524788931817349640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0524788931817349640==--
