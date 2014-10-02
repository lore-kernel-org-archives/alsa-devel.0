From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 5/7] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Thu, 2 Oct 2014 19:12:28 +0100
Message-ID: <20141002181228.GA4273@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1298409224734860496=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 112352604EE
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 20:12:37 +0200 (CEST)
In-Reply-To: <1411125368-5836-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1298409224734860496==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjCTGciBHXp1jY+V"
Content-Disposition: inline


--xjCTGciBHXp1jY+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 04:46:06PM +0530, Subhransu S. Prusty wrote:

> +#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name)			\
> +	static const struct snd_kcontrol_new kctl_name[] = {			\
> +		SOC_DAPM_SINGLE("media0_in", SND_SOC_NOPM, SST_IP_MEDIA0, 1, 0),	\
> +		SOC_DAPM_SINGLE("media1_in", SND_SOC_NOPM, SST_IP_MEDIA1, 1, 0),	\
> +		SOC_DAPM_SINGLE("media2_in", SND_SOC_NOPM, SST_IP_MEDIA2, 1, 0),	\
> +		SOC_DAPM_SINGLE("media3_in", SND_SOC_NOPM, SST_IP_MEDIA3, 1, 0),	\
> +	}

These should be Switch controls?

> +	snd_soc_dapm_new_controls(dapm, sst_dapm_widgets,
> +			ARRAY_SIZE(sst_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, intercon,
> +			ARRAY_SIZE(intercon));
> +	snd_soc_dapm_new_widgets(dapm->card);

We should be able to do this from the component but we can't yet...

--xjCTGciBHXp1jY+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULZWLAAoJECTWi3JdVIfQvWIH/3D30epgedcE5l3i0iEYPRL4
r8LBIkAlDJTTJDQCTG9jcgEM9djw+zCmMdJKnJY6KXWeDZ3ZXacLgJM/55zv42ss
wRy1r0c5bLtpCWCjQ1m7fCVUTZ9U1FwqHSC4FAYIdGUo2H1n04c6tyHALXS/SCNa
weyo6xXlBpO3dW4w8OtFzQRpI5Im74kaFQp7k716mXBMTwbcZq1FWMbNYyxKCgFj
BZvkFuevBodJk167S3FiVGiJ52bknEau2xCF3wmKOID4Wjj+iHm0GBbFnJ3GxbMP
+SjKLZFBanmKfa8qrAGh4tjY1FxvKoSO2YciTG+5D1j5sO3l3omGv3bvC2PeK/8=
=jBPu
-----END PGP SIGNATURE-----

--xjCTGciBHXp1jY+V--

--===============1298409224734860496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1298409224734860496==--
