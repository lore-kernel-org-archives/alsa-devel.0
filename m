From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] ASoC: AMD: Change MCLK to 48Mhz
Date: Mon, 27 Aug 2018 17:01:13 -0600
Message-ID: <CAGS+omDrETEz8jvAfwLu1wo1MwPpG8EY7RN0oNLQM8EX-yQYtg@mail.gmail.com>
References: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, weiyongjun1@huawei.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 21, 2018 at 1:00 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> 25Mhz MCLK which was earlier used was of spread type.
> Thus, we were not getting accurate rate. The 48Mhz system
> clk is of non-spread type and we are changing to it to get
> accurate rate.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index cf2f648..55d7f61 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -42,7 +42,7 @@
>  #include "../codecs/da7219.h"
>  #include "../codecs/da7219-aad.h"
>
> -#define CZ_PLAT_CLK 25000000
> +#define CZ_PLAT_CLK 48000000
>  #define DUAL_CHANNEL           2
>
>  static struct snd_soc_jack cz_jack;
> --
> 1.9.1
>
