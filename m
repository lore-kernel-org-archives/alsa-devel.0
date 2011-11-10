From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Thu, 10 Nov 2011 11:43:10 +0000
Message-ID: <20111110114310.GA3832@opensource.wolfsonmicro.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CCA9103AAB
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 12:43:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Tull <alan.tull@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 01, 2011 at 04:05:16PM -0500, Alan Tull wrote:

This looks mostly good, though as someone pointed out earlier it'd be
nicer to split the ioctl() operation addition out into a separate patch.
One issue, though.

> @@ -1547,6 +1547,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
>  
>  	snd_soc_dapm_free(&card->dapm);
>  
> +	kfree(card->rtd->ops);

This is going to leak - rtd is an array per PCM, not a single value, so
we need to free the ops for each element.  This is so we can have
multiple DMA controllers in a single card.

Actually what would be even easier would be to just embed the ops in the
struct, we need to allocate one per runtime anyway and it makes for less
allocation and cleanup code.
