From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Tegra: Fix error handling in DMA
 channel alloc
Date: Mon, 28 Feb 2011 15:08:29 +0000
Message-ID: <1298905709.3300.0.camel@odin>
References: <1298430994-20999-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 02C5C247EF
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 16:08:33 +0100 (CET)
Received: by wwf26 with SMTP id 26so3963393wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 07:08:33 -0800 (PST)
In-Reply-To: <1298430994-20999-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-22 at 20:16 -0700, Stephen Warren wrote:
> tegra_dma_allocate_channel() returns NULL on errors, not an error pointer.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/tegra_pcm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
> index 40540b1..3c271f9 100644
> --- a/sound/soc/tegra/tegra_pcm.c
> +++ b/sound/soc/tegra/tegra_pcm.c
> @@ -161,8 +161,8 @@ static int tegra_pcm_open(struct snd_pcm_substream *substream)
>  	prtd->dma_req[1].dev = prtd;
>  
>  	prtd->dma_chan = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
> -	if (IS_ERR(prtd->dma_chan)) {
> -		ret = PTR_ERR(prtd->dma_chan);
> +	if (prtd->dma_chan == NULL) {
> +		ret = -ENOMEM;
>  		goto err;
>  	}
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
