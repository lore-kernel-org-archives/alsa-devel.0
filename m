From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Sound record on Devkit8000 with DT boot issue
Date: Mon, 11 Feb 2013 14:17:41 +0100
Message-ID: <5118EF75.30107@ti.com>
References: <CABYxbz5ECxoWZtkfL3UbZ=R4LVoNeMVxjYbPdZoarstCod-gQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 956F9261718
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 14:17:46 +0100 (CET)
In-Reply-To: <CABYxbz5ECxoWZtkfL3UbZ=R4LVoNeMVxjYbPdZoarstCod-gQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, tiwai@suse.de, thomas@tomweber.eu
List-Id: alsa-devel@alsa-project.org

On 02/10/2013 04:21 PM, Anil Kumar wrote:
> Hi All,
> =

> I am working on Devkit8000 and adding DT support for that. I am trying
> to add sound DT node support for this boards.
> I have nearly done with this but facing issue on record. I do not have
> much knowledge of twl4030 audio codec but with
> small Hack[1] (as MainMic connected to the input jack)  i am able to
> record sound on Devkit8000.
> I do not know that MICBIAS1_EN can be enable by amixer commands.
> Could you please help me to get out of this ?

You need to pass the routing information via DT for Devkit8000. This is not
done for the BeagleBoard since it works without it (no need for MICBIAS for
example)

> =

> =

> 1) Hack [1]
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 63b280b..6780681 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -1473,7 +1473,7 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D {
>         SND_SOC_DAPM_SUPPLY("micbias2 select", TWL4030_REG_MICBIAS_CTL, 6=
, 0,
>                             NULL, 0),
> =

> -       SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 0),
> +       SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 1),

Yes, this is HACK and it is wrong at the same time.

>         SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
>         SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL,=
 2, 0),
> =

> =

> 2) Sound DT node patch for Devkit8000
> =

> diff --git a/arch/arm/boot/dts/omap3-
> devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index dc59272..5f3eec0 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -44,11 +44,22 @@
>                  };
> =

>         };
> +
> +       sound {
> +               compatible =3D "ti,omap-twl4030";
> +               ti,model =3D "devkit8000";
> +
> +               ti,mcbsp =3D <&mcbsp2>;
> +               ti,codec =3D <&twl_audio>;

Here you should have something like:
ti,audio-routing =3D
	"Ext Spk", "PREDRIVEL",
	"Ext Spk", "PREDRIVER",
	"MAINMIC", "Main Mic",
	"Main Mic", "Mic Bias 1";

So you connect the MicBias1 to Main Mic. When you start playback MicBias1 w=
ill
be turned on for you.

> +       };
>  };
> =

>  &omap3_pmx_core {
>         pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c1_pins>;
> +       pinctrl-0 =3D <
> +                       &i2c1_pins
> +                       &mcbsp2_pins
> +               >;
> =

>         leds_pins: pinmux_led_pins {
>                 pinctrl-single,pins =3D <
> @@ -65,6 +76,21 @@
>                         0x18c 0x118     /* I2C1_SDA */
>                  >;
>         };
> +
> +       mcbsp2_pins: pinmux_mcbsp2_pins {
> +                pinctrl-single,pins =3D <
> +                       /*
> +                        * MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT,
> +                        * MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT
> +                        */
> +                       0x10c 0x01000100
> +                       /*
> +                        * MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT,
> +                        * MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT
> +                        */
> +                       0x110 0x00000100
> +               >;
> +       };
>  };
> =

>  &i2c1 {
> @@ -74,6 +100,14 @@
>                 reg =3D <0x48>;
>                 interrupts =3D <7>;       /* SYS_NIRQ cascaded to intc */
>                 interrupt-parent =3D <&intc>;
> +
> +               twl_audio: audio {
> +                       compatible =3D "ti,twl4030-audio";
> +                       codec {
> +                               ti,ramp_delay_value =3D <3>;
> +                               ti,offset_cncl_path =3D <0x31>;
> +                       };
> +               };
>         };
>  };
> =

> 3) Playback amixer commands
>    amixer set 'PredriveR Mixer AudioR2' on
>    amixer set 'PredriveL Mixer AudioL2' on
>    amixer set PreDriv 100 unmute
>    amixer set 'DAC2 Digital Fine' 100
> =

> Thanks,
> Anil
> =



-- =

P=E9ter
