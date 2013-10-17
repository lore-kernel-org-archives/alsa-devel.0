From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
Date: Thu, 17 Oct 2013 12:17:21 +0200
Message-ID: <20131017121721.43e1b34b@ipc1.ka-ro>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
	<1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi,

Xiubo Li <Li.Xiubo@freescale.com> wrote:
> When the CONFIG_REGULATOR is disabled there will be some warnings
> printed out.
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/codecs/sgtl5000.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.=
c
> index 1f4093f..4e2e4c9 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_so=
c_codec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kern=
el\n");
>  	return -EINVAL;
> +#endif
>
This looks wrong to me, as this will disable the error for unsolicited
platforms in a multi arch kernel!

>  static int ldo_regulator_remove(struct snd_soc_codec *codec)
>  {
>  	return 0;
>  }
> +
>  #endif
> =20
Why do you add an extra empty line here?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
