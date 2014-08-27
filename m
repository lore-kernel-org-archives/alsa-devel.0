From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 01/11] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Wed, 27 Aug 2014 20:40:21 +0100
Message-ID: <20140827194021.GT17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6484161001090919413=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3EF268007
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 21:40:29 +0200 (CEST)
In-Reply-To: <1408625450-32315-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6484161001090919413==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YVOdKHrFk41NcKgk"
Content-Disposition: inline


--YVOdKHrFk41NcKgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:40PM +0530, Subhransu S. Prusty wrote:

> +static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
> +{
> +	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
> +	struct ipc_post *__msg, *msg = NULL;
> +	unsigned long irq_flags;
> +
> +	if (list_empty(&drv->rx_list))
> +		return IRQ_HANDLED;
> +
> +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {

This still has the same weird empty check then lock thing that I queried
last time - even if it's somehow safe (I'm not convinced it is) it looks
buggy to check if the list is empty outside the lock.

One of the reason review has been slow here is that there seem to be
rather a lot of review comments which have not been addressed, though
kernel summit was part of it too as was not having PATCH in the subject.

> +	default:
> +		pr_err("SST Driver capablities missing for pci_id: %x",
> +				sst->pci_id);

Still using pr_ prints instead of dev_ as well it seems.

> +static int intel_sst_probe(struct pci_dev *pci,
> +			const struct pci_device_id *pci_id)
> +{

> +	pr_debug("Probe for DID %x\n", pci->device);

If you used dev_ printks this (unneeded) log would get a sensibly
formatted device name automatically!

> +	sst_drv_ctx = devm_kzalloc(&pci->dev, sizeof(*sst_drv_ctx), GFP_KERNEL);
> +	if (!sst_drv_ctx)
> +		return -ENOMEM;

> +	if (0 != sst_driver_ops(sst_drv_ctx))
> +		return -EINVAL;

To quote my previous review:

| if (!sst_driver_ops())

> +	pr_info("Got drv data max stream %d\n",
> +				sst_drv_ctx->info.max_streams);

I can't see anything betwen the alocation above and here which might
initialize anything in info.

> +	/* Init the device */
> +	ret = pci_enable_device(pci);
> +	if (ret) {
> +		pr_err("device can't be enabled\n");

Print the return code.

> +	pr_info("%s successfully done!\n", __func__);

Don't include noisy prints like this.

> +do_unmap_dram:
> +	iounmap(sst_drv_ctx->dram);
> +do_unmap_iram:
> +	iounmap(sst_drv_ctx->iram);
> +do_unmap_sram:
> +	iounmap(sst_drv_ctx->mailbox);
> +do_unmap_shim:
> +	iounmap(sst_drv_ctx->shim);

Use the pcim_ functions and avoid the need for this cleanup.

> +	iounmap(sst_drv_ctx->dram);
> +	iounmap(sst_drv_ctx->iram);
> +	iounmap(sst_drv_ctx->mailbox);
> +	iounmap(sst_drv_ctx->shim);
> +	flush_scheduled_work();
> +	destroy_workqueue(sst_drv_ctx->post_msg_wq);

You're destroying the workqueue after unmapping all the regions - that
doesn't seem right, what if something was running?

> +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> +{
> +	int ret;
> +
> +	pm_runtime_mark_last_busy(sst_drv->dev);
> +	ret = pm_runtime_put_autosuspend(sst_drv->dev);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}

There's really nothing device specific about this - if this helper is
useful please add it to pm_runtime.h (it seems like a common enough
pattern).

> +#define MAX_BLOCKS 15

That's a generic name especially in a header...

> +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
> +{
> +	unsigned int local;
> +
> +	spin_lock(&sst_drv_ctx->block_lock);
> +	sst_drv_ctx->pvt_id++;
> +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> +		sst_drv_ctx->pvt_id = 1;
> +	local = sst_drv_ctx->pvt_id;
> +	spin_unlock(&sst_drv_ctx->block_lock);
> +	return local;
> +}

The comments about overflow continue to apply here.

In general there's also a *lot* of code in this header most of which
isn't obviously fast paths or anything and so should probably in
regular C files, the header is currently bigger than the source file.

> +static inline int sst_shim_write(void __iomem *addr, int offset, int value)
> +{
> +	writel(value, addr + offset);
> +	return 0;
> +}

I'd have expected a helper like this to take a driver object rather than
a raw address (this is something which could reasonably be in a header
BTW).

--YVOdKHrFk41NcKgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/jQiAAoJELSic+t+oim9mwQP/1qhGbm/u7JGGckxvTZDO9hY
r56my2HdK/5RZe00IQxQZUc+rEfV23WFpuRgNQtQZoQ9pemLO9Jf2ol0AcNj/L4s
w4KiC6lOByZnBHRjk3KSVF+Wu1sPAvNfDdA4Ow4/h//Wisjs3E13tkCy1R1vqLrW
/JjG8vQTWO8bqmCvuATjB74jbIRjilm5yJA4aC191q50KSwXE2tdf5Ue0uQPv9aW
5VjpP26KTnEPUKI5+Y0RgbIcoeeaI9h9C0j0SInGz4WfFZNkXB0ydE/FQwo4Fam6
RIJYAnWmf47u6TN0Oi00k5BOm61VRGiLWvr/9iHvYURo+PWZAg+hDoZ4I1RZp53/
mBNVYJ/GflWPiuJzXltjAb55/HlKMDIiAkkJ4MYCN4tKqOc60o4nQ7yXQ1K0c1ra
cGIoaN8qoRMFypKUXYbEHwhzFRn3eRBAvrInKR3FIDr4h/4j0ArU/uyVdK1KebpY
kx+UZMGG1Hzrz+6QRZj/y8IBfjd7kg9wgVBoowMqIJnNSLD6fhnf5hAW+CIAVfFt
aBGaNJWVJ6aEacAmuvk77l0kXjiVL0EG4OA93KTSTOY2SzA7GUXHMJRPwEocceEj
wPWHvih9DPFQ4Lky7RJEQ1d2joG7W9GCS7eF7ByV40l7znOELD64CtmfDZpkzoe3
EtK0IQt4AQ2lqTaEDV+b
=3c3x
-----END PGP SIGNATURE-----

--YVOdKHrFk41NcKgk--

--===============6484161001090919413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6484161001090919413==--
