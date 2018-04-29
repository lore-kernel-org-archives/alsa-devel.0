From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 09/11] ASoC: AMD: Fix clocks in CZ DA7219
	machine driver
Date: Sun, 29 Apr 2018 21:51:48 +0000
Message-ID: <CAGS+omB2=AhpbRZmF=q0_1LfOM5W8T-qEL5jF3KYmkjR0i5rVQ@mail.gmail.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C6F02266EBE
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 23:52:00 +0200 (CEST)
Received: by mail-vk0-f66.google.com with SMTP id t63-v6so4085061vkb.1
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 14:52:00 -0700 (PDT)
In-Reply-To: <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar.Mukunda@amd.com
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, tiwai@suse.com, Mark Brown <broonie@kernel.org>, weiyongjun1@huawei.com, alexander.deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 5:17 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> From: Akshu Agrawal <akshu.agrawal@amd.com>

> System clock on the platform is 25Mhz and not 24Mhz.

> PLL_OUT for da7219 codec to use DA7219_PLL_FREQ_OUT_98304
> as it is for 48KHz SR.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index 6495eed..fa5ad5b 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -39,8 +39,7 @@
>   #include "../codecs/da7219.h"
>   #include "../codecs/da7219-aad.h"

> -#define CZ_PLAT_CLK 24000000
> -#define MCLK_RATE 24576000
> +#define CZ_PLAT_CLK 25000000
>   #define DUAL_CHANNEL           2

>   static struct snd_soc_jack cz_jack;
> @@ -63,7 +62,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
*rtd)
>          }

>          ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
> -                                 CZ_PLAT_CLK, MCLK_RATE);
> +                                 CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
>          if (ret < 0) {
>                  dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>                  return ret;
> --
> 2.7.4
