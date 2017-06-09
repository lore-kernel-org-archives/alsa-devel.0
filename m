From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v11 07/12] sun4i-codec: Add extra controls
 to sun4i_codec_quirks, sun7i_codec_quirks.
Date: Fri, 9 Jun 2017 15:48:59 +0800
Message-ID: <CAGb2v654SNZcGVx9SXVvLfpz2kHchftyeL2sGOgnvj2T9G7KBA@mail.gmail.com>
References: <20170609062216.26807-1-dannym@scratchpost.org>
 <20170609062216.26807-8-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E8D82675F4
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:49:23 +0200 (CEST)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
 [209.85.214.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id C7ABF226B0
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:49:21 +0800 (CST)
Received: by mail-it0-f45.google.com with SMTP id m47so134179624iti.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:49:21 -0700 (PDT)
In-Reply-To: <20170609062216.26807-8-dannym@scratchpost.org>
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
>  sound/soc/sunxi/sun4i-codec.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index b1da14d1..d453af65 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1576,6 +1576,8 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
>         .reg_adc_fifoc  = REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
>         .reg_dac_txdata = SUN4I_CODEC_DAC_TXDATA,
>         .reg_adc_rxdata = SUN4I_CODEC_ADC_RXDATA,
> +       .controls = sun4i_codec_extra_controls,
> +       .num_controls = ARRAY_SIZE(sun4i_codec_extra_controls),

Where did these come from?

>  };
>
>  static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
> @@ -1595,6 +1597,8 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
>         .reg_adc_fifoc  = REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
>         .reg_dac_txdata = SUN4I_CODEC_DAC_TXDATA,
>         .reg_adc_rxdata = SUN4I_CODEC_ADC_RXDATA,
> +       .controls = sun7i_codec_extra_controls,
> +       .num_controls = ARRAY_SIZE(sun7i_codec_extra_controls),
>  };
>
>  static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
