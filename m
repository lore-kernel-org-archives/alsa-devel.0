From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Fri, 18 Jul 2014 12:35:48 +0100
Message-ID: <20140718113548.GL17528@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2222848448884105075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 869F12655ED
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 13:36:13 +0200 (CEST)
In-Reply-To: <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2222848448884105075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DnQ8R2kNBE8VLNdv"
Content-Disposition: inline


--DnQ8R2kNBE8VLNdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 02:57:52PM +0530, Vinod Koul wrote:
> The SST driver is the missing piece in our driver stack not upstreamed, so push
> it now :) This driver currently supports PCI device on Merrifield. Future updates
> will bring support for ACPI device as well as future update to PCI devices as
> well

I've started reviewing this several times now but it's a really big
change to review, and not just huge data tables but actual code.  It'd
really benefit from being split up a bit further.

Have you looked at the mailbox framework (not merged yet but hopefully
getting close to it)?

> +MODULE_VERSION(SST_DRIVER_VERSION);

Probably better to drop driver versions from mainline.

> +#define SST_IS_PROCESS_REPLY(header) ((header & PROCESS_MSG) ? true : false)
> +#define SST_VALIDATE_MAILBOX_SIZE(size) ((size <= SST_MAILBOX_SIZE) ? true : false)

Inline functions please.

> +static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
> +{
> +	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
> +	struct ipc_post *__msg, *msg = NULL;
> +	unsigned long irq_flags;
> +
> +	if (list_empty(&drv->rx_list))
> +		return IRQ_HANDLED;

Why would the IRQ thread be running with nothing to do, and if it can
be...

> +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {

...won't we handle that gracefully anyway?

> +int sst_alloc_drv_context(struct device *dev)
> +{
> +	struct intel_sst_drv *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		pr_err("malloc fail\n");
> +		return -ENOMEM;
> +	}
> +	sst_drv_ctx = ctx;
> +	return 0;
> +}

As others were saying I'd really like to see some sort of case being
made for a global variable, and if we really do need a global variable
why not just declare it rather than dynamically allocating?

> +	if (0 != sst_driver_ops(sst_drv_ctx))
> +		return -EINVAL;

if (!sst_driver_ops())

> +#define SST_DRIVER_VERSION "5.0.0"

Generally better to drop these from mainline, the kernel version should
be enough.

> +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_put_sync(sst_drv->dev);
> +	if (ret < 0)
> +		return ret;
> +	atomic_dec(&sst_drv->pm_usage_count);
> +
> +	pr_debug("%s: count is %d now..\n", __func__,
> +			atomic_read(&sst_drv->pm_usage_count));
> +	return 0;
> +}

I'm not entirely clear why this is here but if it's to provide trace
just instrument the runtime PM core.

> + * @sst_drv_ctx : driver context
> + *
> + * this inline function assigns a private id for calls that dont have stream
> + * context yet, should be called with lock held
> + */
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

I would expect this to be checking to see if the IDs are free but it
just hands them out in sequence?  There appears to be an array of
streams statically allocated, why not look there for an unused one?

> +static inline void
> +sst_set_fw_state_locked(struct intel_sst_drv *sst_drv_ctx, int sst_state)
> +{
> +	mutex_lock(&sst_drv_ctx->sst_lock);
> +	sst_drv_ctx->sst_state = sst_state;
> +	mutex_unlock(&sst_drv_ctx->sst_lock);
> +}

I can't see any references to this in the code which is good as it seems
a little odd to have a function like this.

> +int register_sst(struct device *);
> +int unregister_sst(struct device *);

Everything else is sst_

> +int sst_download_fw(void)
> +{
> +	int retval = 0;
> +
> +	retval = sst_load_fw();
> +	if (retval)
> +		return retval;
> +	pr_debug("fw loaded successful!!!\n");
> +
> +	if (sst_drv_ctx->ops->restore_dsp_context)
> +		sst_drv_ctx->ops->restore_dsp_context();
> +	sst_drv_ctx->sst_state = SST_FW_RUNNING;
> +	return retval;
> +}

So sst_load_fw() is wrapped with this function sst_download_fw() which
does a tiny bit of extra stuff which might be mostly better done in the
core function...

> +int free_stream_context(unsigned int str_id)
> +{
> +	struct stream_info *stream;
> +	int ret = 0;
> +
> +	stream = get_stream_info(str_id);
> +	if (stream) {

It's a bit scary that this might be used with an invalid ID - what
happens if the ID got reallocated?

> +	retval = sst_drv_ctx->ops->alloc_stream((char *) str_param, block);
> +	str_id = retval;

This cast is scary...  should alloc_stream() be taking a void?

> +	/* Block the call for reply */
> +	retval = sst_wait_timeout(sst_drv_ctx, block);
> +	if (block->data) {

> +	} else if (retval != 0) {

It'd be less surprising if the first check were for retval.

> +	pr_debug("In %s\n", __func__);
> +	/* stream is not allocated, we are allocating */
> +	retval = sst_get_stream_allocated(str_param, &lib_dnld);
> +
> +	if  (retval <= 0) {

Coding style (there's quite a bit of odd coding styles throughout this
code, slightly odd indentation, missing blanks and so on - it generally
doesn't quite look like Linux code).

> +/**
> +* intel_sst_check_device - checks SST device
> +*
> +* This utility function checks the state of SST device and downlaods FW if
> +* not done, or resumes the device if suspended
> +*/
> +int intel_sst_check_device(void)

Can we have a better name please?  But this all seems very odd, why is
runtime PM not causing the firmware to be loaded?

> +	/* The free_stream will return a error if there is no stream to free,
> +	(i.e. the alloc failure case). And in this case the open does a put in
> +	the error scenario, so skip in this case.
> +		In the close we need to handle put in the success scenario and
> +	the timeout error(EBUSY) scenario. */

Another weird coding style thing.

> +static int sst_device_control(int cmd, void *arg)
> +{
> +	int retval = 0, str_id = 0;
> +
> +	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
> +		return 0;
> +
> +	switch (cmd) {
> +	case SST_SND_START: {

Eew, ioctl().  This would be clearer if it were a series of functions,
there's nothing shared here.

> +static int sst_set_generic_params(enum sst_controls cmd, void *arg)
> +{
> +	int ret_val = 0;
> +
> +	if (NULL == arg)
> +		return -EINVAL;

Again an ioctl()...

> +	/* check busy bit */
> +	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> +	while (header.p.header_high.part.busy) {
> +		if (loop_count > 10) {
> +			pr_err("sst: Busy wait failed, cant send this msg\n");
> +			retval = -EBUSY;
> +			goto out;
> +		}
> +		udelay(500);
> +		loop_count++;
> +		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> +	}

Throw a cpu_relax() in there if we need to spin...

> +	pr_info("FW Version %02x.%02x.%02x.%02x\n",
> +		init->fw_version.type, init->fw_version.major,
> +		init->fw_version.minor, init->fw_version.build);
> +	pr_info("Build date %s Time %s\n",
> +			init->build_info.date, init->build_info.time);

Same comment as for some of the other firmwares - consider providing
this via /proc or sysfs as well.

> +static inline int sst_validate_elf(const struct firmware *sst_bin, bool dynamic)
> +{
> +	Elf32_Ehdr *elf;
> +
> +	BUG_ON(!sst_bin);
> +
> +	pr_debug("IN %s\n", __func__);
> +
> +	elf = (Elf32_Ehdr *)sst_bin->data;
> +
> +	if ((elf->e_ident[0] != 0x7F) || (elf->e_ident[1] != 'E') ||
> +	    (elf->e_ident[2] != 'L') || (elf->e_ident[3] != 'F')) {
> +		pr_debug("ELF Header Not found!%zu\n", sst_bin->size);
> +		return -EINVAL;
> +	}
> +
> +	if (dynamic == true) {
> +		if (elf->e_type != ET_DYN) {
> +			pr_err("Not a dynamic loadable library\n");
> +			return -EINVAL;
> +		}
> +	}
> +	pr_debug("Valid ELF Header...%zu\n", sst_bin->size);
> +	return 0;
> +}

We have generic ELF handling code in the kernel, should this go there?

> +{
> +	struct fw_header *header;

struct fw_header should probably be better namespaced?

> +void sst_memcpy_free_resources(void)
> +{
> +	struct sst_memcpy_list *listnode, *tmplistnode;
> +
> +	pr_debug("entry:%s\n", __func__);
> +
> +	/*Free the list*/
> +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
> +		list_for_each_entry_safe(listnode, tmplistnode,
> +				&sst_drv_ctx->memcpy_list, memcpylist) {
> +			list_del(&listnode->memcpylist);
> +			kfree(listnode);
> +		}
> +	}
> +	sst_memcpy_free_lib_resources();
> +}

I'm having a hard time seeing why we don't just copy the data as we go
rather than allocating this list?  It seems to just be making the code
more complex.

> +/**
> + * sst_next_track: notify next track
> + * @str_id:		stream ID
> + *
> + * This function is called by any function which wants to
> + * set next track. Current this is NOP as FW doest care
> + */
> +int sst_next_track(void)
> +{
> +	pr_debug("SST DBG: next_track");
> +	return 0;
> +}

Shouldn't the operation just be made optional then, obviously the upper
layers don't care either?

--DnQ8R2kNBE8VLNdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyQaRAAoJELSic+t+oim9VhMP/1D26akXEuXjwesv1gvXAlZV
NjM6AQVeqPgfgtpO/5IJUzaGtKcyQfNSZOpb5uY8EaIDAY0Vat9thclfhrGEtb3Z
gVAwc6g+0jexavJQo+8jj9OmfVt2H0pDer3MXnbaUyNrlZQ9aiyBx7F7qsO56t74
PfEEkpxEtua8vcJGV7E+hhTm0LOsmMmDCems2j13WDRdTA4FdXgWv9Kh9sTgWsOB
pO2Xwr6gQCnH+BhqDabMi94AZKG74DuQMc+vXa+IBFwTMv+8K5KQdwWE07Fo5KQP
hl05gU8FM7o+kcCo0dn/3v1Pf1DbYLeyDDeSH14GionbwDkVR3bauiypWGEGhY1P
jqZOv1aTzHSijOndOE9a3yyS/twjbUxvoVfM8Z88RkaoIsyAEtporB7VmmyZbXfG
myEaXExJUYoTinbj8PAuwpAMYNY8Zlp1klKnmigJ6m0lhTvGkQQq5zWyrLEztmX6
R+P+dbE2TxOTyyswMGLAj1g1DnnUjmjjzQZu92QDF0cST5s77o2/9AEeJ8qqTnlH
cfWlMJrSC+N9YsRBD4qN3Dbaxpd1i6JsPecAKcw+gq1JV2pVuMiQiY3BgwswvBtk
5Ud9ufSjjKvLqMSAw1XbUAfokFY9hGYYolmMLRE5+ZY4JOKiEe0bR8H5tRGrpfxz
k9mUi5dHkwW+7lAr2DSP
=RXvn
-----END PGP SIGNATURE-----

--DnQ8R2kNBE8VLNdv--

--===============2222848448884105075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2222848448884105075==--
