From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH RFT] ASoC: max98926: Fix blr_clk_ratio
	calculation
Date: Tue, 16 Feb 2016 23:39:34 -0800
Message-ID: <CABCoZhAHaUZpEpDNV1n=y5TBN_U3=r1ciLYasWndjd0_XwrtnA@mail.gmail.com>
References: <1455669967.6195.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
 [209.85.213.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E0A26583F
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 08:39:35 +0100 (CET)
Received: by mail-vk0-f42.google.com with SMTP id k196so7309608vka.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 23:39:35 -0800 (PST)
In-Reply-To: <1455669967.6195.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Looks good to me. Thanks.

Acked-by: anish kumar<yesanishhere@gmail.com>

On Tue, Feb 16, 2016 at 4:46 PM, Axel Lin <axel.lin@ingics.com> wrote:
> Current code calculates blr_clk_ratio before setting max98926->ch_size, fix
> it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Anish,
> I don't have this h/w, please review and test this patch.
>
> thanks,
> Axel
>
>  sound/soc/codecs/max98926.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
> index 66884ebd..5245e10 100644
> --- a/sound/soc/codecs/max98926.c
> +++ b/sound/soc/codecs/max98926.c
> @@ -383,8 +383,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
>         int rate = params_rate(params), i;
>         struct snd_soc_codec *codec = dai->codec;
>         struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
> -       /* BCLK/LRCLK ratio calculation */
> -       int blr_clk_ratio = params_channels(params) * max98926->ch_size;
> +       int blr_clk_ratio;
>
>         switch (params_format(params)) {
>         case SNDRV_PCM_FORMAT_S16_LE:
> @@ -414,6 +413,9 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
>                 return -EINVAL;
>         }
>
> +       /* BCLK/LRCLK ratio calculation */
> +       blr_clk_ratio = params_channels(params) * max98926->ch_size;
> +
>         switch (blr_clk_ratio) {
>         case 32:
>                 regmap_update_bits(max98926->regmap,
> --
> 2.1.4
>
>
>
