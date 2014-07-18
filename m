From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/7] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Fri, 18 Jul 2014 19:43:59 +0530
Message-ID: <20140718141359.GE1985@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
 <20140718113548.GL17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5363146417801365745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5214026562D
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 16:17:56 +0200 (CEST)
In-Reply-To: <20140718113548.GL17528@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5363146417801365745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 12:35:48PM +0100, Mark Brown wrote:
> On Wed, Jul 09, 2014 at 02:57:52PM +0530, Vinod Koul wrote:
> > The SST driver is the missing piece in our driver stack not upstreamed,=
 so push
> > it now :) This driver currently supports PCI device on Merrifield. Futu=
re updates
> > will bring support for ACPI device as well as future update to PCI devi=
ces as
> > well
>=20
> I've started reviewing this several times now but it's a really big
> change to review, and not just huge data tables but actual code.  It'd
> really benefit from being split up a bit further.
well I tried a lot of split up. But further split could have caused lots of
bisect issues. One way to do so was to add makefile last. I can try that
next time if you are fine
>=20
> Have you looked at the mailbox framework (not merged yet but hopefully
> getting close to it)?
>=20
> > +MODULE_VERSION(SST_DRIVER_VERSION);
>=20
> Probably better to drop driver versions from mainline.
Sure thing!

>=20
> > +#define SST_IS_PROCESS_REPLY(header) ((header & PROCESS_MSG) ? true : =
false)
> > +#define SST_VALIDATE_MAILBOX_SIZE(size) ((size <=3D SST_MAILBOX_SIZE) =
? true : false)
>=20
> Inline functions please.
>=20
> > +static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
> > +{
> > +	struct intel_sst_drv *drv =3D (struct intel_sst_drv *) context;
> > +	struct ipc_post *__msg, *msg =3D NULL;
> > +	unsigned long irq_flags;
> > +
> > +	if (list_empty(&drv->rx_list))
> > +		return IRQ_HANDLED;
>=20
> Why would the IRQ thread be running with nothing to do, and if it can
> be...
Cant think of, we need to remove this!

>=20
> > +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> > +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {
>=20
> ...won't we handle that gracefully anyway?
Are you referring to lock + irqsave?

> > +int sst_alloc_drv_context(struct device *dev)
> > +{
> > +	struct intel_sst_drv *ctx;
> > +
> > +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx) {
> > +		pr_err("malloc fail\n");
> > +		return -ENOMEM;
> > +	}
> > +	sst_drv_ctx =3D ctx;
> > +	return 0;
> > +}
>=20
> As others were saying I'd really like to see some sort of case being
> made for a global variable, and if we really do need a global variable
> why not just declare it rather than dynamically allocating?
For this case none, we can try removing this which was more for legacy
reasons when we had pvt ioctls for offload

> > +	if (0 !=3D sst_driver_ops(sst_drv_ctx))
> > +		return -EINVAL;
>=20
> if (!sst_driver_ops())
>=20
> > +#define SST_DRIVER_VERSION "5.0.0"
>=20
> Generally better to drop these from mainline, the kernel version should
> be enough.
>=20
> > +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> > +{
> > +	int ret;
> > +
> > +	ret =3D pm_runtime_put_sync(sst_drv->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +	atomic_dec(&sst_drv->pm_usage_count);
> > +
> > +	pr_debug("%s: count is %d now..\n", __func__,
> > +			atomic_read(&sst_drv->pm_usage_count));
> > +	return 0;
> > +}
>=20
> I'm not entirely clear why this is here but if it's to provide trace
> just instrument the runtime PM core.
Well the only usage of pm_usage_count locally is to check in runtime pm
suspend to S3 transitions. When we are runtime suspended and S3 triggers,
the device usage count goes up to 1. Then runtime resume and classic suspend
is invoked in that order. So if we are in this scenario we can't rely on
checks using frameworks count.
>=20
> > + * @sst_drv_ctx : driver context
> > + *
> > + * this inline function assigns a private id for calls that dont have =
stream
> > + * context yet, should be called with lock held
> > + */
> > +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst=
_drv_ctx)
> > +{
> > +	unsigned int local;
> > +
> > +	spin_lock(&sst_drv_ctx->block_lock);
> > +	sst_drv_ctx->pvt_id++;
> > +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> > +		sst_drv_ctx->pvt_id =3D 1;
> > +	local =3D sst_drv_ctx->pvt_id;
> > +	spin_unlock(&sst_drv_ctx->block_lock);
> > +	return local;
> > +}
>=20
> I would expect this to be checking to see if the IDs are free but it
> just hands them out in sequence?  There appears to be an array of
> streams statically allocated, why not look there for an unused one?
we use these incrementally. The driver stamps each IPC to DSP with a number.
The size is limited by bits in the IPCs. So we keep going till we hit max,
that time we set it back to 1

These ids are not freed or allocated as IPC latency is small enough and IPCs
less. We haven't hot scenarios where we go complete round but IPC is still
pending :)

>=20
> > +static inline void
> > +sst_set_fw_state_locked(struct intel_sst_drv *sst_drv_ctx, int sst_sta=
te)
> > +{
> > +	mutex_lock(&sst_drv_ctx->sst_lock);
> > +	sst_drv_ctx->sst_state =3D sst_state;
> > +	mutex_unlock(&sst_drv_ctx->sst_lock);
> > +}
>=20
> I can't see any references to this in the code which is good as it seems
> a little odd to have a function like this.
My bad, this was to be removed :(

> > +int register_sst(struct device *);
> > +int unregister_sst(struct device *);
>=20
> Everything else is sst_
Hmmm fair point!
>=20
> > +int sst_download_fw(void)
> > +{
> > +	int retval =3D 0;
> > +
> > +	retval =3D sst_load_fw();
> > +	if (retval)
> > +		return retval;
> > +	pr_debug("fw loaded successful!!!\n");
> > +
> > +	if (sst_drv_ctx->ops->restore_dsp_context)
> > +		sst_drv_ctx->ops->restore_dsp_context();
> > +	sst_drv_ctx->sst_state =3D SST_FW_RUNNING;
> > +	return retval;
> > +}
>=20
> So sst_load_fw() is wrapped with this function sst_download_fw() which
> does a tiny bit of extra stuff which might be mostly better done in the
> core function...
ok

>=20
> > +int free_stream_context(unsigned int str_id)
> > +{
> > +	struct stream_info *stream;
> > +	int ret =3D 0;
> > +
> > +	stream =3D get_stream_info(str_id);
> > +	if (stream) {
>=20
> It's a bit scary that this might be used with an invalid ID - what
> happens if the ID got reallocated?
The free routine checks for valid ID first

>=20
> > +	retval =3D sst_drv_ctx->ops->alloc_stream((char *) str_param, block);
> > +	str_id =3D retval;
>=20
> This cast is scary...  should alloc_stream() be taking a void?
Well we had two versions die to tow gens of DSP FW, we mught be able to
clean this up, will give it a shot!

>=20
> > +	/* Block the call for reply */
> > +	retval =3D sst_wait_timeout(sst_drv_ctx, block);
> > +	if (block->data) {
>=20
> > +	} else if (retval !=3D 0) {
>=20
> It'd be less surprising if the first check were for retval.
ok

>=20
> > +	pr_debug("In %s\n", __func__);
> > +	/* stream is not allocated, we are allocating */
> > +	retval =3D sst_get_stream_allocated(str_param, &lib_dnld);
> > +
> > +	if  (retval <=3D 0) {
>=20
> Coding style (there's quite a bit of odd coding styles throughout this
> code, slightly odd indentation, missing blanks and so on - it generally
> doesn't quite look like Linux code).
well this was started off in 2008, never got to a point to push upstream
though tried few times!. Will fix these
>=20
> > +/**
> > +* intel_sst_check_device - checks SST device
> > +*
> > +* This utility function checks the state of SST device and downlaods F=
W if
> > +* not done, or resumes the device if suspended
> > +*/
> > +int intel_sst_check_device(void)
>=20
> Can we have a better name please?  But this all seems very odd, why is
> runtime PM not causing the firmware to be loaded?
well as previously stated runtime resume might be invoked during S3, so we
wnat to load fw after calling _get_sync() so rather than calling _get_sync()
and download everywhere we wrapped it here
>=20
> > +	/* The free_stream will return a error if there is no stream to free,
> > +	(i.e. the alloc failure case). And in this case the open does a put in
> > +	the error scenario, so skip in this case.
> > +		In the close we need to handle put in the success scenario and
> > +	the timeout error(EBUSY) scenario. */
>=20
> Another weird coding style thing.
will fix

>=20
> > +static int sst_device_control(int cmd, void *arg)
> > +{
> > +	int retval =3D 0, str_id =3D 0;
> > +
> > +	if (sst_drv_ctx->sst_state !=3D SST_FW_RUNNING)
> > +		return 0;
> > +
> > +	switch (cmd) {
> > +	case SST_SND_START: {
>=20
> Eew, ioctl().  This would be clearer if it were a series of functions,
> there's nothing shared here.
>=20
> > +static int sst_set_generic_params(enum sst_controls cmd, void *arg)
> > +{
> > +	int ret_val =3D 0;
> > +
> > +	if (NULL =3D=3D arg)
> > +		return -EINVAL;
>=20
> Again an ioctl()...
okay will move to series of functions

>=20
> > +	/* check busy bit */
> > +	header.full =3D sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > +	while (header.p.header_high.part.busy) {
> > +		if (loop_count > 10) {
> > +			pr_err("sst: Busy wait failed, cant send this msg\n");
> > +			retval =3D -EBUSY;
> > +			goto out;
> > +		}
> > +		udelay(500);
> > +		loop_count++;
> > +		header.full =3D sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > +	}
>=20
> Throw a cpu_relax() in there if we need to spin...
its more busy wait for the bit to be freed. Since IPC latency is supposed to
be minimal checking like this helps to minimize.

>=20
> > +	pr_info("FW Version %02x.%02x.%02x.%02x\n",
> > +		init->fw_version.type, init->fw_version.major,
> > +		init->fw_version.minor, init->fw_version.build);
> > +	pr_info("Build date %s Time %s\n",
> > +			init->build_info.date, init->build_info.time);
>=20
> Same comment as for some of the other firmwares - consider providing
> this via /proc or sysfs as well.
ok

>=20
> > +static inline int sst_validate_elf(const struct firmware *sst_bin, boo=
l dynamic)
> > +{
> > +	Elf32_Ehdr *elf;
> > +
> > +	BUG_ON(!sst_bin);
> > +
> > +	pr_debug("IN %s\n", __func__);
> > +
> > +	elf =3D (Elf32_Ehdr *)sst_bin->data;
> > +
> > +	if ((elf->e_ident[0] !=3D 0x7F) || (elf->e_ident[1] !=3D 'E') ||
> > +	    (elf->e_ident[2] !=3D 'L') || (elf->e_ident[3] !=3D 'F')) {
> > +		pr_debug("ELF Header Not found!%zu\n", sst_bin->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dynamic =3D=3D true) {
> > +		if (elf->e_type !=3D ET_DYN) {
> > +			pr_err("Not a dynamic loadable library\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	pr_debug("Valid ELF Header...%zu\n", sst_bin->size);
> > +	return 0;
> > +}
>=20
> We have generic ELF handling code in the kernel, should this go there?
will check that

>=20
> > +{
> > +	struct fw_header *header;
>=20
> struct fw_header should probably be better namespaced?
>=20
> > +void sst_memcpy_free_resources(void)
> > +{
> > +	struct sst_memcpy_list *listnode, *tmplistnode;
> > +
> > +	pr_debug("entry:%s\n", __func__);
> > +
> > +	/*Free the list*/
> > +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
> > +		list_for_each_entry_safe(listnode, tmplistnode,
> > +				&sst_drv_ctx->memcpy_list, memcpylist) {
> > +			list_del(&listnode->memcpylist);
> > +			kfree(listnode);
> > +		}
> > +	}
> > +	sst_memcpy_free_lib_resources();
> > +}
>=20
> I'm having a hard time seeing why we don't just copy the data as we go
> rather than allocating this list?  It seems to just be making the code
> more complex.
because we support DMA too. so common parsing and then later we either do
memcpy and dma. Will push DMA bits after this series.

> > +/**
> > + * sst_next_track: notify next track
> > + * @str_id:		stream ID
> > + *
> > + * This function is called by any function which wants to
> > + * set next track. Current this is NOP as FW doest care
> > + */
> > +int sst_next_track(void)
> > +{
> > +	pr_debug("SST DBG: next_track");
> > +	return 0;
> > +}
>=20
> Shouldn't the operation just be made optional then, obviously the upper
> layers don't care either?
Sure


--=20
~Vinod

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTySunAAoJEHwUBw8lI4NHHIgQAM3tf3h9fl5oJGubxzkmGtFp
uM9TII1KwICDLV3UTp/ktKnrO2ysy+XpRWU7GA3BJ6M0k3eoV2dY/Qbs2XcAJTfm
WdUg6bWnpyTngfflrkGOvZamwkD+ztqcvlMtzTDjcy78DseVXHLruXsNjwInHeFF
d94QWeXeSVj8rTEbi3ZcEkVuXcJLA3EZQUvAyq2/Cf1p4vEcBMBu6Nj6jru3dood
BMbPrpinZwtOmQF+OCINQGv5Dc3IhK57tiiRnMuwSkNBThf65xGt2BIXmzJHknZK
6mPRyVox2cnlXPF9m/09MocIOCYacBb1ShdchQHYvyBqByaOc9vijoxYtvSQLyzC
BZUW8wDyCX5m3olld6Mej+Rf1UZNiNXjKKf3jaDBn973BiET3lR1aUQKCXeC8oVc
mqMm+NTxOAXrmJn+F+EFJ58BgTUITOg4RIdvPLTgCWT2K2EhFMgV/q7LjhgxMgA7
92+QpXLxQCP56jGAXbYNScTs/dXAW5WPhoRby9LcLsOYDtT72V6IyA9ycmL2ZuX6
WsYG8T6K+57tMyD6786sWwB0tBAJKpJ/qp+kLU8lH4lzh0FToQVSklH+1e/sPJZ7
jNV5IFn3BEoet9zyhIRwmeBMKbarGHRjlHipgtnwGpzNKZw9FyaOfQJ4JsL6Nuq7
NCdzsTcUr6L3oNQq5OvI
=1pHq
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

--===============5363146417801365745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5363146417801365745==--
