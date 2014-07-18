From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Fri, 18 Jul 2014 17:59:03 +0100
Message-ID: <20140718165903.GP17528@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
 <20140718113548.GL17528@sirena.org.uk>
 <20140718141359.GE1985@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1156647125010714185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A50A92608E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 18:59:24 +0200 (CEST)
In-Reply-To: <20140718141359.GE1985@intel.com>
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


--===============1156647125010714185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2HnjjwBZJnP787BF"
Content-Disposition: inline


--2HnjjwBZJnP787BF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2014 at 07:43:59PM +0530, Vinod Koul wrote:
> On Fri, Jul 18, 2014 at 12:35:48PM +0100, Mark Brown wrote:
> > On Wed, Jul 09, 2014 at 02:57:52PM +0530, Vinod Koul wrote:

> > Have you looked at the mailbox framework (not merged yet but hopefully
> > getting close to it)?

Not seeing an answer to this...

> > > +	if (list_empty(&drv->rx_list))
> > > +		return IRQ_HANDLED;

> > Why would the IRQ thread be running with nothing to do, and if it can
> > be...

> Cant think of, we need to remove this!

> > > +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> > > +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {

> > ...won't we handle that gracefully anyway?

> Are you referring to lock + irqsave?

This is part of the thing about the list_empty() check being redundant.

> > > +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_put_sync(sst_drv->dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	atomic_dec(&sst_drv->pm_usage_count);
> > > +
> > > +	pr_debug("%s: count is %d now..\n", __func__,
> > > +			atomic_read(&sst_drv->pm_usage_count));
> > > +	return 0;
> > > +}

> > I'm not entirely clear why this is here but if it's to provide trace
> > just instrument the runtime PM core.

> Well the only usage of pm_usage_count locally is to check in runtime pm
> suspend to S3 transitions. When we are runtime suspended and S3 triggers,
> the device usage count goes up to 1. Then runtime resume and classic suspend
> is invoked in that order. So if we are in this scenario we can't rely on
> checks using frameworks count.

Yes, you can.  You can check to see if the device is runtime suspended
and really this isn't at all specific to this driver - it's a general
thing that affects lots of drivers so shouldn't be open coded in this
one.  IIRC you're looking for pm_runtime_is_suspended().

Essentially any time you need to use atomic variables in a driver you're
probably doing something wrong.

> > > +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
> > > +{
> > > +	unsigned int local;
> > > +
> > > +	spin_lock(&sst_drv_ctx->block_lock);
> > > +	sst_drv_ctx->pvt_id++;
> > > +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> > > +		sst_drv_ctx->pvt_id = 1;
> > > +	local = sst_drv_ctx->pvt_id;
> > > +	spin_unlock(&sst_drv_ctx->block_lock);
> > > +	return local;
> > > +}

> > I would expect this to be checking to see if the IDs are free but it
> > just hands them out in sequence?  There appears to be an array of
> > streams statically allocated, why not look there for an unused one?

> we use these incrementally. The driver stamps each IPC to DSP with a number.
> The size is limited by bits in the IPCs. So we keep going till we hit max,
> that time we set it back to 1

> These ids are not freed or allocated as IPC latency is small enough and IPCs
> less. We haven't hot scenarios where we go complete round but IPC is still
> pending :)

Yet.

> > > +int free_stream_context(unsigned int str_id)
> > > +{
> > > +	struct stream_info *stream;
> > > +	int ret = 0;
> > > +
> > > +	stream = get_stream_info(str_id);
> > > +	if (stream) {

> > It's a bit scary that this might be used with an invalid ID - what
> > happens if the ID got reallocated?

> The free routine checks for valid ID first

That's not the point - the point is that if you're freeing what might be
an invalid ID I don't see any guarantee that the ID hasn't been
allocated to something else.  It's different if there's a specific ID
that can be used for an invalid ID but this looks like it's working
around double frees.

> > > +	while (header.p.header_high.part.busy) {
> > > +		if (loop_count > 10) {
> > > +			pr_err("sst: Busy wait failed, cant send this msg\n");
> > > +			retval = -EBUSY;
> > > +			goto out;
> > > +		}
> > > +		udelay(500);
> > > +		loop_count++;
> > > +		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > > +	}

> > Throw a cpu_relax() in there if we need to spin...

> its more busy wait for the bit to be freed. Since IPC latency is supposed to
> be minimal checking like this helps to minimize.

It's a udelay(500) which is pretty long for a busy wait...

> > > +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
> > > +		list_for_each_entry_safe(listnode, tmplistnode,
> > > +				&sst_drv_ctx->memcpy_list, memcpylist) {
> > > +			list_del(&listnode->memcpylist);
> > > +			kfree(listnode);
> > > +		}
> > > +	}
> > > +	sst_memcpy_free_lib_resources();
> > > +}

> > I'm having a hard time seeing why we don't just copy the data as we go
> > rather than allocating this list?  It seems to just be making the code
> > more complex.

> because we support DMA too. so common parsing and then later we either do
> memcpy and dma. Will push DMA bits after this series.

Keep it simple for now and just memcpy() directly, leaving the functions
that select I/O vs memcpy() - you can always go back and add the DMA
later.

--2HnjjwBZJnP787BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyVJUAAoJELSic+t+oim96ScP+wbpuj+h69Q46s7qp2vDbyHv
+ZdRPeHiRDIqzIpDjlSmimo8chag2ey0BqIppeTqBgZ4mmVDpr/SvbRzK8ZKOUMK
cFEX6hGLqN8HhNTiDVXlwwmVxZE2NGsQPKO7cMTiDGWV7+xgsCUKQrc24tEJizJU
Se+a0ctVmS2/iXlszFaWnyr6DzafQu0DqO00mf8+rfF6QlOasRkZtY2Bl1DV+CQW
tmm7+0QywF0R5ytloU/zBbj85/3dpYNt4u9yAK4IfHCf85lHufQoEEk2hgEPL3t1
9xBytUDraFzOFecrr82v7mbX6F0TbVWetOw3XQ9m2/ZBs6QB9bXJSy5Kr3+k8Q2N
u6+07e3PqGiWxHTGSKu+t4Sfcrz4UWjhrJiT7oMEiLoSIrHHjyZSGxfhwTSgKTcH
rnKXx+yYMG99HE7uVbojJcET7NlDoYftPQHLkWMoP/wbQRVFWEALgXwE+NdKKO6O
Mq61g3egdMEFWbnO6NhwCC/Gqa7kIjAhOwX1Uo78UJ7cZiLg1TBlM9qvbvQvCxTm
QrespUk3HbWMW4SIY1HiTjphYD68E66661JUHW6vGXVchnddXjgDtmF0WAG9gBif
neERpeLg46mk1Oa4T0R/c1E3GTOc+G/LDq5aSbuzFS0uQ/8MD8Zk0AFb/uW6vAo4
AABxfDKhcQIzZJFwK4IP
=pCL0
-----END PGP SIGNATURE-----

--2HnjjwBZJnP787BF--

--===============1156647125010714185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1156647125010714185==--
