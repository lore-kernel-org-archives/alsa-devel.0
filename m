From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rcar: remove original filter from
 rsnd_dma_init()
Date: Tue, 29 Oct 2013 09:30:09 +0100
Message-ID: <526F7211.8080607@metafoo.de>
References: <878uxc7bv4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-028.synserver.de (smtp-out-028.synserver.de
 [212.40.185.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D3AD2610A9
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 09:30:12 +0100 (CET)
In-Reply-To: <878uxc7bv4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/29/2013 08:52 AM, Kuninori Morimoto wrote:
> Remove original filter from rsnd_dma_init(),
> and use SH-DMA suitable filter.
> This new style can be used from Device Tree.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
[...]
> +	dma->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +						     (void *)id, dev,
> +						     is_play ? "tx" : "rx");
[...]

Just wondering, do you still need to support the non-DT case in your driver?

- Lars
