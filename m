From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: Applied "ASoC: sprd: Add reserved DMA memory support" to the asoc tree
Date: Mon, 6 May 2019 15:37:39 +0800
Message-ID: <CAMz4kuLK_XS93Wpq+BkXVAJA3M+vFnL8pR0gR7aRpYxBzwLv9w@mail.gmail.com>
References: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
 <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, 18 Apr 2019 at 18:26, Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    ASoC: sprd: Add reserved DMA memory support
>
> has been applied to the asoc tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

I did not find this patch in your sound git tree and the linux-next
tree, so could you check if you missed this patch? Or did I miss
anything? Thanks a lot.

>
> Thanks,
> Mark
>
> From 25a073bb9ceda91b8bf731b20ac01b68cc8877a9 Mon Sep 17 00:00:00 2001
> From: Baolin Wang <baolin.wang@linaro.org>
> Date: Fri, 12 Apr 2019 14:40:17 +0800
> Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support
>
> For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
> dynamically to copy audio data between userspace and kernel space, but that
> will increase the risk of memory allocation failure especially the system
> is under heavy load situation.
>
> To make sure the audio can work in this scenario, we usually reserve one
> region of memory to be used as a shared pool of DMA buffers for the
> platform component. So add of_reserved_mem_device_init_by_idx() function
> to initialize the shared pool of DMA buffers to be used by the platform
> component.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/sprd/sprd-pcm-dma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
> index 9be6d4b2bf74..d38ebbbbf169 100644
> --- a/sound/soc/sprd/sprd-pcm-dma.c
> +++ b/sound/soc/sprd/sprd-pcm-dma.c
> @@ -6,6 +6,7 @@
>  #include <linux/dma/sprd-dma.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -530,8 +531,14 @@ static const struct snd_soc_component_driver sprd_soc_component = {
>
>  static int sprd_soc_platform_probe(struct platform_device *pdev)
>  {
> +       struct device_node *np = pdev->dev.of_node;
>         int ret;
>
> +       ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
> +       if (ret)
> +               dev_warn(&pdev->dev,
> +                        "no reserved DMA memory for audio platform device\n");
> +
>         ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
>                                               NULL, 0);
>         if (ret)
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
