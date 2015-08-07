From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: max98090: Enforce correct device
 sequencing when configuring a new
Date: Fri, 7 Aug 2015 11:43:11 +0100
Message-ID: <20150807104311.GM20873@sirena.org.uk>
References: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
 <1438902946-49633-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3102982783825574062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AC6526042F
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 12:43:20 +0200 (CEST)
In-Reply-To: <1438902946-49633-2-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, Anish.Kumar@maximintegrated.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, ullysses.a.eoff@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3102982783825574062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EAobzQkPx7MtZmCP"
Content-Disposition: inline


--EAobzQkPx7MtZmCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 04:15:45PM -0700, yang.a.fang@intel.com wrote:

> +static int max98090_shdn_event(struct snd_soc_dapm_widget *w,
> +				 struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (event & SND_SOC_DAPM_POST_PMU)
> +		max98090->shdn_pending = TRUE;

TRUE?  Please use normal C99 booleans like we normally do in the kernel.

> +static void max98090_seq_notifier(struct snd_soc_dapm_context *dapm,
> +	enum snd_soc_dapm_type event, int subseq, bool power_up)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
> +	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (max98090->shdn_pending && power_up) {
> +		snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
> +				M98090_SHDNN_MASK, 0);
> +		msleep(40);
> +		snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
> +				M98090_SHDNN_MASK, M98090_SHDNN_MASK);
> +		max98090->shdn_pending = FALSE;
> +	}
> +}

Why did you change the API for this?  As far as I can tell power_up is
redundant here, we already know we're powering things up because we got
a _PMU event, the main effect here appears to be to just run this at the
next sequence point after we've powered up a widget with a shutdown
event.  The general concept with the seq_notifier is that we record
things we need to do in the per-widget events and then implement them in
the seq_notifier and I'm not seeing anything else going on here.

--EAobzQkPx7MtZmCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxIu6AAoJECTWi3JdVIfQu+UH/3VH1Pbfov235uQVrXnPH1KZ
iC7RakJ1pgTYZgzyx4X+KKRsFRZCIp+tOgJ+Q4hTx0U0nhBuFqlNf242TgHVOdX9
G2U7PVkWz2AQqoFRDxtZ3+wPNOZnQjbB3obKDpNPSYAFAxjGWAif7zopq6zGaII/
lfS/1WRgQAu7iy3KqUIvIzsQerkRBjDV3e1e+N3BYEd+BcfDkOyOAE6vaj1zkkLv
3IikkdF6HXUt8DQqJfLaCzsqmgWFMkIRKkFmf2MEdWDXUX5Uekw4Ix60MeQ6yyYs
l5tblHhx5BKk0/tS9CEhXBWdX1TFI5S1J5LpOrJYPCdiNwZzmvR4E7ijsBUU6zA=
=w4m6
-----END PGP SIGNATURE-----

--EAobzQkPx7MtZmCP--

--===============3102982783825574062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3102982783825574062==--
