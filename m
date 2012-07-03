From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 2/2] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Tue, 3 Jul 2012 19:58:22 +0100
Message-ID: <20120703185821.GZ29030@opensource.wolfsonmicro.com>
References: <cover.1341312609.git.rajeev-dlh.kumar@st.com>
	<12728a82d749be9ee0a9de9d4d4dcb8d83a94bb5.1341312609.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4491700582406182469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 414271042A0
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 20:58:23 +0200 (CEST)
In-Reply-To: <12728a82d749be9ee0a9de9d4d4dcb8d83a94bb5.1341312609.git.rajeev-dlh.kumar@st.com>
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


--===============4491700582406182469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nynJ8Zgemp8dhn89"
Content-Disposition: inline


--nynJ8Zgemp8dhn89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 05:24:59PM +0530, Rajeev Kumar wrote:

> +static int spdif_out_mute;

This should be part of your driver data, not static data.

> +int spdif_soc_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_card *card = dai->card;
> +	struct snd_soc_pcm_runtime *rtd = card->rtd;
> +	struct snd_soc_codec *codec = rtd->codec;
> +
> +	return snd_soc_add_codec_controls(codec, spdif_out_controls,
> +				ARRAY_SIZE(spdif_out_controls));

snd_soc_add_dai_controls().

--nynJ8Zgemp8dhn89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP80DHAAoJEBus8iNuMP3dakEQAJWtBk46OzNqlQn+9ZMxPfgu
PjgOPXyjoIgcVnPXuQmI6yvyGA/6rGIn4D3nIkCqpqhGzx0B91VF8vH07IHrKVxh
g+BrNqcwShcFvZvDIkMny5NbJcgNJBOxqCHm+Y0Fjr5xSdot62FFHX4hGhjoFd9l
MI8Pu8405JvQjZvAwy6MFyAYVcHRqhG+1RpkXRbpNlgCtnbFJVmujQHKR8aEXFXs
92CTvynPacCvEevalJedl95FlTGEJQwC5rUj424jwrDVjGb9YUDbIaCaFpBvBMJt
E6S6NTSseHGvhyy50RHGx7V6juXA6/CmkVOwHApzCqmE/yBu51MBxEHr/UrAx38G
y4Zsq2iR0SpGzdd6bNj/hDxkbnaoJt1UEL9RgZn7+hOcivdpw8F5H/Ekcl3I0KyH
gMIuiavgaibrfR89y8RjLPiR1SkYGjVMv+GOBrh/7vTs+tWKmuLAzruDGRCOewft
oTfcCR49UBMpfGEyy2wPB7KEEIVpxJ5yFBBNnrTVL7IGtVxMTlip8F2Dq7QswZ9R
z6WYuZRN9EpMmtXVvR/HHCRLpDpPkSZLR0HmOuaR1XbFl4492pfkjKugav8MZK1d
BXI2X142vlpTqp1MnnF4qWI22ikdwupVKVvrBoLjZmv05VFuJwlnQhDBJ01a98fW
lKSrxpOdgwDrXqOiJdRH
=Sxy6
-----END PGP SIGNATURE-----

--nynJ8Zgemp8dhn89--

--===============4491700582406182469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4491700582406182469==--
