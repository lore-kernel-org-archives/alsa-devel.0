From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] dmaengine: Add transfer termination
	synchronization support
Date: Thu, 29 Oct 2015 23:59:40 +0200
Message-ID: <CAHp75Vey9zQMCWB63BDsOqEGKQh3SvANWCbH1har-vmXoAquXQ@mail.gmail.com>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>
 <1445334391-12272-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f193.google.com (mail-yk0-f193.google.com
 [209.85.160.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B82265522
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 22:59:41 +0100 (CET)
Received: by ykdr3 with SMTP id r3so4646944ykd.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 14:59:40 -0700 (PDT)
In-Reply-To: <1445334391-12272-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@freescale.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qiao Zhou <zhouqiao@marvell.com>, Laurent Pinchart <renesas@ideasonboard.com>, Matt Campbell <mcampbell@izotope.com>, dmaengine <dmaengine@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jonah Petri <jpetri@izotope.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2015 at 12:46 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> The DMAengine API has a long standing race condition that is inherent to
> the API itself. Calling dmaengine_terminate_all() is supposed to stop and
> abort any pending or active transfers that have previously been submitted.
> Unfortunately it is possible that this operation races against a currently
> running (or with some drivers also scheduled) completion callback.

[]

> +/**
> + * dmaengine_terminate_sync() - Terminate all active DMA transfers
> + * @chan: The channel for which to terminate the transfers
> + *
> + * Calling this function will terminate all active and pending transfers
> + * that have previously been submitted to the channel. It is similar to
> + * dmaengine_terminate_async() but guarantees that the DMA transfer has actually
> + * stopped and that all complete callbacks have finished running when the
> + * function returns.
> + *
> + * This function must only be called from non-atomic context and must not be
> + * called from within a complete callback of a descriptor submitted on the same
> + * channel.
> + */
> +static inline int dmaengine_terminate_sync(struct dma_chan *chan)
> +{
> +       int ret;

Might be a good idea to add might_sleep(); here.

> +
> +       ret = dmaengine_terminate_async(chan);
> +       if (ret)
> +               return ret;
> +
> +       dmaengine_synchronize(chan);
> +
> +       return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko
