From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
Date: Tue, 16 Jul 2019 11:06:43 +0200
Message-ID: <CAJKOXPdY7xqcBJzU6pe1pSmpbNoBY6yh0rih2t4XGXaYWP3WfA@mail.gmail.com>
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn> <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn
List-Id: alsa-devel@alsa-project.org

On Sat, 13 Jul 2019 at 05:48, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The cpu_dai variable is still being used after the of_node_put() call,
> which may result in double-free:
>
>         of_node_put(cpu_dai);            ---> released here
>
>         ret = devm_snd_soc_register_card(dev, card);
>         if (ret < 0) {
> ...
>                 goto err_put_clk_i2s;    --> jump to err_put_clk_i2s
> ...
>
> err_put_clk_i2s:
>         clk_put(priv->clk_i2s_bus);
> err_put_sclk:
>         clk_put(priv->sclk_i2s);
> err_put_cpu_dai:
>         of_node_put(cpu_dai);            --> double-free here
>
> Fixes: d832d2b246c5 ("ASoC: samsung: odroid: Fix of_node refcount unbalance")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  sound/soc/samsung/odroid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
