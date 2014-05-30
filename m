From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup SSI interrupts style of
 DeviceTree
Date: Fri, 30 May 2014 11:23:58 +0100
Message-ID: <20140530102358.GC6241@trinity.fluff.org>
References: <87sinrpofv.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 83466261735
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 12:24:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87sinrpofv.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 30, 2014 at 03:10:13AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current SSI interrupts has been set to each port.
> But it is too ugly style.
> SSI interrupts will be listed under
> rcar_sound,ssi node by this patch
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Mark
> 
> There is still no DT user for this driver at this point.
> No conflict happens on platform.
> 
>  .../devicetree/bindings/sound/renesas,rsnd.txt     |   50 ++++++++------------
>  sound/soc/sh/rcar/ssi.c                            |    2 +-
>  2 files changed, 21 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index 8346cab..1fba56b 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -53,36 +53,26 @@ rcar_sound: rcar_sound@0xffd90000 {
>  	};
>  
>  	rcar_sound,ssi {
> -		ssi0: ssi@0 {
> -			interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi1: ssi@1 {
> -			interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi2: ssi@2 {
> -			interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi3: ssi@3 {
> -			interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi4: ssi@4 {
> -			interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi5: ssi@5 {
> -			interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi6: ssi@6 {
> -			interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi7: ssi@7 {
> -			interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi8: ssi@8 {
> -			interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -		ssi9: ssi@9 {
> -			interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
> -		};

This looks like a backward step, especially as we use the ssiX
blocks for DMA too.

Also, please just stop playing around with this stuff, other people
are trying to use this code and changing it without a good technical
reason is causing difficulty.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
