From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Add Broadwell Machine
	support
Date: Wed, 16 Jul 2014 22:32:42 +0100
Message-ID: <20140716213242.GC17528@sirena.org.uk>
References: <1405305340-8119-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7035231903041473467=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE8B62654AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:32:52 +0200 (CEST)
In-Reply-To: <1405305340-8119-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7035231903041473467==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D+UG5SQJKkIYNVx0"
Content-Disposition: inline


--D+UG5SQJKkIYNVx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2014 at 10:35:40AM +0800, Jie Yang wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>=20
> Add support for Broadwell based machines with SST DSP audio.

Applied, one tiny thing though:

> +static int broadwell_rt286_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> +	int ret;
> +
> +	ret =3D snd_soc_dai_set_sysclk(codec_dai, RT286_SCLK_S_PLL, 24000000,
> +		SND_SOC_CLOCK_IN);
> +
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
> +		return ret;
> +	}

Since this is left the same all the time it'd be better to set it in
rtd_init() or a late_probe() callback rather than resetting it each
time.

--D+UG5SQJKkIYNVx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxu93AAoJELSic+t+oim941UQAJvgh391Zh6qJWwsWdI0XWvY
RXA8xB9WuQVQw0a/UzWM8hFCTYMPSiKH0DKl0JFjvfvOn1hYQmIyKkcZax19Msgc
5TLNPWHjCxlfwHmfnZxiaLx0zDmqA8ZSoDu6cnlp4O/orCWtiaGlUP4J/SEfLtq4
noHe3k/xAP4JdrQ+r7viSZf99Bi5r1oSIX5KGs4KgrbRyvQvoR0tFJd59yjW+F1Q
nQDu8gRprBspWj+Mg1oZhds0e9jwq2KULCeD1wNLMYjFGUWM/Vs4GV9+aSo+QE2t
vT8iK+tOPzdJQxo4+DdkAxcDW3heM7bF7fPthjJKJir3cHvspX2DJLcF9csFALXk
F3Q8vUsD4amZJj+alWvngS/AnpfnUwT3d8lbScPYAYmlVZbL1qFmyi9SEpltncqJ
TGANdVcsVYUZjFHIj4o2clqwTan0dyNpfwTJeub4oHToiviLppZbsQMs4GGuqLhH
/Q01GGBve31Wuacky0L91ZZX7izV7XQPv3Av6JnpiPLyMb/rR0WpuxzrnrAq2dbW
FoqsJ9VDQa4Jed3JTcG/S+GOsXj2GB/Fk7+nwprpeBMyACgk9yDevD1qlG0g8mJY
FdsjXhZZRGrLKhpxDIR7zJRwLylIi0jbYhaI+DBW8vbYCbMscfzBmHnos6aBtrzL
1LzCqFpT2929N2GjiOlB
=4YR2
-----END PGP SIGNATURE-----

--D+UG5SQJKkIYNVx0--

--===============7035231903041473467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7035231903041473467==--
