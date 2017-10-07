From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to slimbus framework
Date: Sat, 7 Oct 2017 08:42:38 +0200
Message-ID: <20171007064238.odg7ju6pvqudzf6p@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="crs3jfjbcym3l64j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--crs3jfjbcym3l64j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Sagar Dharia <sdharia@codeaurora.org>
>=20
> Slimbus devices use value-element, and information elements to
> control device parameters (e.g. value element is used to represent
> gain for codec, information element is used to represent interrupt
> status for codec when codec interrupt fires).
> Messaging APIs are used to set/get these value and information
> elements. Slimbus specification uses 8-bit "transaction IDs" for
> messages where a read-value is anticipated. Framework uses a table
> of pointers to store those TIDs and responds back to the caller in
> O(1).
> Caller can opt to do synchronous, or asynchronous reads/writes. For
> asynchronous operations, the callback will be called from atomic
> context.
> TX and RX circular rings are used to allow queuing of multiple
> transfers per controller. Controller can choose size of these rings
> based of controller HW implementation. The buffers are coerently

s/based of/based on/
s/coerently/coherently/

> mapped so that controller can utilize DMA operations for the
> transactions without remapping every transaction buffer.
> Statically allocated rings help to improve performance by avoiding
> overhead of dynamically allocating transactions on need basis.
>=20
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Tested-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
[...]
> +static u16 slim_slicecodefromsize(u16 req)
> +{
> +	static const u8 codetosize[8] =3D {1, 2, 3, 4, 6, 8, 12, 16};
> +
> +	if (req >=3D ARRAY_SIZE(codetosize))
> +		return 0;
> +	else
> +		return codetosize[req];
> +}
> +
> +static u16 slim_slicesize(int code)
> +{
> +	static const u8 sizetocode[16] =3D {
> +		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
> +	};
> +
> +	clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
> +	return sizetocode[code - 1];
> +}
> +
> +int slim_xfer_msg(struct slim_controller *ctrl,
> +			struct slim_device *sbdev, struct slim_val_inf *msg,
> +			u8 mc)
> +{
> +	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
> +	struct slim_msg_txn *txn =3D &txn_stack;
> +	int ret;
> +	u16 sl, cur;
> +
> +	ret =3D slim_val_inf_sanity(ctrl, msg, mc);
> +	if (ret)
> +		return ret;
> +
> +	sl =3D slim_slicesize(msg->num_bytes);
> +
> +	dev_dbg(&ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
> +		msg->start_offset, msg->num_bytes, mc, sl);
> +
> +	cur =3D slim_slicecodefromsize(sl);
> +	txn->ec =3D ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));

Shouldn't this be (cur | (1 << 3)?
(Also, what does cur mean? Cursor? Current?)

> +
> +	switch (mc) {
> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
> +	case SLIM_MSG_MC_CHANGE_VALUE:
> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
> +	case SLIM_MSG_MC_CLEAR_INFORMATION:
> +		txn->rl +=3D msg->num_bytes;
> +	default:
> +		break;
> +	}
> +
> +	if (slim_tid_txn(txn->mt, txn->mc))
> +		txn->rl++;
> +
> +	return slim_processtxn(ctrl, txn);
> +}
> +EXPORT_SYMBOL_GPL(slim_xfer_msg);
[...]
> +/*
> + * slim_request_val_element: change and request a given value element
> + * @sb: client handle requesting elemental message reads, writes.
> + * @msg: Input structure for start-offset, number of bytes to write.
> + * context: can sleep
> + * Returns:
> + * -EINVAL: Invalid parameters
> + * -ETIMEDOUT: If transmission of this message timed out (e.g. due to bu=
s lines
> + *	not being clocked or driven by controller)
> + * -ENOTCONN: If the transmitted message was not ACKed by destination de=
vice.

Does rbuf contain the old value after this function finishes?

> + */
> +int slim_request_change_val_element(struct slim_device *sb,
> +					struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl =3D sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_CHANGE_VALUE);
> +}
> +EXPORT_SYMBOL_GPL(slim_request_change_val_element);
[...]
> +/**
> + * struct slim_pending: context of pending transfers
> + * @cb: callback for this transfer
> + * @ctx: contex for the callback function

s/contex/context/

> + * @need_tid: True if this transfer need Transaction ID
> + */
> +struct slim_pending {
> +	void (*cb)(void *ctx, int err);
> +	void *ctx;
> +	bool need_tid;
> +};


Thanks,
Jonathan Neusch=C3=A4fer

--crs3jfjbcym3l64j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2HdVAAoJEAgwRJqO81/bSG8P/37aVC/IOE2nyl1KA518tQrT
R4Cne+FcIb/LdljOgY1IM0b9wWScw7Lph5U8bhNaB8xh3NTGQMUcCtAfZvRdgQEV
ewnIRnsujbpboSmVhn7OIw16IMJWfhimDj7MJZf+xixq+DMDlK6XmLedy9Lo3LJk
L3D4hTS3ms2vm36K+Ai3qpt0n7il2eA53BxvzYZaFW1oQWbsf9HoSoJ1BnltKGO3
RyU4CrQSkBaS4sXz69MolCIWUofo5eDlpptCCwcYRsJmUOjPPfZrCrNn9Vl5M1v9
RKcGAGebOeRijxvOmXoWGTm/l0ZxFQVaqH25p6DP0SI5DJrS6S5WG4zAr0sF2ZK8
JW8kxTxaUTud9Y11GhgHpbag0S1HhM6HiKiOcuMwFQQZM2e3vXzqS07NzCuQDvcK
3UC5wqoWiMrcU6hJy0Uwq8R6HSBe1Py+UzWN3uy9oMg8b8HoSky/sydIMeAxJn65
CssD3AHWZgUfUqBmOsnY1mDISwjedUqjaGi3leq4KepTJBZc3rlYp4jVH2Lf7qrw
+xsdItbFz08UMURJin8FdGL5O6QxMAigvvI269a2gVMFW8amLeBAE8+OcFlkjAaF
2QxSaMGAQINTMltx2nUfI/zIfcsSIJnZioIAKIYT+ir2hKWubJUUKdwKDFJAQMKc
5Ck6pQBk/S5Mk2eI1BOw
=5OMV
-----END PGP SIGNATURE-----

--crs3jfjbcym3l64j--
