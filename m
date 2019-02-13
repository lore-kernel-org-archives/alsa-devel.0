From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH -next] ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static
Date: Wed, 13 Feb 2019 14:45:38 +0800
Message-ID: <CAFv8NwLSGmKEYeGgo_DQFJAWV8rJrgxR2Rv-f9gv3SkrT8eKMg@mail.gmail.com>
References: <20190213062956.146536-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213062956.146536-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 13, 2019 at 2:16 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fixes the following sparse warning:
>
> sound/soc/codecs/cros_ec_codec.c:209:27: warning:
>  symbol 'cros_ec_dai' was not declared. Should it be static?
>
> Fixes: b291f42a3718 ("ASoC: cros_ec_codec: Add codec driver for Cros EC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/codecs/cros_ec_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index b14100b6a939..99a3af8a15ff 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -206,7 +206,7 @@ static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
>         .set_fmt = cros_ec_i2s_set_dai_fmt,
>  };
>
> -struct snd_soc_dai_driver cros_ec_dai[] = {
> +static struct snd_soc_dai_driver cros_ec_dai[] = {
>         {
>                 .name = "cros_ec_codec I2S",
>                 .id = 0,
>
>
>
Hi Wei,
  Yes you are right. Thanks for the fix!
