From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] ASoC: rt5677: Remove bogus device id from rt5677_of_match
Date: Tue, 7 Aug 2018 09:39:38 -0700
Message-ID: <CABXOdTcpoGLc+STUZY-tVBqqn5BrBH1vEb6B+bt6MspLHUXeGQ@mail.gmail.com>
References: <20180807162234.205212-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807162234.205212-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: bardliao@realtek.com, oder_chiou@realtek.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 7, 2018 at 9:22 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The initializer of rt5677_of_match contains a bogus device id
> (enum type) for the 'type' field (char []). Remove it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/codecs/rt5677.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 8a0181a2db08..7dab53b35cbf 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
>  };
>
>  static const struct of_device_id rt5677_of_match[] = {
> -       { .compatible = "realtek,rt5677", RT5677 },
> +       { .compatible = "realtek,rt5677", },

Is that indeed not used, or should it be the following ?
                        ...  , .data = RT5677 },

Thanks,
Guenter

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);
> --
> 2.18.0.597.ga71716f1ad-goog
>
