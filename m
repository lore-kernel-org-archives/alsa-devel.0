From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/4] ASoC: Enable dynamic DAIlink insertion &
	removal
Date: Mon, 15 Feb 2016 17:02:19 +0000
Message-ID: <20160215170219.GO18988@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-4-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8317095294568719478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D9F2606A5
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 18:02:34 +0100 (CET)
In-Reply-To: <1455538772-24926-4-git-send-email-vaibhav.agarwal@linaro.org>
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


--===============8317095294568719478==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 05:49:31PM +0530, Vaibhav Agarwal wrote:

> With the evolvement of modularized platforms, codecs can be
> dynamically added to/removed from a platform.
> Thus, there is a need to add FE/BE DAIs to an existing sound card
> in response to codec inserted/removed.

Like I say please format your changelogs normally.  It makes things much
easier to read.  I'm still not seeing a user or how this will work on
the client side here.

> Another kconfig option SND_SOC_DYNAMIC_DAILINK (default set to y)
> is added to avoid compilation issues for client (machine, codec)
> drivers with other kernel versions.

No, don't do this.  We don't care about random other kernel versions, if
we did the whole kernel would be full of ifdefs.  We have config options
for things like adding substantial size to the kernel.

> +int snd_soc_dapm_link_dai_widgets_component(struct snd_soc_card *card,
> +					    struct snd_soc_dapm_context *dapm);
> +void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card,
> +					   struct snd_soc_pcm_runtime *rtd);

Why void?

> +void dpcm_fe_disconnect(struct snd_soc_pcm_runtime *be, int stream);
>  void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream);

This seems like it should be a separate patch, it's not strongly tied to
the rest of the code.

> index 3dda0c4..44d8568 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -796,6 +796,8 @@ struct snd_soc_component {
> =20
>  	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
>  	unsigned int registered_as_component:1;
> +	/* registered dynamically in response to dynamic DAI links */
> +	unsigned int dynamic_registered:1;

dynamically.

> +int snd_soc_add_dailink(struct snd_soc_card *card,
> +			struct snd_soc_dai_link *dai_link);
> +void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_=
name);

Everywhere else we write dai_link.

> +config SND_SOC_DYNAMIC_DAILINK
> +	bool
> +        default y
> +

Like I say I don't see a need for this but note also that the
indentation seems broken - might be worth checking this isn't creeping
in elsewhere.

> +static void soc_remove_component_controls(struct snd_soc_component *comp=
onent)

This is only used once which means we're going to end up with two
different ways of removing controls, one of which is essentially never
used and hence likely to break.  It would be better to ensure that the
removal path is the same as much of the time as possible so that things
are more maintainable.  This is an issue through the patch, it feels
like it'd be clearer and easier to review if it first rearranged things
to split up things for reuse by dynamic addition and then separately
added new interfaces that do the dyanmic stuff.

> +
> +		long_name =3D control->name;
> +		prefix =3D component->name_prefix;
> +		name_len =3D sizeof(id.name);

name_len is completely pointless here...

> +		if (prefix)
> +			snprintf(id.name, name_len, "%s %s", prefix,
> +				 long_name);
> +		else
> +			strlcpy(id.name, long_name, sizeof(id.name));

=2E..it's not even used here.  Just don't bother with the intermediate
variables, they make things harder to follow.

> +	/*
> +	 * should be done, only in case
> +	 * component probed after card instantiation
> +	 * assumptions:
> +	 * relevant DAI links are already removed
> +	 * mutex acquired for soc-card
> +	 * semaphore acquired for sound card
> +	 */

Please fix the
formatting of
this comment
so it looks more
like normal kernel
code.

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwgSaAAoJECTWi3JdVIfQFjUH/ivozO+t9m3McfGgol/sGlva
PkdiTE36zsN8xHrcrPZy9WswwNlCAht+Hg3Osdhyy594CGFSkMamdLrDgbJwZtBI
xokd9C9sYgMEt7H3elQBdWVsB/fqqoIx1EO8Cp8d1p8BSiJQiUGVafo5kHBLVLxT
GqBBD3mntnMhrOTK4coKjvLAytuw3g1+gC2eRYxCuTSXSUFJIghWOrbm4Zb75COO
QSShCjm1Nm1xpVG621KYGhPSqJa853e8GaR4unVW7NhM2Rgp4oSjlI9rhah9C6NJ
FUbhGlsVuqcnKvsA+FD0Gi/cvzRpk8kv84z73iyc28Qke/OPBxV3t0YmFHW+hH0=
=li3S
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--

--===============8317095294568719478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8317095294568719478==--
