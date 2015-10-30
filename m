From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] dmaengine: Add transfer termination
 synchronization support
Date: Fri, 30 Oct 2015 15:16:13 +0100
Message-ID: <56337BAD.2060506@metafoo.de>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>	<1445334391-12272-2-git-send-email-lars@metafoo.de>
 <CAHp75Vey9zQMCWB63BDsOqEGKQh3SvANWCbH1har-vmXoAquXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 17BB62604BE
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 15:16:17 +0100 (CET)
In-Reply-To: <CAHp75Vey9zQMCWB63BDsOqEGKQh3SvANWCbH1har-vmXoAquXQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@freescale.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qiao Zhou <zhouqiao@marvell.com>, Laurent Pinchart <renesas@ideasonboard.com>, Matt Campbell <mcampbell@izotope.com>, dmaengine <dmaengine@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jonah Petri <jpetri@izotope.com>
List-Id: alsa-devel@alsa-project.org

On 10/29/2015 10:59 PM, Andy Shevchenko wrote:
> On Tue, Oct 20, 2015 at 12:46 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> The DMAengine API has a long standing race condition that is inherent to
>> the API itself. Calling dmaengine_terminate_all() is supposed to stop and
>> abort any pending or active transfers that have previously been submitted.
>> Unfortunately it is possible that this operation races against a currently
>> running (or with some drivers also scheduled) completion callback.
> 
> []
> 
>> +/**
>> + * dmaengine_terminate_sync() - Terminate all active DMA transfers
>> + * @chan: The channel for which to terminate the transfers
>> + *
>> + * Calling this function will terminate all active and pending transfers
>> + * that have previously been submitted to the channel. It is similar to
>> + * dmaengine_terminate_async() but guarantees that the DMA transfer has actually
>> + * stopped and that all complete callbacks have finished running when the
>> + * function returns.
>> + *
>> + * This function must only be called from non-atomic context and must not be
>> + * called from within a complete callback of a descriptor submitted on the same
>> + * channel.
>> + */
>> +static inline int dmaengine_terminate_sync(struct dma_chan *chan)
>> +{
>> +       int ret;
> 
> Might be a good idea to add might_sleep(); here.

Sound like a good idea, thanks, I'll add it (in dmaengine_synchronize() though).

> 
>> +
>> +       ret = dmaengine_terminate_async(chan);
>> +       if (ret)
>> +               return ret;
>> +
>> +       dmaengine_synchronize(chan);
>> +
>> +       return 0;
>> +}
> 
> 
