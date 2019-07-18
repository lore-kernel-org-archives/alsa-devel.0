From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: odroid: Use common code in odroid_audio_probe()
Date: Thu, 18 Jul 2019 11:58:47 +0200
Message-ID: <CAJKOXPdRY+HaAKEj+jugJpE6kFYpkRacoCoKnMFjFL0t-EuMcg@mail.gmail.com>
References: <c4c10934-f06f-24a8-1162-b023e4ab4066@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4c10934-f06f-24a8-1162-b023e4ab4066@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Takashi Iwai <tiwai@suse.com>, Wen Yang <wen.yang99@zte.com.cn>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Jul 2019 at 11:57, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 18 Jul 2019 11:42:29 +0200
>
> Replace a function call and a return statement by a goto statement so that
> a bit of common code will be reused at the end of this function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/samsung/odroid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
> index f0f5fa9c27d3..d152ef8dfea3 100644
> --- a/sound/soc/samsung/odroid.c
> +++ b/sound/soc/samsung/odroid.c
> @@ -316,8 +316,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
>         }
>
>         of_node_put(cpu_dai);
> -       of_node_put(codec);
> -       return 0;
> +       goto err_put_node;

No, it does not look good. It makes the code and flow more difficult to follow.

Best regards,
Krzysztof
