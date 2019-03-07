From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: Question about devm_get_clk_from_child()
Date: Thu, 07 Mar 2019 11:18:02 -0800
Message-ID: <155198628270.20095.3432089262334429455@swboyd.mtv.corp.google.com>
References: <877edcczwl.wl-kuninori.morimoto.gx@renesas.com>
 <87wolcbhy4.wl-kuninori.morimoto.gx@renesas.com>
 <155189284090.20095.14047212664009518639@swboyd.mtv.corp.google.com>
 <87lg1rmtqi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 047DAF806F7
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 20:18:06 +0100 (CET)
In-Reply-To: <87lg1rmtqi.wl-kuninori.morimoto.gx@renesas.com>
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

Quoting Kuninori Morimoto (2019-03-06 16:20:40)
> 
> Hi Stephen
> 
> > > index 14cbf23..96053a9 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -4213,7 +4213,7 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
> > >         if (!np)
> > >                 return ERR_PTR(-ENOENT);
> > >  
> > > -       return __of_clk_get(np, -1, np->full_name, name);
> > > +       return __of_clk_get(np, 0, np->full_name, name);
> > >  }
> > 
> > Yes this is correct. Thanks for debugging and fixing my thinko here. I
> > was thinking that nobody would call of_clk_get_by_name() unless they
> > wanted to find some clk that had a matching name, but it seems that we
> > also allow NULL to be passed as the name to mean the typical "wildcard
> > match" thing that clkdev has done for years. I'll throw this patch on
> > top of the merge commit so the breakage window is small as I'd rather
> > not rewrite the series just for this. Thanks.
> 
> Ahh, OK.
> So, how about this ? it is including both opinion :)
> I'm not sure which one should be applied, but both can solve my issue.
> 

No worries. I applied your original patch.
