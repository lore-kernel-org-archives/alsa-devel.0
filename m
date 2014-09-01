Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ABA5A264EAA
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:40:09 +0200 (CEST)
Date: Mon, 1 Sep 2014 17:47:53 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140901121753.GC12898@vinod.koul@linux.intel.com>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140827203737.GY17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v3 04/11] ASoC: Intel: sst: Add IPC handling
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 27, 2014 at 09:37:37PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:20:43PM +0530, Subhransu S. Prusty wrote:
> 
> > +int sst_free_block(struct intel_sst_drv *ctx, struct sst_block *freed)
> > +{
> > +	struct sst_block *block = NULL, *__block;
> > +
> > +	pr_debug("in %s\n", __func__);
> > +	spin_lock_bh(&ctx->block_lock);
> > +	list_for_each_entry_safe(block, __block, &ctx->block_list, node) {
> > +		if (block == freed) {
> > +			list_del(&freed->node);
> > +			kfree(freed->data);
> > +			freed->data = NULL;
> > +			kfree(freed);
> 
> Can you safely kfree() inside a spinlock?
I think we can use kfree() inside a spinlock, but will move it out of it.
> 
> > +			spin_unlock_bh(&ctx->block_lock);
> > +			return 0;
> > +		}
> > +	}
> > +	spin_unlock_bh(&ctx->block_lock);
> > +	return -EINVAL;
> 
> I'd expect much louder complaints if we try to free something that's not
> allocated - what happens if we end up reallocating something quickly and
> then double freeing?  Better to complain if we hit such a code path.
"freed" is a block which is passed by the caller to be freed up. Will add a
comment.
> 
> > +	/* check busy bit */
> > +	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > +	if (header.p.header_high.part.busy) {
> > +		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
> > +		pr_debug("Busy not free... post later\n");
> > +		return;
> > +	}
> > +	/* copy msg from list */
> 
> Blank line here.
Will remove.
> 
> > +	/* check busy bit */
> > +	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > +	while (header.p.header_high.part.busy) {
> > +		if (loop_count > 10) {
> > +			pr_err("sst: Busy wait failed, cant send this msg\n");
> > +			retval = -EBUSY;
> > +			goto out;
> > +		}
> > +		cpu_relax();
> > +		loop_count++;
> > +		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > +	}
> 
> 10 spins seems short but OK.
> 
> > +	pr_debug("sst: Post message: header = %x\n",
> > +					msg->mrfld_header.p.header_high.full);
> > +	pr_debug("sst: size = 0x%x\n", msg->mrfld_header.p.header_low_payload);
> > +	if (msg->mrfld_header.p.header_high.part.large)
> > +		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
> > +			msg->mailbox_data,
> > +			msg->mrfld_header.p.header_low_payload);
> > +
> > +	sst_shim_write64(sst_drv_ctx->shim, SST_IPCX, msg->mrfld_header.full);
> 
> Can we factor out the I/O bit with the non-blocking case here here?
> It's just a small bit at the top of the function that's really
> duplicated.
Ok.
> 
> > +	case IPC_IA_FW_ASYNC_ERR_MRFLD:
> > +		pr_err("FW sent async error msg:\n");
> > +		for (i = 0; i < (data_size/4); i++)
> > +			pr_err("0x%x\n", (*((unsigned int *)data_offset + i)));
> 
> print_hex_dump()?
Ok.



-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
