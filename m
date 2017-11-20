From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: bells: Use common error handling
	code in bells_set_bias_level_post()
Date: Mon, 20 Nov 2017 08:38:57 +0100
Message-ID: <CAJKOXPfHg4MeYr_WxxRRzF0BOBJLR8UNZb689tCLQgQFrONNww@mail.gmail.com>
References: <8c4e72ae-7606-a4c8-3d53-42364d7edbb2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 85633266F89
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 08:39:01 +0100 (CET)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA53C21985
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 07:38:59 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id y82so5242345wmg.1
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 23:38:59 -0800 (PST)
In-Reply-To: <8c4e72ae-7606-a4c8-3d53-42364d7edbb2@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 19, 2017 at 3:08 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 19 Nov 2017 15:00:22 +0100
>
> * Add a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
>
> * Replace two calls of the macro "pr_err" by goto statements.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/samsung/bells.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
> index 34deba461ae1..fc9a71523b3e 100644
> --- a/sound/soc/samsung/bells.c
> +++ b/sound/soc/samsung/bells.c
> @@ -120,18 +120,14 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
>         switch (level) {
>         case SND_SOC_BIAS_STANDBY:
>                 ret = snd_soc_codec_set_pll(codec, WM5102_FLL1, 0, 0, 0);
> -               if (ret < 0) {
> -                       pr_err("Failed to stop FLL: %d\n", ret);
> -                       return ret;
> -               }
> +               if (ret < 0)
> +                       goto report_failure;
>

No. The same as previously - just for error path code this makes code
less readable.

Best regards,
Krzysztof
