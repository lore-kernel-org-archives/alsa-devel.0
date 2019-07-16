From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: samsung: odroid: fix an use-after-free issue
 for codec
Date: Tue, 16 Jul 2019 11:06:13 +0200
Message-ID: <CAJKOXPdGAsc=XpJXVRg+oaa1o1PXkJJ8JDAnkNkJuzJrfE_OJA@mail.gmail.com>
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn> <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn
List-Id: alsa-devel@alsa-project.org

On Sat, 13 Jul 2019 at 05:48, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The codec variable is still being used after the of_node_put() call,
> which may result in use-after-free.
>
> Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")
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
>  sound/soc/samsung/odroid.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
