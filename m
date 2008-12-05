From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 Pandora
Date: Fri, 5 Dec 2008 09:48:24 +0200
Message-ID: <bd7b27490812042348t6593afa8saafb3a42bd346ad7@mail.gmail.com>
References: <1228423194-19567-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1231037E3
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 08:48:24 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so4695448ugf.24
	for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2008 23:48:24 -0800 (PST)
In-Reply-To: <1228423194-19567-1-git-send-email-notasas@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/12/4 Grazvydas Ignotas <notasas@gmail.com>

> This patch adds basic support for OMAP3 Pandora.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/Kconfig        |    8 +
>  sound/soc/omap/Makefile       |    2 +
>  sound/soc/omap/omap3pandora.c |  311
> +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/omap3pandora.c


Hi

I like this board file! It definetely deserves a place in sound/soc/omap.


> +       /* Set McBSP clock to external */
> +       ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
> 0,
> +                                           SND_SOC_CLOCK_IN);


I'm glad to see external clocking using with McBSP. Never tested feature :-)

+/* Digital audio interface glue - connects codec <--> CPU */
> +static struct snd_soc_dai_link omap3pandora_dai[] = {
> +       {
> +               .name = "PCM1773",
> +               .stream_name = "HiFi Out",
> +               .cpu_dai = &omap_mcbsp_dai[0],
> +               .codec_dai = &twl4030_dai,
> +               .ops = &omap3pandora_out_ops,
> +               .init = omap3pandora_out_init,
> +       }, {
> +               .name = "TWL4030",
> +               .stream_name = "Line/Mic In",
> +               .cpu_dai = &omap_mcbsp_dai[1],
> +               .codec_dai = &twl4030_dai,
> +               .ops = &omap3pandora_in_ops,
> +               .init = omap3pandora_in_init,
> +       }
> +};


Nice, first OMAP machine driver using McBSP in multilink configuration.


> +       if (!machine_is_omap3_pandora()) {
> +               pr_debug(PREFIX "Not OMAP3 Pandora\n");
> +               return -ENODEV;
> +       }
> +       pr_info("OMAP3 Pandora SoC init\n");
> +


Minor muttering, but I don't see very much use for these debug prints.


Jarkko
