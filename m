From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: add devm_of_clk_get()
Date: Mon, 04 Jul 2016 09:54:05 +0200
Message-ID: <7596144.XSxKMDxLKp@wuerfel>
References: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 210C0265340
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 09:51:11 +0200 (CEST)
In-Reply-To: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-DT <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux-Kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday, July 4, 2016 1:04:30 AM CEST Kuninori Morimoto wrote:
> @@ -501,6 +503,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
>         return ERR_PTR(-ENOENT);
>  }
> +struct clk *devm_of_clk_get(struct device *dev,
> +                           struct device_node *np, int index)
> +{
> +       return ERR_PTR(-ENOENT);
> +}
>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>                                              const char *name)
>  {
> -- 
> 

This is missing "static inline" as found by the bot.

	Arnd
