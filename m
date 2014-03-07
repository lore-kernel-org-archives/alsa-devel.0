From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 5/7] ASoC: sirf: Add hdmi card
Date: Fri, 7 Mar 2014 14:06:33 +0800
Message-ID: <20140307060633.GF13126@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-6-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0918009266010201096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2350F265949
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 07:22:10 +0100 (CET)
In-Reply-To: <1394008480-29135-6-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============0918009266010201096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4X8KWh4JEk7YXJIe"
Content-Disposition: inline


--4X8KWh4JEk7YXJIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2014 at 04:34:38PM +0800, RongJun Ying wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
>=20
> This connects platform DAI, hdmi audio  codec DAI  and
> SiRF I2S DAI together and works as a mach driver.

This looks like it should be able to use simple-card?

> +static int sirf_hdmi_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> +	struct snd_soc_codec *codec =3D rtd->codec;
> +	struct snd_soc_card *card =3D codec->card;
> +	unsigned int fmt;
> +	int ret;
> +
> +	fmt =3D card->dai_link[0].dai_fmt;
> +
> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);

The whole point with dai_fmt is that the framework will do this for you.

--4X8KWh4JEk7YXJIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGWHmAAoJELSic+t+oim9as4P/3x6Dxm7cPYiHSabPn7F0602
eT6xbyE6KJKsvk2W7al1r9gTOk8rED2QQb7OQ+CsZMoe5ac1K2VD4S1yQ/A2qvbf
lsr7hxBz/tGD0iacUJitWFD+nkw9S6GPmizeAJq3dyVUFfMPEIwcSav+szoFrf7h
3vR/FngoVKa+1ifk2rFmoMMJm48monmcuLcJl6wIRv6hr78uJQcyBsnKKUZQ8JMZ
Z322MpVVTVw30qRYtMIKV2ZQ+dLkNMy1fuZ/hV+tld0+80uCne6pPo9ARb05izUK
5nNQSsS/ZLmsQfO1QXK6oL5Undodv9oEY6NEJtPcyKsMlLeSlz8wJ7U/F6XnDuTA
T5eHYBjt2TrF0Bsg5cn//TA4ioslzTDXdM0IcVZQy4VvVUryRgHpfvDg4sHPdr7T
Tf1tKPocNWZ+EKkv/OSP1tokb5y5xQLHbvO8TMC8obdJQBQlyQh5hTUFSfvRoETt
6RdjhXgiB2+g2HezDV2xOn/8O6VPdZnWq5hA1kJdVrrzd8aRO9vxzHjCaHIG2p8j
xQQP1bYDQd3ua7sNuF8xaAg48GBqeWHR8Jedv9xYcz1Ze2q83yXnWcmy1I39hLHG
rtmcxT1GPAixtDlLjmqyYcI/Qn9PW9BcaeLlfwis+bhVo2u7DYZTk66kWdcQCqao
B6GJCN3ZEoRZoKoH49Gf
=9Na8
-----END PGP SIGNATURE-----

--4X8KWh4JEk7YXJIe--

--===============0918009266010201096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0918009266010201096==--
