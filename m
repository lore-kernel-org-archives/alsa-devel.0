From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH -next] ASoC: samsung: i2s: Fix return value check in i2s_create_secondary_device()
Date: Mon, 18 Feb 2019 09:16:49 +0100
Message-ID: <CAJKOXPc5v_WCtpT5x=1bFBiMCAHtqhns3dcqUEVjnDdDVMA2Og@mail.gmail.com>
References: <20190216012055.79622-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216012055.79622-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 16 Feb 2019 at 02:07, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function platform_device_register_simple() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> Fixes: 7196c64c7d0c ("ASoC: samsung: i2s: Restore support for the secondary PCM")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/samsung/i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
