From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: Intel: sst: add power management
	handling
Date: Sat, 19 Jul 2014 12:07:13 +0530
Message-ID: <20140719063713.GJ1985@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
 <20140718114611.GM17528@sirena.org.uk>
 <20140718142309.GF1985@intel.com>
 <20140718171401.GR17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7807475715535564433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D5B8E26179C
 for <alsa-devel@alsa-project.org>; Sat, 19 Jul 2014 08:41:22 +0200 (CEST)
In-Reply-To: <20140718171401.GR17528@sirena.org.uk>
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


--===============7807475715535564433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 06:14:01PM +0100, Mark Brown wrote:
> On Fri, Jul 18, 2014 at 07:53:09PM +0530, Vinod Koul wrote:
> > On Fri, Jul 18, 2014 at 12:46:11PM +0100, Mark Brown wrote:
>=20
> > > > +	/* Move the SST state to Reset */
> > > > +	sst_set_fw_state_locked(ctx, SST_RESET);
>=20
> > > > +	flush_workqueue(ctx->post_msg_wq);
> > > > +	synchronize_irq(ctx->irq_num);
>=20
> > > This is very strange - we're flushing the work *after* resetting the =
DSP
> > > which suggests there might be something else trying to access the DSP
> > > while it is being put into reset.  Presumably that'd be bad.
>=20
> > the macro sst_set_fw_state_locked is used here :)
>=20
> > And state is marked reset, we dont do HW reset, so this is okay. After =
we return the
> > suspend handler, PCI will put the device to D3.
>=20
> It's still setting off alarm bells from a code review point of view -
> having the DSP marked as in reset may well break something that some of
> the other activity that's going on is doing.
yes that is a fair argument. But the next two calls will push any
pending messages to DSP. The reset will stop any client calls.

But then we have runtime code too, so while we are suspending that will be
waiting, so yes will move reset later.

>=20
> > > > +static int intel_sst_suspend(struct device *dev)
> > > > +{
> > > > +
> > > > +	return intel_sst_runtime_suspend(dev);
> > > > +}
>=20
> > > You currently need to check that the device isn't runtime suspended
> > > before you try to reuse runtime PM ops in suspend.
>=20
> > Sorry didnt quite get why?
>=20
> The driver should be restoring the device to the state it was in prior
> to suspend, and not repeating work that's already been done.
we dont support suspending when active. The Android usage model is that
system will not be S3 if audio is running. So no extra save work is required
here.

Moreover it needs active DSP FW support in order to save and restore, so we
cant do yet. Yes it will make sense to check device acticty and complain
loudly if we are in such a state, will add that.

--=20
~Vinod

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTyhIZAAoJEHwUBw8lI4NHbr4P/3NB/pVKWh3VVevBliCzixLs
NSZXIsMUI6oUpjqixm2UJlRqlT0vyys01At1csorY6oc8RqT49R5BCzVq0q6wb/g
h/IuRq2r9Dinghxmp0cqD6P6bQsz6b0KV232LltUH+JELy0TJE2tXMY0Mph7bCcN
KZKQK7jL/BuaQ02FyeETS3sU5XnYJX8hwbYwYCOwCP0fjuv9clhf6GWpBUsvJie9
icVYLAAKNpd/cQcRqVToTXgVIStWforgdZYMt+Amh+KHAtJafI/iOL1vsB57Hugx
cIj4w53QWYe7AV9BAgcbsLQ4qrI0mOqVo/cPH83VeVi6WISq/F9Xqlieot24hCuT
3UGsI16iV+UVMpqMFr9XfbelknzWzC3jNMkpsyS6DMWh311yPD2RRrkCMht3BDMG
tUOj92kQeXEPh+l/9vg1EeEA6Kqa9461CLouIAAOwKNQGlI6eiQa1wbc7HBsj5Vw
fOOy9W70REkE1gMOKuZELHaFnWjVN22cS69saqrUKuZ6EOhynw25VmEm0ejOnQXy
tAZahzzVFRC/6ovYn/DxmErdQjvL2LGq7neKo74iH1CjuIzhV+3A3uF398tY0fsZ
ToUuQyisPFaFOPbGEuhq73RDkWk76Qbr8qJxx2Oe3jv7faiV0szHkw1srqmhgic6
MyMnhQ62sXPB5MHeCQJw
=NuE6
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--

--===============7807475715535564433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7807475715535564433==--
