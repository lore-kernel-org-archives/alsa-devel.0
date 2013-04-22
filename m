From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Mon, 22 Apr 2013 15:06:00 +0100
Message-ID: <20130422140558.GA5019@opensource.wolfsonmicro.com>
References: <1366121437-19396-1-git-send-email-bardliao@realtek.com>
 <20130416143807.GJ26958@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB3D46@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5828521966477679082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26BBC261664
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 16:06:05 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB8718BB3D46@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5828521966477679082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 22, 2013 at 03:03:05PM +0800, Bard wrote:

> Please see my reply below.

As you've been told several times now please fix your mailer to quote
the text you're replying to.  You shouldn't need to point out that
you're replying inline, this is how we do things...

> > +static const SOC_ENUM_SINGLE_DECL(
> > +	rt5640_in2_mode_enum, RT5640_IN3_IN4,
> > +	RT5640_IN_SFT2, rt5640_input_mode);

> Platform data...

> Bard: Can I export a function that machine can configure it by this function?

Why on earth would you want to do that?

> > +static int rt5640_vol_rescale_put(struct snd_kcontrol *kcontrol,
> > +		struct snd_ctl_elem_value *ucontrol) {
> > +	struct soc_mixer_control *mc =
> > +		(struct soc_mixer_control *)kcontrol->private_value;
> > +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +	unsigned int val, val2;

> > +	val = VOL_RESCALE_MAX_VOL - ucontrol->value.integer.value[0];
> > +	val2 = VOL_RESCALE_MAX_VOL - ucontrol->value.integer.value[1];
> > +	return snd_soc_update_bits_locked(codec, mc->reg, RT5640_L_VOL_MASK |
> > +			RT5640_R_VOL_MASK, val << mc->shift | val2); }

> This looks like a variant on the _RANGE controls?

> Bard: Yes, we want to limit the max value of volume.
>      If it is not good, I will change it.

This shouldn't be open coded in the driver, the functions should be
generic.  Code wise it's fine.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdUOMAAoJELSic+t+oim9tkcP+wWgv+MoP51DqoLfEyMCaZPo
uEG8TFyq0xTl8cb5F0WSQw23wOtu+nTCOEge+CW2pddLDEnvZzdfcHXRqzZcgGnV
64WZYG65ydpQxLwY9HwptGMaxpQTPHO4iBm/+URBTURyABmqGzySy0/jwHYUci/3
U4q7DkyYOKoGibx+9Syfz2GgzeVedkPw4smXZ1u32mV84vdxFP2gldHNwDkfjAva
ZEPumQJ9OOz9hC/zQE3+Ce8h/0RoHe4hErEoc7q1jcOzdJd44e/dMDlGGIhPQRzB
8h2i38zEzCRn0lCb4qpMtiXKXezQxFiZng989ryivOj8FCJPLM5G78yzqBFLxGhA
A+sSmucorZ3T4ZJe7X/T87ZZ1zJBNq9Ii/pc/TMzlYHwPsS8r6a/Dt3Egq7d6JZR
DJTSdfIxq0Nr9cM5oCCluRyITTSEHy1HMmcGdvMNy5a64ZuBF9Dta4oD/Wt6upvv
ClVeFJKHvaapZZ55X7GhFODI5IcwNJXSdEDKDtQ6gstwll426LZ/531ZoAj0O/Dk
y49smOJaNpfVGbVsMAjYnbnML1DG+hMFbwgyK2ScpYKRcOgwJ9f4IgQ8JmZoIRIy
c8SIxbD8qr1kuYOjGy4dX1cFNfkOuvtXjQLAVmyjSi+wdJeoiaCWhwsew1wg7gR4
GB5jHlB4x+YVym8JnK+A
=InQc
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

--===============5828521966477679082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5828521966477679082==--
