From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization
Date: Mon, 18 Feb 2019 12:17:08 +0100
Message-ID: <CAJKOXPdTWanSMJC0cmrkNuR3mjCVg+K8e2EvV=F6X0bj_7v3cA@mail.gmail.com>
References: <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
 <20190215144809.28007-1-s.nawrocki@samsung.com> <20190215144809.28007-2-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215144809.28007-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
> interfaces" and the driver will try to register there multiple times
> same platform device for the secondary FIFO, which of course fails
> miserably.  To fix this we derive the secondary platform device name
> from the primary device name. The secondary device name will now
> be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".
>
> The fixed platform_device_id table entry is removed as the secondary
> device name is now dynamic and device/driver matching is done through
> driver_override.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c    | 49 +++++++++++++++++++++++++-------------
>  sound/soc/samsung/odroid.c |  2 +-
>  2 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index e36c44e2f1bb..4a6dd86459bc 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
>  /* Create platform device for the secondary PCM */
>  static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>  {
> -       struct platform_device *pdev;
> +       struct platform_device *pdev_sec;
> +       const char *devname;
>         int ret;
>
> -       pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
> -       if (!pdev)
> +       devname = devm_kasprintf(&priv->pdev->dev, GFP_KERNEL, "%s-sec",
> +                                dev_name(&priv->pdev->dev));
> +       if (!devname)
>                 return -ENOMEM;
>
> -       ret = device_attach(&pdev->dev);
> +       pdev_sec = platform_device_alloc(devname, -1);
> +       if (!pdev_sec)
> +               return -ENOMEM;
> +
> +       pdev_sec->driver_override = "samsung-i2s";

This is wrong, see:
https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=81639&state=*

Although there is ongoing discussion whether the drivers should use
driver_override at all:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1934411.html

Best regards,
Krzysztof
