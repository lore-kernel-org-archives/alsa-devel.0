From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Thu, 28 Jun 2012 13:27:28 +0100
Message-ID: <20120628122727.GI28922@opensource.wolfsonmicro.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6669895973039105078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BA6C10402B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 14:27:29 +0200 (CEST)
In-Reply-To: <ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============6669895973039105078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 12:31:39PM +0530, Rajeev Kumar wrote:

> +	void *io_base;

Should be __iomem.  Looking at the code I suspect this might benefit
=66rom using regmap like Tegra, you'd save having to open code your mute
control if nothing else.

> +static const struct snd_kcontrol_new spdif_out_controls[] =3D {
> +	SOC_SINGLE_BOOL_EXT("SPDIF Play Mute", (unsigned long)&spdif_out_mute,
> +			spdif_mute_get, spdif_mute_put),

Should be "IEC958 Playback Switch".

> +int spdif_soc_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_card *card =3D dai->card;
> +	struct snd_soc_pcm_runtime *rtd =3D card->rtd;
> +	struct snd_soc_codec *codec =3D rtd->codec;
> +
> +	return snd_soc_add_codec_controls(codec, spdif_out_controls,
> +				ARRAY_SIZE(spdif_out_controls));

We should add a framework thing for this...

> +	.ops =3D (struct snd_soc_dai_ops *)&spdif_out_dai_ops,

Why do you need this cast?

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7E2nAAoJEBus8iNuMP3dnIAP/2riV1Whjj6QQUHWYyup0+/M
DWIXiqV39+OKiLDzOFLcLtHcc1EzfH17Gy0+EP+KgcylD8maWmF0X/FvlGYHMTw4
nJ6UpIKpEnu0vmdaS/LEGzRIcOW6924+xNTuzQi0fa6VgDglv0TqR3BKyH7Ua9jr
aLbBJmEfZPZfLtqOHTpAuus5nrwqGX9Jr+r7/4iqKVOPITYa4sAji3g9SyXsJDET
oQ62CUNzIXPXBQ77XkAZ93VFSmb8C2E1op/Gmk5fBM/LIJO32J+ybJANPAlM3LeT
xqVhR8apwqqbXPu6dJNi8LxyRmqDeVdCYlKHEoeuOvBwlxqS1nrt5cJF7LuQ/Tyj
dP3q4iEngWeCIc6oejXppEogyHLFMRLfUQGK7+eKqhDDAJRqonaIPVYdGJcWymLo
MP+Ic3H0jLUCM1+78Ut/ZOUq1yTsgJYRTtM0kOgQWBgvHDI6zy4zSUPecJbzdWiM
E3M7bn4BkP4Wzgv4EsCuYQ6N7b5spMh+ROWL3HG08lqQFk0JnurOk2ntnmYO0F5m
bTxytVG6IGZz1k6DCdAOCp51oP1UYdCdV3GRZ+7QOdcajAiJ4x76OXrTbm8yoGcr
QnWr7ohwjUQ1GNFGWtLN3EBitZ1C8P7Vx4tZh53/qgajFovYmvlNT9iY0lOXJmre
GIm2jWNRjIQujkPNBCD8
=yfF4
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--

--===============6669895973039105078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6669895973039105078==--
