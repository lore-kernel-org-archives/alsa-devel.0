From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2] clkdev: add devm_of_clk_get()
Date: Wed, 06 Jul 2016 17:43:11 -0700
Message-ID: <146785219147.73491.2827268663638530377@resonance>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F71F261A2C
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 02:43:16 +0200 (CEST)
Received: by mail-pf0-f174.google.com with SMTP id i123so956304pfg.0
 for <alsa-devel@alsa-project.org>; Wed, 06 Jul 2016 17:43:16 -0700 (PDT)
In-Reply-To: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-ARM <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Quoting Kuninori Morimoto (2016-07-03 18:36:50)
> +struct clk *devm_of_clk_get(struct device *dev,
> +                           struct device_node *np, int index)

Any reason not to use devm_clk_get? Why do we need this helper?

Thanks,
Mike

> +{
> +       struct clk **ptr, *clk;
> +
> +       ptr = devres_alloc(devm_of_clk_release, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk = of_clk_get(np, index);
> +       if (!IS_ERR(clk)) {
> +               *ptr = clk;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL(devm_of_clk_get);
> +
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>                                         const char *dev_id,
>                                         const char *name)
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index a89ba4e..33cd540 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -502,6 +502,8 @@ struct of_phandle_args;
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
> +struct clk *devm_of_clk_get(struct device *dev,
> +                           struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
> @@ -509,6 +511,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
>         return ERR_PTR(-ENOENT);
>  }
> +static inline struct clk *devm_of_clk_get(struct device *dev,
> +                           struct device_node *np, int index)
> +{
> +       return ERR_PTR(-ENOENT);
> +}
>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>                                              const char *name)
>  {
> -- 
> 1.9.1
> 
