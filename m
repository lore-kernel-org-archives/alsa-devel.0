From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: rt5651: Fix bias_level
 confusion / overcurrent detection deps
Date: Wed, 21 Feb 2018 11:40:45 +0000
Message-ID: <20180221114045.GB8334@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2439144843229990321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CE20267548
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:40:51 +0100 (CET)
In-Reply-To: <20180220221511.22861-3-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============2439144843229990321==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 11:15:03PM +0100, Hans de Goede wrote:
> Overcurrent detection (ovcd) requires the following to be on:
> 1) The LDO supply
> 2) The micbias1 supply
> 3) General analog voltages such as vref aka a bias_level of standby
>=20
> Before this commit deps 2. and 3. were not met (unless a stream recording
> from the mic was active).

What does the overcurrent detection detect overcurrent on?

> 3. Is not met because rt5651_set_bias_level() was only enabling this when
> reaching a bias level of prepared instead of doing this in the normal
> standby bias level, which the dapm core will select as soon as any pins /
> supplies are on. This commit fixes by making rt5651_set_bias_level() beha=
ve
> as a normal set_bias function for other codecs and already enabling these
> things at standby level.

=2E..

> 2. is fixed by simply force-enabling "micbias1" when doing ovcd, this
> commit also adds code to turn both the micbias1 and the LDO supplies of
> again when we're done, note they will only really get turned off if the
> ovcd was the only user.
>=20
> The snd_soc_codec_force_bias_level(BIAS_OFF) call done in rt5651_probe()
> will now turn off PWR_ANLG1, so the programming of PWR_ANLG1 before the
> snd_soc_codec_force_bias_level() now is a no-op and can be removed.

This is two or three changes combined into a single commit which makes
it harder to review :(

> @@ -1811,8 +1795,11 @@ static int rt5651_jack_detect(struct snd_soc_codec=
 *codec, int jack_insert)
>  	int jack_type;
> =20
>  	if (jack_insert) {
> -		snd_soc_dapm_force_enable_pin(dapm, "LDO");
> -		snd_soc_dapm_sync(dapm);
> +		snd_soc_dapm_mutex_lock(dapm);
> +		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
> +		snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
> +		snd_soc_dapm_sync_unlocked(dapm);
> +		snd_soc_dapm_mutex_unlock(dapm);
> =20
>  		snd_soc_update_bits(codec, RT5651_MICBIAS,
>  				    RT5651_MIC1_OVCD_MASK |

This is now only enabling the LDO and bias when the jack is inserted -
is that enough?  The changelog isn't very clear about what is going on
here.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNWrwACgkQJNaLcl1U
h9DzkQf/Sqy9owgdp3LPBbIm4IvIHFxQn0T654fVsi5B0tQ5ZzFhmKxuhOtKiF5B
YCefnEaGjvDYkpNQRX1/rQ8PMH4/c9IymPDW16ZX4QsPBTL31tCEBY1EKpW/kja/
q3v30tx3hJiSCvvpdZt/vRsITZJ52ZiKyRUE8aqTbmhxLPuDMVOZ90yrZkcGLgIV
leCto909NHTB+qjooYzcSyVrSoROMcbYhFC0ge54Z45vs7Eteq13NK4uXVgc/kdq
M2UH5VQfXoCUamw0vw/juE8+Cxvz66tomKmvE5kfbu84/f7GCpAsxaQ72MRjWwcs
JUSRpeVx87Imyk+bMj5hA4MTcaG5rQ==
=CYA9
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--===============2439144843229990321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2439144843229990321==--
