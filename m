From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Thu, 1 Mar 2018 19:30:46 +0000
Message-ID: <20180301193046.GJ12864@sirena.org.uk>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7009156257506423356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CA23267BC8
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:30:56 +0100 (CET)
In-Reply-To: <20180225104713.4745-7-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7009156257506423356==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 11:46:47AM +0100, Hans de Goede wrote:
> Configure the jack-detect source through a device-property which can be
> set by code outside of the codec driver. Rather then putting platform
> specific DMI quirks inside the generic codec driver.

> And move the jack-detect-source quirk for the KIANO SlimNote 14.2, which
> was present inside the codec driver to the machine driver, where we can
> bundle it together with the other quirks already present for this laptop.

Multiple things in a patch again :/  The property itself is fine but...

> @@ -360,6 +377,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtim=
e *runtime)
>  			dev_err(card->dev, "unable to set MCLK rate\n");
>  	}
> =20
> +	props[cnt++] =3D PROPERTY_ENTRY_U32("realtek,jack-detect-source",
> +				BYT_RT5651_JDSRC(byt_rt5651_quirk));
> +
> +	ret =3D device_add_properties(codec->dev, props);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D snd_soc_card_jack_new(runtime->card, "Headset",

I'm having a hard time geting comfortable with this; it's all a bit
fragile feeling to me - someone deciding to centralise the property
parsing (eg, if they are using a platform where platform data makes
sense or want to cross-validate with some other property on probe) could
easily break things and there's not even a comment in the CODEC driver.
It'll work but it doesn't seem to match expectations for how firmware
data is provided which is what's bugging me here.  It at least needs a
"here be dragons" style comment in the code.

Ideally we'd have a general way to massage the ACPI data at init time
and could have board files that are instantiated from DMI to do that
(like are needed even more for SFI) but that's a long way off.

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYVOUACgkQJNaLcl1U
h9D3cwf+IVSPIk7+7MCgCLrxp9c6tpcZspg5flWnBoUnTlujFmkE/EyO6d/NJxuh
dM+SLj+4bNAE6JJXFjIs8s1eebheADMpmnMIjhzAF63yMKFQtcwbqwLy0+rKqPv/
EreEIZUk/iwdWQuPQEn2qmCk92DGwNS/CvjWxKp0QhrBKajzOZNX7Ip8LI+Oej/2
CnrGJ4A8MHKiwoSTu4XmfAh4fVfRUGihC3+USZ98ow4VyhRSkiKubradSCKZm6F2
aac6Und/hWVFEle9LRN4nn2qYypTJhPOP1PVmvgaiQahJo7a3saViAM6ivD/nulm
z/7qWYYbvCazS2ta9Vk/03NUHCbZQg==
=rnc5
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--

--===============7009156257506423356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7009156257506423356==--
