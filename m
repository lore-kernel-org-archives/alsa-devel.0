From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Allow the SAI driver to
	turn on SAI_MCLK
Date: Tue, 3 May 2016 23:01:15 -0300
Message-ID: <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
References: <1462324173-10976-1-git-send-email-festevam@gmail.com>
 <20160504014432.GA30210@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 90AE52604D6
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 04:01:16 +0200 (CEST)
Received: by mail-io0-f179.google.com with SMTP id 190so41038606iow.1
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 19:01:16 -0700 (PDT)
In-Reply-To: <20160504014432.GA30210@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2016 at 10:44 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> The field names are literally saying "direction" instead of gating
> or enabling. So it would make more sense to me that they may also

Looking in the MX6UL Referece Manual we have the following description
for these bits:

0 - "...output driver is disabled..."

1 - "...output driver is enabled..."

That's why I preferred using 'enabled' in the property name.

I removed Zidan's email from Cc as his email address is no longer valid.

>> +     if (of_find_property(np, "fsl,sai-enable-mclk", NULL)) {
>
> It would safer to have a compatible check here beside mentioning in
> the DT binding doc.

In this case I need to add a { .compatible = "fsl,imx6ul-sai", }, entry.

I can do that.

> How about:
>                 regmap_update_bits(gpr, IOMUXC_GPR1,
>                                    IMX6UL_GPR1_SAIx_MCLK_DIR(index),
>                                    IMX6UL_GPR1_SAIx_MCLK_DIR(index));

That's a good idea.

Will send a v2 tomorrow.

Thanks
