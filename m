From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ASoC: sunxi: sun50i-codec-analog: Add earpiece
Date: Wed, 3 Jul 2019 16:34:29 +0800
Message-ID: <CAGb2v66gX83sR-aWgFKBX+BH7Mud_PaAMvw4eNctQZFMkBYo=g@mail.gmail.com>
References: <20190702191613.11084-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702191613.11084-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, ~martijnbraam/pmos-upstream@lists.sr.ht, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 3, 2019 at 3:17 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> This adds the necessary registers and audio routes to play audio using
> the Earpiece, that's supported on the A64.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> So, first of all: This is my first audio patch and I hope I didn't make
> too many mistakes :) , especially with the routes at the bottom of
> the patch.
>
> What I'm really unsure about, is how the enable & mute registers should
> be handled. Should I put both registers into a SOC_DOUBLE("Earpiece
> Playback Switch",...)?

What we normally have with sunxi is the "Enable" switches typically
control whether a given function is active or not. With the earpiece
output, it controls the amplifier for the output. This should be modeled
as a separate DAPM widget, without a control, and let the framework
deal with it.

The mute controls the signal, so you can just keep as a control.

>  sound/soc/sunxi/sun50i-codec-analog.c | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> index d105c90c3706..6c19fea992c5 100644
> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> @@ -49,6 +49,15 @@
>  #define SUN50I_ADDA_OR_MIX_CTRL_DACR           1
>  #define SUN50I_ADDA_OR_MIX_CTRL_DACL           0
>
> +#define SUN50I_ADDA_EARPIECE_CTRL0     0x03
> +#define SUN50I_ADDA_EARPIECE_CTRL0_EAR_RAMP_TIME       4
> +#define SUN50I_ADDA_EARPIECE_CTRL0_ESPSR               0
> +
> +#define SUN50I_ADDA_EARPIECE_CTRL1     0x04
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN    7
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE  6
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL     0
> +
>  #define SUN50I_ADDA_LINEOUT_CTRL0      0x05
>  #define SUN50I_ADDA_LINEOUT_CTRL0_LEN          7
>  #define SUN50I_ADDA_LINEOUT_CTRL0_REN          6
> @@ -172,6 +181,10 @@ static const DECLARE_TLV_DB_RANGE(sun50i_codec_lineout_vol_scale,
>         2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
>  );
>
> +static const DECLARE_TLV_DB_RANGE(sun50i_codec_earpiece_vol_scale,
> +       0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
> +       2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
> +);
>
>  /* volume / mute controls */
>  static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
> @@ -225,6 +238,19 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
>                    SUN50I_ADDA_LINEOUT_CTRL0_LEN,
>                    SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0),
>
> +       SOC_SINGLE_TLV("Earpiece Playback Volume",
> +                      SUN50I_ADDA_EARPIECE_CTRL1,
> +                      SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
> +                      sun50i_codec_earpiece_vol_scale),
> +
> +       SOC_SINGLE("Earpiece Playback Switch (enable)",
> +                  SUN50I_ADDA_EARPIECE_CTRL1,
> +                  SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 1, 0),

As mentioned above, this should be a DAPM widget instead.

> +
> +       SOC_SINGLE("Earpiece Playback Switch",
> +                  SUN50I_ADDA_EARPIECE_CTRL1,
> +                  SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
> +
>  };
>
>  static const char * const sun50i_codec_hp_src_enum_text[] = {
> @@ -257,6 +283,20 @@ static const struct snd_kcontrol_new sun50i_codec_lineout_src[] = {
>                       sun50i_codec_lineout_src_enum),
>  };
>
> +static const char * const sun50i_codec_earpiece_src_enum_text[] = {
> +       "DACR", "DACL", "Right Analog Mixer", "Left Analog Mixer",

I suggest dropping "Analog" to match what other controls, such as the
Headphone Source" control, uses.

ChenYu

> +};
> +
> +static SOC_ENUM_SINGLE_DECL(sun50i_codec_earpiece_src_enum,
> +                           SUN50I_ADDA_EARPIECE_CTRL0,
> +                           SUN50I_ADDA_EARPIECE_CTRL0_ESPSR,
> +                           sun50i_codec_earpiece_src_enum_text);
> +
> +static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
> +       SOC_DAPM_ENUM("Earpiece Source Playback Route",
> +                     sun50i_codec_earpiece_src_enum),
> +};
> +
>  static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>         /* DAC */
>         SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
> @@ -285,6 +325,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>                          SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
>         SND_SOC_DAPM_OUTPUT("LINEOUT"),
>
> +       SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
> +                        SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
> +       SND_SOC_DAPM_OUTPUT("EARPIECE"),
> +
>         /* Microphone inputs */
>         SND_SOC_DAPM_INPUT("MIC1"),
>
> @@ -388,6 +432,13 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>         { "Line Out Source Playback Route", "Mono Differential",
>                 "Right Mixer" },
>         { "LINEOUT", NULL, "Line Out Source Playback Route" },
> +
> +       /* Earpiece Routes */
> +       { "Earpiece Source Playback Route", "DACL", "Left DAC" },
> +       { "Earpiece Source Playback Route", "DACR", "Right DAC" },
> +       { "Earpiece Source Playback Route", "Left Analog Mixer", "Left Mixer" },
> +       { "Earpiece Source Playback Route", "Right Analog Mixer", "Right Mixer" },
> +       { "EARPIECE", NULL, "Earpiece Source Playback Route" },
>  };
>
>  static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
> --
> 2.22.0
>
