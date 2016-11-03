From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
Date: Thu, 3 Nov 2016 18:36:02 +0100
Message-ID: <20161103173602.zchyciwj66zdibc7@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="722gtj5awfeftbfz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-7-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--722gtj5awfeftbfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
> +/* headphone controls */
> +static const char * const sun6i_codec_hp_src_enum_text[] =3D {
> +	"DAC", "Mixer",
> +};
> +
> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
> +			    SUN6I_CODEC_OM_DACA_CTRL,
> +			    SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
> +			    SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
> +			    sun6i_codec_hp_src_enum_text);
> +
> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] =3D {
> +	SOC_DAPM_ENUM("Headphone Source Playback Route",
> +		      sun6i_codec_hp_src_enum),
> +};

What is that route exactly? A muxer?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--722gtj5awfeftbfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYG3WCAAoJEBx+YmzsjxAgq4wQALRWFKhYj/BieOHHn5JFmJz2
gPC7TG7c2Kgol53V4NyW+v5TGUxcqY/PTTd+yRdMcAldVEMNuZiZqAta7uGCZSDz
THwbGPULp2ElFpDTuVi2tSDVixiMobOP7pNaT0OXUqeLDT/rRs3jq5sPbgZ729NB
qkkhWs4Om7HxOTaSCZTHqPjSqHvoOimxnYRI9B1zEdASvF/Dm70P4g18MsDxcFP+
xOxWomyKQtXfsG15F0nokvyavrTt3AN68Q5gpk2kum3hQ2SJ7KM6jzIOeAxc6HPq
vwsSeqx7r54MDRXDYUlMThqrubkNXYHv838P0JxJB8zuHAhZcxPMhjNtZaywsg1y
Z9dpzClMMd19eEy/0vpDoyZ/FkEmoS0jRyiUAzH1tJ/pZ8ESR6y+1XMrIsYHKYZ9
Wc0RZOvJNe89F+k+ygFnK/hM/WtPK4b5PvOx9Et2/sM//fyLYfF4wCx+Nil/3gy4
qPN3yW+/4lRlCWHdfRILy3HpeeUqybHPFWdSek67BtHf1GZW6i8pMKd6lN93Ou0T
Q3PLAUsUrRM3aR1CwSe/Poq8ubF7b3O0Ih0I5XpLiit/F1qanJq0zun6WAB1uPRB
EyLYcU6OTHaLvdl4Fgzovx2LG4vcSp3zRJ6AaF8cZyFdfVZpWVlT9PAuRjlIyJD0
p4uqDK/ZL5rSTYHRgkxs
=AduV
-----END PGP SIGNATURE-----

--722gtj5awfeftbfz--
