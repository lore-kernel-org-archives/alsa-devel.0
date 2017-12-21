From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 11/13] slimbus: qcom: Add Qualcomm Slimbus controller driver
Date: Thu, 21 Dec 2017 18:26:28 +0100
Message-ID: <CAK8P3a2twaPd4Kw8D=g3gba68OiAMN6R-kgb03M=L-Oiv0gB5w@mail.gmail.com>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org> <20171211234307.14465-12-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171211234307.14465-12-srinivas.kandagatla@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne <pombredanne@nexb.com>, nathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-arm-msm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: alsa-devel@alsa-project.org

> +
> +       ctrl->tx.base = dmam_alloc_coherent(&pdev->dev,
> +                                          (ctrl->tx.sl_sz * ctrl->tx.n),
> +                                          &ctrl->tx.phy, GFP_KERNEL);
> +       if (!ctrl->tx.base) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }
> +
> +       ctrl->rx.base = dmam_alloc_coherent(&pdev->dev,
> +                                          (ctrl->rx.sl_sz * ctrl->rx.n),
> +                                          &ctrl->rx.phy, GFP_KERNEL);

I got another one of

/git/arm-soc/drivers/slimbus/qcom-ctrl.c: In function 'qcom_slim_probe':
/git/arm-soc/drivers/slimbus/qcom-ctrl.c:584:9: error: passing
argument 3 of 'dmam_alloc_coherent' from incompatible pointer type
[-Werror=incompatible-pointer-types]
         &ctrl->tx.phy, GFP_KERNEL);
         ^
In file included from /git/arm-soc/drivers/slimbus/qcom-ctrl.c:16:0:
/git/arm-soc/include/linux/dma-mapping.h:760:14: note: expected
'dma_addr_t * {aka unsigned int *}' but argument is of type
'phys_addr_t * {aka long long unsigned int *}'
 extern void *dmam_alloc_coherent(struct device *dev, size_t size,
              ^~~~~~~~~~~~~~~~~~~
/git/arm-soc/drivers/slimbus/qcom-ctrl.c:592:9: error: passing
argument 3 of 'dmam_alloc_coherent' from incompatible pointer type
[-Werror=incompatible-pointer-types]
         &ctrl->rx.phy, GFP_KERNEL);
         ^
In file included from /git/arm-soc/drivers/slimbus/qcom-ctrl.c:16:0:
/git/arm-soc/include/linux/dma-mapping.h:760:14: note: expected
'dma_addr_t * {aka unsigned int *}' but argument is of type
'phys_addr_t * {aka long long unsigned int *}'
 extern void *dmam_alloc_coherent(struct device *dev, size_t size,


I don't have time to analyze this further, but I guess this is the
same confusion
that happened in a few other qualcomm drivers, which all used dma_alloc_*
to get a buffer that gets passed into firmware.This is always wrong.

        Arnd
