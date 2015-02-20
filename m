From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: audio mcbsp1 broken for beagleboard-xm -OMAP
Date: Fri, 20 Feb 2015 18:27:08 +0200
Message-ID: <54E7605C.5000709@ti.com>
References: <CAES_P+_LNczMuQsUW=ghJ-SQjLn_+AokDHfY4k+zmoFBb8cF0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6B2260591
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 17:27:12 +0100 (CET)
In-Reply-To: <CAES_P+_LNczMuQsUW=ghJ-SQjLn_+AokDHfY4k+zmoFBb8cF0w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>, "broonie@kernel.org" <broonie@kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 02/20/2015 08:45 AM, noman pouigt wrote:
> Hello,
> =

> I am trying to integrate max98090 codec with $subject board.  I am
> running the mcBSP in slave mode as i have not changed the hw_parms for
> omap-twl4030.c file. With below changes i see wait_for_avail is
> getting stuck i.e. mcbsp is not getting any interrupt and nothing is
> playing.
> =

> Kernel version:
> VERSION =3D 3
> PATCHLEVEL =3D 19
> SUBLEVEL =3D 0
> EXTRAVERSION =3D
> NAME =3D Diseased Newt
> =

> Setup information:
> Using beagle board -xm and connected max98090 codec to mcbsp1 pins.
> Connected only 4 pins.
> =

> Changed the omap-twl4030.c machine file as below to disable the twl4030:
> static struct snd_soc_dai_link omap_twl4030_dai_links[] =3D {
>        {
> +               .name =3D "max98090",
> +               .stream_name =3D "max98090",
>                .cpu_dai_name =3D "omap-mcbsp.1",
> +               .codec_dai_name =3D "HiFi",
>                .platform_name =3D "omap-mcbsp.1",
> +               .codec_name =3D "max98090.1-0010",
>                .ops =3D &omap_twl4030_ops,
>        },
> =

> DTSI file change:arch/arm/boot/dts/omap3-beagle-xm.dts
> =

> &i2c2 {
>        clock-frequency =3D <400000>;
> +
> +       max98090: max98090@10 {
> +               compatible =3D "maxim,max98090";
> +               reg =3D <0x10>;
> +       };
> };

You also need to change the dts file's sound node, enable mcbsp1, set the
pinctrl entries, etc if you boot with DT.

> =

> omap/omap-twl4030.c
> added in hw_params below function to set internal oscillator for 98090
> for generating PLL for master clock.
> snd_soc_dai_set_sysclk(codec_dai, 26000000, 0, SND_SOC_CLOCK_IN);
> =

> I am able to see that the cpu_dai is mapped with codec_dai and
> configuration is ok. kernel logs at https://ideone.com/oezNSj
> =

> I think i don't need to configure the mcbsp1 pins right as it uses defaul=
t.
> =

> Please guide me.I have tried IRC channel also but not getting the right f=
olks.
> =

> https://github.com/CircuitCo/BeagleBoard-xM-RevC/blob/master/BeagleBoard-=
xM_revC_SCH.pdf?raw=3Dtrue
> =

> Thanks,
> =



-- =

P=E9ter
