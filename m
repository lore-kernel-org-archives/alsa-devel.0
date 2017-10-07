From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to slimbus framework
Date: Sat, 7 Oct 2017 14:29:01 +0200
Message-ID: <20171007122901.rimfp6nkusj5wwy2@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171007064238.odg7ju6pvqudzf6p@latitude>
 <42030379-6dba-115b-6150-a614e72cccfc@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ljjabc7nkr4iitm7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42030379-6dba-115b-6150-a614e72cccfc@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--ljjabc7nkr4iitm7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2017 at 11:24:33AM +0100, Srinivas Kandagatla wrote:
> Thanks for the comments.
>=20
> On 07/10/17 07:42, Jonathan Neusch=C3=A4fer wrote:
> > Hi,
> >=20
> > On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.or=
g wrote:
> > > From: Sagar Dharia <sdharia@codeaurora.org>
[...]
> > > +int slim_xfer_msg(struct slim_controller *ctrl,
> > > +			struct slim_device *sbdev, struct slim_val_inf *msg,
> > > +			u8 mc)
> > > +{
> > > +	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
> > > +	struct slim_msg_txn *txn =3D &txn_stack;
> > > +	int ret;
> > > +	u16 sl, cur;
> > > +
> > > +	ret =3D slim_val_inf_sanity(ctrl, msg, mc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	sl =3D slim_slicesize(msg->num_bytes);
> > > +
> > > +	dev_dbg(&ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
> > > +		msg->start_offset, msg->num_bytes, mc, sl);
> > > +
> > > +	cur =3D slim_slicecodefromsize(sl);
> > > +	txn->ec =3D ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
> >=20
> > Shouldn't this be (cur | (1 << 3)?

I misread the code here: I thought that cur was assigned the
"compressed" message length (in the range 0..7) here, but that's not
true, as slim_slicecodefromsize returns an "uncompressed" number. Thus
cur is a "quantized"[1] version of msg->num_bytes.

> cur seems to be redundant TBH, the only difference between cur and sl is
> that the slim_slicesize() can give slice size to program for any lengths
> between 1-16 bytes. However the slim_slicecodefromsize() can only handle
> 1,2,3,4, 6,8,12,16 byte sizes.

In any case, cur is only assigned and not used, as the code currently
is.

> So we can delete slim_slicecodefromsize() call and function together.
> looks like it was a leftover from downstream.

I agree. I don't know how it *might* be used, because I haven't read the
SLIMbus spec, but it is unused here.

> > (Also, what does cur mean? Cursor? Current?)
> No Idea!! :-) it is supposed to return slice size as per number of bytes.

Another problem solved by deleting slim_slicecodefromsize :-)

(As a small side-note, I think slim_slicesize and slim_slicecodefromsize
are named backwards: I would call sl, as used above, a "slice code",
because it encodes the message length)


> > > +/*
> > > + * slim_request_val_element: change and request a given value element
>=20
> name should be fixed here..

Good catch.

> > > + * @sb: client handle requesting elemental message reads, writes.
> > > + * @msg: Input structure for start-offset, number of bytes to write.
> > > + * context: can sleep
> > > + * Returns:
> > > + * -EINVAL: Invalid parameters
> > > + * -ETIMEDOUT: If transmission of this message timed out (e.g. due t=
o bus lines
> > > + *	not being clocked or driven by controller)
> > > + * -ENOTCONN: If the transmitted message was not ACKed by destinatio=
n device.
> >=20
> > Does rbuf contain the old value after this function finishes?
> >=20
> Yep, device should send a reply value with the old value with matching ti=
d.

I think you should document this in the comment to help readers.


Thanks,
Jonathan Neusch=C3=A4fer

[1]: https://en.wikipedia.org/wiki/Quantization

--ljjabc7nkr4iitm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2MiDAAoJEAgwRJqO81/b6DAQANF3EJzO+3kQnciq6jkstSKu
IsiWx8QBdPBvWmBoUXNak71sXj41xSvDfyuDNCzFLxTPTa1/o7H/uum6tm9mmfb2
dyUpXT1shAjjZOUBggpAG3hVO2peZxq17AnF0xGNS9F++VvS33RPAlQYtA5980ar
oim1Dc3tvIzu7fG72oomh3cZYBz17dilWfOrK0FJOQpKJik2NkFZ4TnMPkqJdUm+
EzFNcmaNTGwQyg+42DKezuzSgfyEPRmZi8gQKmr9LPJDbcaEuCT4YJr1h+jbTrQN
AagGfgvquOgoUCAaMwknU7FMqscshHuADNbpGlj6a2MIMGLdgmwGC8cfH6Z8DZn+
RDTb1WHwTjQauwKaKAxjbCjZKoJWssxm1GexjCQeFkNfd72VF64LFLk6baJkcCfy
AyB1sIEPO1LqsSGzcBGcXpE8+YE+eG3sQqxWxLfu9cgHUKQ6J2luXfjTyh33+fTq
H/p+PcCZ9i0ANM+RS20YRVTmS3kR31c4/elMLrx3G96wGB+EI341huZgrUyY671f
HitUk56moEDRR3t4AWw1QA45Pmzm94PiGOL1LXf9Z3mVdMgb42125ii73dqLN/QG
u7cREFqlstZrEVea6aumFmmGuzDbv5gAveF7ZQS919ld7pdlEaCkMhwhPopajZdK
JFhBgHUbXRZ7erb93xdw
=IMIs
-----END PGP SIGNATURE-----

--ljjabc7nkr4iitm7--
