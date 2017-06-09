From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v11 06/12] sun4i-codec: Add support for
 extra controls to struct sun4i_codec_quirks and use them.
Date: Fri, 9 Jun 2017 15:47:26 +0800
Message-ID: <CAGb2v66-iiyQN1v3J5buyeX9YA7ELxYxC_0s+hvaOF6mjRmGOQ@mail.gmail.com>
References: <20170609062216.26807-1-dannym@scratchpost.org>
 <20170609062216.26807-7-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 57EC8266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:47:50 +0200 (CEST)
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 5C31920387
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:47:48 +0800 (CST)
Received: by mail-io0-f169.google.com with SMTP id y77so29930215ioe.3
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:47:48 -0700 (PDT)
In-Reply-To: <20170609062216.26807-7-dannym@scratchpost.org>
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

Again, why?

> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index f56a59ad..b1da14d1 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -897,9 +897,22 @@ struct sun4i_codec_quirks {
>         unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config */
>         unsigned int reg_adc_rxdata;    /* RX FIFO offset for DMA config */
>         bool has_reset;
> +       const struct snd_kcontrol_new *controls;
> +       unsigned int num_controls;
>  };
>
> +static int sun4i_codec_codec_probe(struct snd_soc_codec *scodec)
> +{
> +       const struct sun4i_codec_quirks *quirks;
> +
> +       quirks = of_device_get_match_data(scodec->dev);
> +       return snd_soc_add_codec_controls(scodec,
> +                                         quirks->controls,
> +                                         quirks->num_controls);
> +}
> +
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
> +       .probe = sun4i_codec_codec_probe,
>         .component_driver = {
>                 .controls               = sun4i_codec_controls,
>                 .num_controls           = ARRAY_SIZE(sun4i_codec_controls),
