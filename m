From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of rt5677_of_match.data
Date: Tue, 7 Aug 2018 10:29:25 -0700
Message-ID: <CABXOdTdTqzsvDfXyrCBY98iP+icj_g=Rig5Lb1Rq0MMQPBGZ2Q@mail.gmail.com>
References: <20180807171940.150507-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807171940.150507-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: bardliao@realtek.com, oder_chiou@realtek.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 7, 2018 at 10:19 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The driver expects to find the device id in rt5677_of_match.data, however
> it is currently assigned to rt5677_of_match.type. Fix this.
>
> The problem was found with the help of clang:
>   sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
>   zero treated as a null pointer constant of type 'const void *'
>   [-Wnon-literal-null-conversion]
>     { .compatible = "realtek,rt5677", RT5677 },
>                                       ^~~~~~
>
> Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> --
> Changes in v2:
> - assign device id to data instead of 'type'
> - updated subject and commit message
> - added: 'Fixes' tag
> ---
>  sound/soc/codecs/rt5677.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 8a0181a2db08..47feef30dadb 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
>  };
>
>  static const struct of_device_id rt5677_of_match[] = {
> -       { .compatible = "realtek,rt5677", RT5677 },
> +       { .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);
> --
> 2.18.0.597.ga71716f1ad-goog
>
