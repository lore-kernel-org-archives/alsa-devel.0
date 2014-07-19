From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/7] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Sat, 19 Jul 2014 12:01:34 +0530
Message-ID: <20140719063134.GI1985@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
 <20140718113548.GL17528@sirena.org.uk>
 <20140718141359.GE1985@intel.com>
 <20140718165903.GP17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3040736340403189731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8328126179C
 for <alsa-devel@alsa-project.org>; Sat, 19 Jul 2014 08:35:47 +0200 (CEST)
In-Reply-To: <20140718165903.GP17528@sirena.org.uk>
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


--===============3040736340403189731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 05:59:03PM +0100, Mark Brown wrote:
> On Fri, Jul 18, 2014 at 07:43:59PM +0530, Vinod Koul wrote:
> > On Fri, Jul 18, 2014 at 12:35:48PM +0100, Mark Brown wrote:
> > > On Wed, Jul 09, 2014 at 02:57:52PM +0530, Vinod Koul wrote:
>=20
> > > Have you looked at the mailbox framework (not merged yet but hopefully
> > > getting close to it)?
>=20
> Not seeing an answer to this...
Oops.. I had seen one of the revs.

We have single channel, single user system. The DSP driver and DAPM will
push messages into a queue and we will keep posting.
The framework would have helped if we had multiple channels, multiple users
but for now seems a bit heavy for our usage. Am open to revist this if
things get simplfied here. The IPC code here is least complex.

>=20
> > > > +	if (list_empty(&drv->rx_list))
> > > > +		return IRQ_HANDLED;
>=20
> > > Why would the IRQ thread be running with nothing to do, and if it can
> > > be...
>=20
> > Cant think of, we need to remove this!
>=20
> > > > +	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
> > > > +	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {
>=20
> > > ...won't we handle that gracefully anyway?
>=20
> > Are you referring to lock + irqsave?
>=20
> This is part of the thing about the list_empty() check being redundant.
Okay

> > > > +static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret =3D pm_runtime_put_sync(sst_drv->dev);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +	atomic_dec(&sst_drv->pm_usage_count);
> > > > +
> > > > +	pr_debug("%s: count is %d now..\n", __func__,
> > > > +			atomic_read(&sst_drv->pm_usage_count));
> > > > +	return 0;
> > > > +}
>=20
> > > I'm not entirely clear why this is here but if it's to provide trace
> > > just instrument the runtime PM core.
>=20
> > Well the only usage of pm_usage_count locally is to check in runtime pm
> > suspend to S3 transitions. When we are runtime suspended and S3 trigger=
s,
> > the device usage count goes up to 1. Then runtime resume and classic su=
spend
> > is invoked in that order. So if we are in this scenario we can't rely on
> > checks using frameworks count.
>=20
> Yes, you can.  You can check to see if the device is runtime suspended
> and really this isn't at all specific to this driver - it's a general
> thing that affects lots of drivers so shouldn't be open coded in this
> one.  IIRC you're looking for pm_runtime_is_suspended().
sorry didnt find the symbol, was it removed

>=20
> Essentially any time you need to use atomic variables in a driver you're
> probably doing something wrong.
No issue, i think i can clean this bit up

> > > > +static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv =
*sst_drv_ctx)
> > > > +{
> > > > +	unsigned int local;
> > > > +
> > > > +	spin_lock(&sst_drv_ctx->block_lock);
> > > > +	sst_drv_ctx->pvt_id++;
> > > > +	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
> > > > +		sst_drv_ctx->pvt_id =3D 1;
> > > > +	local =3D sst_drv_ctx->pvt_id;
> > > > +	spin_unlock(&sst_drv_ctx->block_lock);
> > > > +	return local;
> > > > +}
>=20
> > > I would expect this to be checking to see if the IDs are free but it
> > > just hands them out in sequence?  There appears to be an array of
> > > streams statically allocated, why not look there for an unused one?
>=20
> > we use these incrementally. The driver stamps each IPC to DSP with a nu=
mber.
> > The size is limited by bits in the IPCs. So we keep going till we hit m=
ax,
> > that time we set it back to 1
>=20
> > These ids are not freed or allocated as IPC latency is small enough and=
 IPCs
> > less. We haven't hot scenarios where we go complete round but IPC is st=
ill
> > pending :)
>=20
> Yet.
For this genertaion of HW :) Next gen has different interface though so not
worried :)

> > > > +int free_stream_context(unsigned int str_id)
> > > > +{
> > > > +	struct stream_info *stream;
> > > > +	int ret =3D 0;
> > > > +
> > > > +	stream =3D get_stream_info(str_id);
> > > > +	if (stream) {
>=20
> > > It's a bit scary that this might be used with an invalid ID - what
> > > happens if the ID got reallocated?
>=20
> > The free routine checks for valid ID first
>=20
> That's not the point - the point is that if you're freeing what might be
> an invalid ID I don't see any guarantee that the ID hasn't been
> allocated to something else.  It's different if there's a specific ID
> that can be used for an invalid ID but this looks like it's working
> around double frees.
The chances of that are remote as ID is unique for a FE. For first
device we will always use ID 1. The same device close will not request
again, so doble free situation shouldn't arise.

> > > > +	while (header.p.header_high.part.busy) {
> > > > +		if (loop_count > 10) {
> > > > +			pr_err("sst: Busy wait failed, cant send this msg\n");
> > > > +			retval =3D -EBUSY;
> > > > +			goto out;
> > > > +		}
> > > > +		udelay(500);
> > > > +		loop_count++;
> > > > +		header.full =3D sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> > > > +	}
>=20
> > > Throw a cpu_relax() in there if we need to spin...
>=20
> > its more busy wait for the bit to be freed. Since IPC latency is suppos=
ed to
> > be minimal checking like this helps to minimize.
>=20
> It's a udelay(500) which is pretty long for a busy wait...
ok

>=20
> > > > +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
> > > > +		list_for_each_entry_safe(listnode, tmplistnode,
> > > > +				&sst_drv_ctx->memcpy_list, memcpylist) {
> > > > +			list_del(&listnode->memcpylist);
> > > > +			kfree(listnode);
> > > > +		}
> > > > +	}
> > > > +	sst_memcpy_free_lib_resources();
> > > > +}
>=20
> > > I'm having a hard time seeing why we don't just copy the data as we go
> > > rather than allocating this list?  It seems to just be making the code
> > > more complex.
>=20
> > because we support DMA too. so common parsing and then later we either =
do
> > memcpy and dma. Will push DMA bits after this series.
>=20
> Keep it simple for now and just memcpy() directly, leaving the functions
> that select I/O vs memcpy() - you can always go back and add the DMA
> later.
well wont help to change code now and rework once this series is posted. I
have DMA patches as well, want to send them after this series :) as latency
is important.

--=20
~Vinod

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTyhDGAAoJEHwUBw8lI4NHY0IP/AvDEzJKBCAbDanyDxCzIaaH
yrr1t5FUNWx8rMBivU9MM884gvpf1cUEfih4OaqX/WvB/JoWG3ZCwhkloM2g0Pxu
CDkZ6UCUSxc/KxfTS/G8hvNfUk9qegT5HjW9UbDgn3Le2QRPk4fAx6z2eVYeZ9LL
HQjHqqFFUPscdPRCbuHDU1K7d7fc8/N10IycJlQL8jfulYt2iS2VD50TcFFk5CVK
+CNTpwQH6V/fInUHwe/G2OaLm9+wZSn5HODXz3dDZBsbYiFiYbmGDkvhf8BkHRIe
4klTb848sgsOUtOW1p1ptOXEs//legtZTm5KUSVLpN3J1FrtMER4fFtnm2jNq9o4
c1qW4qD9DvG7i7iZb7eFsKEYNsNXxYraCTg56VyY/fCnepWGy/Z4q+Ovl21WFGEf
1msfAHai/MU7b7qazLbpzsvTRdk8nyaRYa7LeUVRsT1hMfPoJkYTyMH/214ajFCH
+pqIzUBigfhwuhNrGguOApR3uKUfBC4MmBNaG+A52SNrTCgN2ufnrHmvn0l0EFZV
/kHAPX47O0kPvcm0Pk4FrmIS5SNT+c38xpjXj12o9tOcOC2QZ5bdjFZNq1Ayjbjy
JcqOOu2XFYzZZkeJyas+tUen4g8fk3sImI/EQDko+MgjhYz42nIREEL3vWyGzT9O
nXmrxdsIERMgoiueRP/N
=Ta7y
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

--===============3040736340403189731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3040736340403189731==--
