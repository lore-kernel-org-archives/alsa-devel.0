From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] clkdev: add devm_of_clk_get()
Date: Mon, 28 Nov 2016 10:10:36 +0000
Message-ID: <20161128101036.GS14217@n2100.armlinux.org.uk>
References: <87vav89chw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87vav89chw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Linux-DT <devicetree@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org, Linux-ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 09:32:51AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
> This patch adds it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - implement in clk-devres.c, and reused existing devm_clk_release()
> 
>  drivers/clk/clk-devres.c | 21 +++++++++++++++++++++
>  include/linux/clk.h      |  7 +++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 8f57154..2449b25 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -53,3 +53,24 @@ void devm_clk_put(struct device *dev, struct clk *clk)
>  	WARN_ON(ret);
>  }
>  EXPORT_SYMBOL(devm_clk_put);
> +
> +struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index)
> +{
> +	struct clk **ptr, *clk;
> +
> +	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk = of_clk_get(np, index);
> +	if (!IS_ERR(clk)) {
> +		*ptr = clk;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL(devm_of_clk_get);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 123c027..1b713db 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -506,6 +506,8 @@ static inline void clk_disable_unprepare(struct clk *clk)
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
> +struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index);

No need for this to be within the ifdef.

>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
> @@ -513,6 +515,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
>  	return ERR_PTR(-ENOENT);
>  }
> +static inline struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index)
> +{
> +	return ERR_PTR(-ENOENT);
> +}

and so no need for this either.  In any case, this will cause !OF ||
!COMMON_CLK builds to fail because this definition will conflict with
that in clk-devres.c

>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>  					     const char *name)
>  {
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
