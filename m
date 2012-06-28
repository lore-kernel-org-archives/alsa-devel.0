From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 2/4] ASoC: STA529: Add support for
	STA529 Audio Codec
Date: Thu, 28 Jun 2012 13:21:31 +0100
Message-ID: <20120628122131.GH28922@opensource.wolfsonmicro.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<38096527b25ad66b190e5150457133d0b3e6fd1e.1340862505.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3387762340728055319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED3B5103F4A
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 14:21:32 +0200 (CEST)
In-Reply-To: <38096527b25ad66b190e5150457133d0b3e6fd1e.1340862505.git.rajeev-dlh.kumar@st.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============3387762340728055319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 12:31:38PM +0530, Rajeev Kumar wrote:

> +	val =3D snd_soc_read(codec, STA529_MISC);
> +	/* set FFX audio frequency range */
> +	val =3D (((val & 0x83) | (play_freq_val << 4)) | (record_freq_val << 2)=
);
> +	snd_soc_update_bits(codec, STA529_MISC, FREQ_RANGE_MSK, val);

This is really odd, you're using update_bits() like write() - half the
point of update_bits() is that you don't need to do the read to get the
initial value.  It also looks like the frequency range set should be
being done in your playback/capture cases so that instead of=20

> +	u8 val =3D snd_soc_read(dai->codec, STA529_FFXCFG0);
> +
> +	if (mute)
> +		val |=3D CODEC_MUTE_VAL;
> +
> +	snd_soc_update_bits(dai->codec, STA529_FFXCFG0, AUDIO_MUTE_MSK, val);

This will never disable mute since you're using update_bits() badly
again - once mute has been set then the read will have the bit set and
nothing ever clears it.  You shouldn't have the read at all.

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7ExEAAoJEBus8iNuMP3dImgQAItdv1PJVOX2K5xzW7K8u7lS
ZLAIfgpQ7XTFcSMRkUJ9xtn+v5t9WcQoXYONi2x1lZMgBDvBI/MBZzQiVUOocDnV
UJUAKSlWhlrxgsdAErKPGdRj7GoinXnLKnlm1KvP/mX0P8MqSk/qm8E+FPeChuk2
d4RvA84fg+cNZSsxpNIFBOUz6SYotoDrQyTMW24jpXgGPTvQ1XTIrJx6d5vxRP2x
g6ysZoBtKDw/46RpPsymONg9Snl5ESQRzhm6selQwKnK7VIzYfC90voY7rj7flCi
QE8Ko+BgK0026f+QRUmUER3FHKEy5EZ74dKyTU4BfsBYRZXTzcEaZcdy9O6n6DSY
ygsal6numnlzoYEKZU/Ung1ouTJDXSi4EXpjiLCdcRwmCi22tIf3ejaUecp46Szg
dg+tFdxDxxX+PIlGISYeYx/1HPLLKVC/L1F0qdcB5UqzypffydxxgK0C/LVOKEYg
fkGZVGNnP1BOhjOymczy5R6s/V2H45xydz84ceOxY8yYqEYd4gUZJdyaIqZebPp4
KI0EyuVJ6MmwSMLMsgI1p9MYzRz+QhKIgtEXx8Ok5Iz2rqyg/LD0jf3DB3QSakUe
lF90LNCY0B1Uzyqgk5+CDyvFfWdPC+dzFv/6FzVSzI0FKHrhProhDZoSGhx6//Sk
hOxGyPm+XTGEudaaG1SV
=Ts7H
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--

--===============3387762340728055319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3387762340728055319==--
