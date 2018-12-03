From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH linux-next v2 0/6] clk: renesas: adg: add AVB Clock
Date: Mon, 3 Dec 2018 14:11:51 +0200
Message-ID: <d63c751b-fab4-cf88-459e-efe5a3e83da4@mentor.com>
References: <20181203112200.18220-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203112200.18220-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiada_wang@mentor.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Jiada,

On 12/03/2018 01:21 PM, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
> and 8 bits fractional dividers which operates with S0D1ϕ clock.
> 
> This patch-set adds 'adg' clock to R-Car Soc, and changes adg driver to
> register avb clocks when clock-cells of rcar_sound node is 2.
> 
> ---
> v2:
> - expends adg register size and register avb clocks instead of
>   add new clk-avb driver
> - Add adg clock 
> 
> v1: initial version
> 
> Jiada Wang (2):
>   dt-bindings: clock: add clock id for renesas adg clocks
>   ASoC: rsnd: add avb clocks
> 
> Takeshi Kihara (4):
>   clk: renesas: r8a7795: Add ADG clock
>   clk: renesas: r8a7796: Add ADG clock
>   clk: renesas: r8a77990: Add ADG clocks
>   clk: renesas: r8a77995: Add ADG clock
> 

plural 'clocks' for r8a77990 vs. 'clock' in other cases, please unify subjects.

You can consider to add the ADG clock description for r8a77965 / M3-N as well.

>  drivers/clk/renesas/r8a7795-cpg-mssr.c  |   1 +
>  drivers/clk/renesas/r8a7796-cpg-mssr.c  |   1 +
>  drivers/clk/renesas/r8a77990-cpg-mssr.c |   1 +
>  drivers/clk/renesas/r8a77995-cpg-mssr.c |   1 +
>  include/dt-bindings/clock/renesas-adg.h |  11 +

The new header file added above is not needed in my opinion.

>  sound/soc/sh/rcar/adg.c                 | 306 +++++++++++++++++++++++-
>  sound/soc/sh/rcar/gen.c                 |   9 +
>  sound/soc/sh/rcar/rsnd.h                |   9 +
>  8 files changed, 330 insertions(+), 9 deletions(-)
>  create mode 100644 include/dt-bindings/clock/renesas-adg.h
> 

--
Best wishes,
Vladimir
