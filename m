From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: Question about devm_get_clk_from_child()
Date: Wed, 06 Mar 2019 09:20:40 -0800
Message-ID: <155189284090.20095.14047212664009518639@swboyd.mtv.corp.google.com>
References: <877edcczwl.wl-kuninori.morimoto.gx@renesas.com>
 <87wolcbhy4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41C8FF806F7
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2019 18:58:55 +0100 (CET)
In-Reply-To: <87wolcbhy4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Quoting Kuninori Morimoto (2019-03-05 23:18:28)
> 
> of_clk_get_by_name() is using -1 for __of_clk_get() index.
> It will goes to of_parse_clkspec(), and be used for
> of_parse_phandle_with_args().
> Here, if user doesn't specified clock name
> (= of_clk_get_by_name(np, NULL)), this index is still -1,
> and of_parse_phandle_with_args() will return -EINVAL
> (This index will be updated if if it had clock name).
> clk_get_by_name(np, NULL) should work, then, default index
> should be 0 instead of -1.
> This patch fixup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 14cbf23..96053a9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4213,7 +4213,7 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
>         if (!np)
>                 return ERR_PTR(-ENOENT);
>  
> -       return __of_clk_get(np, -1, np->full_name, name);
> +       return __of_clk_get(np, 0, np->full_name, name);
>  }

Yes this is correct. Thanks for debugging and fixing my thinko here. I
was thinking that nobody would call of_clk_get_by_name() unless they
wanted to find some clk that had a matching name, but it seems that we
also allow NULL to be passed as the name to mean the typical "wildcard
match" thing that clkdev has done for years. I'll throw this patch on
top of the merge commit so the breakage window is small as I'd rather
not rewrite the series just for this. Thanks.
