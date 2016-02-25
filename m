From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [patch 1/2] ASoC: max9867: signedness bug in max9867_dai_hw_params()
Date: Thu, 25 Feb 2016 16:17:53 +0800
Message-ID: <CAFRkauCNUFVCm589530DDmOJ8qPx53w8_bPSctG_S+PvNggTOA@mail.gmail.com>
References: <20160225074810.GB7333@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160225074810.GB7333@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2016-02-25 15:48 GMT+08:00 Dan Carpenter <dan.carpenter@oracle.com>:
> "value" needs to be signed for the error handling to work.
>
> Fixes: 805d132dcbbd ('ASoC: Add max9867 codec driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
> index ab7a94d..4fb6fc7 100755
> --- a/sound/soc/codecs/max9867.c
> +++ b/sound/soc/codecs/max9867.c
> @@ -180,7 +180,8 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
> -       unsigned int ni_h, ni_l, value;
> +       unsigned int ni_h, ni_l;
> +       int value;

Already fixed by
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=topic/max9867&id=127a9cbb5860a7cf15f4d4703ab0454e4603e8ac
