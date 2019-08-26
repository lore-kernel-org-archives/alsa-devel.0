From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] ASoC: rsnd: fixup 6ch settings to 8ch
Date: Mon, 26 Aug 2019 11:30:32 +0200
Message-ID: <20190826093032.GA24143@vmlxhi-102.adit-jv.com>
References: <877ebi1v1e.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 637BDF8014A
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 11:30:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <877ebi1v1e.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Timo Wischer <twischer@de.adit-jv.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san,

We've been reviewing this patch in the context of Renesas-Yocto-v3.21.0
BSP integration, where it is contained as commit [1].

On Thu, Apr 25, 2019 at 03:16:58PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> rsnd need to use 8ch clock settings for 6ch for TDM.
> Otherwise, it can't work correctly.
> This patch fixup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/rcar/core.c | 18 +++++++++++++-----
>  sound/soc/sh/rcar/rsnd.h |  1 +
>  sound/soc/sh/rcar/ssi.c  |  2 ++
>  3 files changed, 16 insertions(+), 5 deletions(-)

[..]

> diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
> index f5afab6..44bda21 100644
> --- a/sound/soc/sh/rcar/ssi.c
> +++ b/sound/soc/sh/rcar/ssi.c
> @@ -303,6 +303,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
>  	if (rsnd_runtime_is_tdm_split(io))
>  		chan = rsnd_io_converted_chan(io);
>  
> +	chan = rsnd_channel_normalization(chan);
> +

Since the "chan" value is already normalized by calling:
 => rsnd_ssi_master_clk_start()
  => chan = rsnd_runtime_channel_for_ssi(io)
   => rsnd_runtime_channel_for_ssi_with_params()
    => rsnd_channel_normalization()

I was wondering if it is really required to call
rsnd_channel_normalization() second time in ssi.c for fixing the issue
described in this patch?

>  	main_rate = rsnd_ssi_clk_query(rdai, rate, chan, &idx);
>  	if (!main_rate) {
>  		dev_err(dev, "unsupported clock rate\n");

[1] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=54721f595654
   ("ASoC: rsnd: fixup 6ch settings to 8ch")

-- 
Best Regards,
Eugeniu.
