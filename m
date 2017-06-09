From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v11 02/12] sun4i-codec: Add Differential
 Line Capture Switch and its routes
Date: Fri, 9 Jun 2017 15:29:54 +0800
Message-ID: <CAGb2v67hDBmUYzTyHppWsymVbgaBJO+prjr9X7UgTpdYV-HSuQ@mail.gmail.com>
References: <20170609062216.26807-1-dannym@scratchpost.org>
 <20170609062216.26807-3-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 52EE1266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:30:21 +0200 (CEST)
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 59F9F226B0
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:30:17 +0800 (CST)
Received: by mail-it0-f49.google.com with SMTP id m47so28656624iti.0
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:30:17 -0700 (PDT)
In-Reply-To: <20170609062216.26807-3-dannym@scratchpost.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 9, 2017 at 2:22 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 2f65aa72..a2435c6e 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -96,6 +96,7 @@
>  #define SUN4I_CODEC_ADC_ACTL_VMICEN                    (27)
>  #define SUN4I_CODEC_ADC_ACTL_VADCG                     (20)
>  #define SUN4I_CODEC_ADC_ACTL_ADCIS                     (17)
> +#define SUN4I_CODEC_ADC_ACTL_LNRDF                     (16)
>  #define SUN4I_CODEC_ADC_ACTL_PA_EN                     (4)
>  #define SUN4I_CODEC_ADC_ACTL_DDE                       (3)
>  #define SUN4I_CODEC_ADC_DEBUG                  (0x2c)
> @@ -644,6 +645,20 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>
> +static const char * const sun4i_codec_difflinein_capture_source[] = {
> +       "Stereo",
> +       "Differential",
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_capture_source,
> +                           SUN4I_CODEC_ADC_ACTL,
> +                           SUN4I_CODEC_ADC_ACTL_LNRDF,
> +                           sun4i_codec_difflinein_capture_source);
> +
> +static const struct snd_kcontrol_new sun4i_codec_difflinein_capture_source_controls =
> +       SOC_DAPM_ENUM("Differential Line Capture Switch",

A mux control or widget should not be named "XXX Switch". Please use
"XXX Route" or "XXX Source Route". Second, this control is not limited
to capture. Please drop the "Capture" suffix. Just call it "Line Source"
or "Line In Source".

> +       sun4i_codec_enum_difflinein_capture_source);
> +
>  static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>         SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>                        SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
> @@ -720,6 +735,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>         SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
>                             &sun4i_codec_pa_mute),
>
> +       /* MUX */
> +       SND_SOC_DAPM_MUX("Differential Line Capture Switch", SND_SOC_NOPM,

Same here.

> +                        0,
> +                        0,
> +                        &sun4i_codec_difflinein_capture_source_controls),

There is not much benefit in putting every value on a separate line,
except increasing line count and taking up screen real estate.

ChenYu

> +
>         /* Inputs */
>         SND_SOC_DAPM_INPUT("Mic1"),
>         SND_SOC_DAPM_INPUT("Mic2"),
> @@ -767,6 +788,11 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>         { "Right ADC", NULL, "MIC1 Pre-Amplifier" },
>         { "MIC1 Pre-Amplifier", NULL, "Mic1"},
>         { "Mic1", NULL, "VMIC" },
> +
> +       /* LNRDF Routes */
> +       { "Differential Line Capture Switch", "Differential", "Line Left" },
> +       { "Differential Line Capture Switch", "Differential", "Line Right" },
> +
>  };
>
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
