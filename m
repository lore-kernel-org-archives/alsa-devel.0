From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Tue, 13 Aug 2013 14:58:26 -0300
Message-ID: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id BBA00261A5E
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 19:58:27 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id gf11so4178708vcb.11
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 10:58:26 -0700 (PDT)
In-Reply-To: <1376308870-14232-2-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general

Can't we just use "fsl,fsl-spdif" instead?

> +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.
> +

I think this is not the usual approach we do with dt.

> +static const struct of_device_id fsl_spdif_dt_ids[] = {
> +       { .compatible = "fsl,fsl-spdif", },

Isn't only the first entry enough here?

> +       { .compatible = "fsl,imx6q-spdif", },
> +       { .compatible = "fsl,imx6sl-spdif", },
> +       { .compatible = "fsl,imx53-spdif", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
> +
> +static struct platform_driver fsl_spdif_driver = {
> +       .driver = {
> +               .name = "fsl-spdif-dai",
> +               .owner = THIS_MODULE,
> +               .of_match_table = fsl_spdif_dt_ids,
> +       },
> +       .probe = fsl_spdif_probe,
> +       .remove = fsl_spdif_remove,
> +};
> +
> +module_platform_driver(fsl_spdif_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("Freescale S/PDIF CPU DAI Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:fsl_spdif");

This MODULE_ALIAS name does not match the name you provided earlier:

.name = "fsl-spdif-dai"
