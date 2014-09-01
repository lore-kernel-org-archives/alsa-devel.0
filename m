From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v3 01/11] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Mon, 1 Sep 2014 16:07:55 +0530
Message-ID: <7391.64394694871$1409569242@news.gmane.org>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-2-git-send-email-subhransu.s.prusty@intel.com>
 <20140827194021.GT17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 45838261B1B
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 13:00:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140827194021.GT17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 27, 2014 at 08:40:21PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:20:40PM +0530, Subhransu S. Prusty wrote:
> 
> > +static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
> > +{
> > +	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
> > +	struct ipc_post *__msg, *msg = NULL;
> > +	unsigned long irq_flags;
> > +
> > +	if (list_empty(&drv->rx_list))
> > +		return IRQ_HANDLED;
> > +
> > +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> > +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {
> 
> This still has the same weird empty check then lock thing that I queried
> last time - even if it's somehow safe (I'm not convinced it is) it looks
> buggy to check if the list is empty outside the lock.
>
This list_empty() check is required. As it might happen that multiple irq
could add to the list and schedule the thread. If one thread has already
parsed the list, then the empty() check should happen for the second
thread as list_for_each_entry_safe() is not safe if the list is already
empty.

Yes it makes sense to move the list_empty() check inside the spin_lock().

> One of the reason review has been slow here is that there seem to be
> rather a lot of review comments which have not been addressed, though
> kernel summit was part of it too as was not having PATCH in the subject.
>

Apologize for not having PATCH in the subject. Will take care of the same
from now on.
 
> > +	default:
> > +		pr_err("SST Driver capablities missing for pci_id: %x",
> > +				sst->pci_id);
> 
> Still using pr_ prints instead of dev_ as well it seems.
> 
> > +static int intel_sst_probe(struct pci_dev *pci,
> > +			const struct pci_device_id *pci_id)
> > +{
> 
> > +	pr_debug("Probe for DID %x\n", pci->device);
> 
> If you used dev_ printks this (unneeded) log would get a sensibly
> formatted device name automatically!

Will change.
> 
> > +	sst_drv_ctx = devm_kzalloc(&pci->dev, sizeof(*sst_drv_ctx), GFP_KERNEL);
> > +	if (!sst_drv_ctx)
> > +		return -ENOMEM;
> 
> > +	if (0 != sst_driver_ops(sst_drv_ctx))
> > +		return -EINVAL;
> 
> To quote my previous review:
> 
> | if (!sst_driver_ops())
> 
> > +	pr_info("Got drv data max stream %d\n",
> > +				sst_drv_ctx->info.max_streams);
> 
> I can't see anything betwen the alocation above and here which might
> initialize anything in info.a

Don't need. Will add later.
> 
> > +	/* Init the device */
> > +	ret = pci_enable_device(pci);
> > +	if (ret) {
> > +		pr_err("device can't be enabled\n");
> 
> Print the return code. 
Ok
> 
> > +	pr_info("%s successfully done!\n", __func__);
> 
> Don't include noisy prints like this.
Ok

> 
> > +do_unmap_dram:
> > +	iounmap(sst_drv_ctx->dram);
> > +do_unmap_iram:
> > +	iounmap(sst_drv_ctx->iram);
> > +do_unmap_sram:
> > +	iounmap(sst_drv_ctx->mailbox);
> > +do_unmap_shim:
> > +	iounmap(sst_drv_ctx->shim);
> 
> Use the pcim_ functions and avoid the need for this cleanup.

Will check this.
> 
> > +	iounmap(sst_drv_ctx->dram);
> > +	iounmap(sst_drv_ctx->iram);
> > +	iounmap(sst_drv_ctx->mailbox);
> > +	iounmap(sst_drv_ctx->shim);
> > +	flush_scheduled_work();
> > +	destroy_workqueue(sst_drv_ctx->post_msg_wq);
> 
> You're destroying the workqueue after unmapping all the regions - that
> doesn't seem right, what if something was running?
Ok.
> 
> > +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> > +{
> > +	int ret;
> > +
> > +	pm_runtime_mark_last_busy(sst_drv->dev);
> > +	ret = pm_runtime_put_autosuspend(sst_drv->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +	return 0;
> > +}
> 
> There's really nothing device specific about this - if this helper is
> useful please add it to pm_runtime.h (it seems like a common enough
> pattern).
> 
Will add a helper for this in PM.
> > +#define MAX_BLOCKS 15
> 
> That's a generic name especially in a header...
>
Will change. 
> > +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
> > +{
> > +	unsigned int local;
> > +
> > +	spin_lock(&sst_drv_ctx->block_lock);
> > +	sst_drv_ctx->pvt_id++;
> > +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> > +		sst_drv_ctx->pvt_id = 1;
> > +	local = sst_drv_ctx->pvt_id;
> > +	spin_unlock(&sst_drv_ctx->block_lock);
> > +	return local;
> > +}
> 
> The comments about overflow continue to apply here.

Vinod has already replied to you regarding this, below is a snippet from
the conversation earlier. Is there anything else we need to address?
> > > I would expect this to be checking to see if the IDs are free but it
> > > just hands them out in sequence?  There appears to be an array of
> > > streams statically allocated, why not look there for an unused one?
> 
> > we use these incrementally. The driver stamps each IPC to DSP with a
> > number.
> > The size is limited by bits in the IPCs. So we keep going till we hit
> > max,
> > that time we set it back to 1
> 
> > These ids are not freed or allocated as IPC latency is small enough and
> > IPCs
> > less. We haven't hot scenarios where we go complete round but IPC is
> > still
> > pending :)
> 
> Yet.
For this genertaion of HW :) Next gen has different interface though so not
worried :)
> 
> In general there's also a *lot* of code in this header most of which
> isn't obviously fast paths or anything and so should probably in
> regular C files, the header is currently bigger than the source file.

Will clean this up.
> 
> > +static inline int sst_shim_write(void __iomem *addr, int offset, int value)
> > +{
> > +	writel(value, addr + offset);
> > +	return 0;
> > +}
> 
> I'd have expected a helper like this to take a driver object rather than
> a raw address (this is something which could reasonably be in a header
> BTW).
Yes. Will change it.



-- 
