From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt298: Add jack suspend and resume
	functions.
Date: Mon, 13 Jun 2016 15:09:23 +0100
Message-ID: <20160613140923.GH2282@sirena.org.uk>
References: <1465820919-6105-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8835977369501987766=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E7E4265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 16:09:41 +0200 (CEST)
In-Reply-To: <1465820919-6105-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, lgirdwood@gmail.com, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8835977369501987766==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OWym5pP/pDvoNOpg"
Content-Disposition: inline


--OWym5pP/pDvoNOpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2016 at 08:28:39PM +0800, Bard Liao wrote:

> +void rt298_jack_suspend(struct snd_soc_codec *codec)
> +{
> +	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
> +	struct snd_soc_dapm_context *dapm;
> +
> +	dapm = snd_soc_codec_get_dapm(rt298->codec);
> +	snd_soc_dapm_disable_pin(dapm, "LDO1");
> +	snd_soc_dapm_sync(dapm);
> +}
> +EXPORT_SYMBOL_GPL(rt298_jack_suspend);
> +
> +void rt298_jack_resume(struct snd_soc_codec *codec)
> +{
> +	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
> +	bool hp = false;
> +	bool mic = false;
> +
> +	rt298_jack_detect(rt298, &hp, &mic);
> +}
> +EXPORT_SYMBOL_GPL(rt298_jack_resume);

This is usually done by having the _jack_detect() function take NULL as
the jack to disable the detection.  Keeping in line with the existing
pattern would be good, and would make it easier if we do start to get
this more standardized.

--OWym5pP/pDvoNOpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXXr6LAAoJECTWi3JdVIfQKwYH+wal36z3qJQkGBjvj09ht5Vl
6TLCSbx/DIjRPIguOsL9ZFZBfEfBt20kSDtCnNzRTPuROsYUXky8PCIO+fO1wR41
xS130v4IdHrqj5CEGNGxtB67sjX9auV4LtnXtOFKE5EUitl43dzMMTHI99IsfxNn
pb1Q84zls7HerzHDZkLCL6t8NPm6a4034vIhD/joptPS/W5+ftv38CdbKi6Nw2dq
mZYGft3vgujPvkiFflWS5L/2rT7DubHbmmg+DHuPFtIG9d/5lAlIUyzmKaMlzkm3
R62jQzzQ1EGJK39fnoMZ+fDyk3ecMMazNGK0gmnhpADxOvsaRdRUxyLC91r+HXc=
=hZQM
-----END PGP SIGNATURE-----

--OWym5pP/pDvoNOpg--

--===============8835977369501987766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8835977369501987766==--
