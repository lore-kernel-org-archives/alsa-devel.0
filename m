From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Sat, 7 Oct 2017 06:14:23 +0200
Message-ID: <20171007041423.4lyuygxyjgr3cp33@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="npwcmtrmabwt6p77"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-2-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--npwcmtrmabwt6p77
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I have some more or less trivial comments below.

On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wr=
ote:
> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>=20
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
> channels, and control channel. Control channel has messages to do
> device-enumeration, messages to send/receive control-data to/from
> slimbus devices, messages for port/channel management, and messages to
> do bandwidth allocation.
> The framework supports multiple instances of the bus (1 controller per
> bus), and multiple slave devices per controller.
>=20
> This patch does device enumeration, logical address assignment,
> informing device when the device reports present/absent etc.
> Reporting present may need the driver to do the needful (e.g. turning
> on voltage regulators powering the device). Additionally device is
> probed when it reports present if that device doesn't need any such
> steps mentioned above.
>=20
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
[...]
> +SLIMbus example for Qualcomm's slimbus manager component:
> +
> +	slim@28080000 {
> +		compatible =3D "qcom,slim-msm";
> +		reg =3D <0x28080000 0x2000>,
> +		interrupts =3D <0 33 0>;
> +		clocks =3D <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names =3D "iface_clk", "core_clk";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <0>;
> +
> +		codec: wcd9310@1{
> +			compatible =3D "slim217,60"";
			                        ^ spurious quote?

> +			reg =3D <1 0>;
> +		};
> +	};
> diff --git a/Documentation/slimbus/summary b/Documentation/slimbus/summary
> new file mode 100644
> index 0000000..e7f90bb
> --- /dev/null
> +++ b/Documentation/slimbus/summary

Should this file have a .rst extension, like other Restructured Text
files?

> @@ -0,0 +1,109 @@
> +Overview of Linux kernel SLIMbus support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[...]
> +Device notifications to the driver:
> +-----------------------------------
> +Since SLIMbus devices have mechanisms for reporting their presence, the
> +framework allows drivers to bind when corresponding devices report their
> +presence on the bus.
> +However, it is possible that the driver needs to be probed
> +first so that it can enable corresponding SLIMbus devie (e.g. power it u=
p and/or

s/devie/device/ I guess

> +take it out of reset). To support that behavior, the framework allows dr=
ivers
> +to probe first as well  (e.g. using standard DeviceTree compatbility fie=
ld).
> +This creates the necessity for the driver to know when the device is fun=
ctional
> +(i.e. reported present). device_up callback is used for that reason when=
 the
> +device reports present and is assigned a logical address by the controll=
er.
[...]
> +/**
> + * struct slim_addrt: slimbus address used internally by the slimbus fra=
mework.
> + * @valid: If the device is present. Valid is set to false when device r=
eports
> + *	absent.
> + * @eaddr: Enumeration address
> + * @laddr: It is possible that controller will set a predefined logical =
address
> + *	rather than the one assigned by framework. (i.e. logical address may
> + *	not be same as index into this table). This entry will store the
> + *	logical address value for this enumeration address.
> + */
> +struct slim_addrt {
> +	bool			valid;
> +	struct slim_eaddr	eaddr;
> +	u8			laddr;
> +};

I wonder if valid should be moved after eaddr, to reduce the need for
padding. AFAICS, struct slim_eaddr is 6 bytes long and requires 2-byte
alignment, so if valid is one byte long, there would be one byte of
padding after it, slightly bloating struct slim_addrt, unnecessarily.

> +/**
> + * struct slim_controller: Controls every instance of SLIMbus
> + *				(similar to 'master' on SPI)
> + *	'Manager device' is responsible for  device management, bandwidth
> + *	allocation, channel setup, and port associations per channel.
> + *	Device management means Logical address assignment/removal based on
> + *	enumeration (report-present, report-absent) if a device.

s/if a device/of a device/ ?

> + *	Bandwidth allocation is done dynamically by the manager based on acti=
ve
> + *	channels on the bus, message-bandwidth requests made by slimbus devic=
es.
> + *	Based on current bandwidth usage, manager chooses a frequency to run
> + *	the bus at (in steps of 'clock-gear', 1 through 10, each clock gear
> + *	representing twice the frequency than the previous gear).
> + *	Manager is also responsible for entering (and exiting) low-power-mode
> + *	(known as 'clock pause').
> + *	Manager can do handover of framer if there are multiple framers on the
> + *	bus and a certain usecase warrants using certain framer to avoid keep=
ing
> + *	previous framer being powered-on.
> + *
> + *	Controller here performs duties of the manager device, and 'interface
> + *	device'. Interface device is responsible for monitoring the bus and
> + *	reporting information such as loss-of-synchronization, data
> + *	slot-collision.
> + * @dev: Device interface to this driver
> + * @nr: Board-specific number identifier for this controller/bus
> + * @list: Link with other slimbus controllers

I don't see list in the struct.

> + * @name: Name for this controller
> + * @min_cg: Minimum clock gear supported by this controller (default val=
ue: 1)
> + * @max_cg: Maximum clock gear supported by this controller (default val=
ue: 10)
> + * @clkgear: Current clock gear in which this bus is running
> + * @a_framer: Active framer which is clocking the bus managed by this co=
ntroller
> + * @m_ctrl: Mutex protecting controller data structures
> + * @addrt: Logical address table
> + * @num_dev: Number of active slimbus slaves on this bus
> + * @wq: Workqueue per controller used to notify devices when they report=
 present
> + * @xfer_msg: Transfer a message on this controller (this can be a broad=
cast
> + *	control/status message like data channel setup, or a unicast message
> + *	like value element read/write.

I don't see xfer_msg in the struct.

> + * @set_laddr: Setup logical address at laddr for the slave with element=
al
> + *	address e_addr. Drivers implementing controller will be expected to
> + *	send unicast message to this device with its logical address.
> + * @get_laddr: It is possible that controller needs to set fixed logical
> + *	address table and get_laddr can be used in that case so that controll=
er
> + *	can do this assignment.
> + */
> +struct slim_controller {
> +	struct device		dev;
> +	unsigned int		nr;
> +	char			name[SLIMBUS_NAME_SIZE];
> +	int			min_cg;
> +	int			max_cg;
> +	int			clkgear;
> +	struct slim_framer	*a_framer;
> +	struct mutex		m_ctrl;
> +	struct slim_addrt	*addrt;
> +	u8			num_dev;
> +	struct workqueue_struct *wq;
> +	int			(*set_laddr)(struct slim_controller *ctrl,
> +					     struct slim_eaddr *ea, u8 laddr);
> +	int			(*get_laddr)(struct slim_controller *ctrl,
> +					     struct slim_eaddr *ea, u8 *laddr);
> +};


Thanks,
Jonathan Neusch=C3=A4fer

--npwcmtrmabwt6p77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2FSWAAoJEAgwRJqO81/btRYQAI06yzV6oMfXX/x6mR/yjY0U
A8eGRkoZ0zC2bP3EX45R1Ch1wkybpWD9DOjlz30gS3ckDu30vv5KMAt4aP9jwnIl
Tl7W6vVhRCdxpCNqiqtnXeiLJv5RyKJ1sNRhC5DW7Hazz0mMvNg88DEitm7drge/
TgLnJ0jVS6hvUyTBiWn0geoyYXEBblu/DuhwAw5F/CFj9wrNaoNCOxiDUF97R0Nk
0CHnbR3Mm5rzi8qxlUS7P82jeTijRm2gEBr077WP5WSp6p/hc13s+3GG94JsQHPl
HQx83KDzuq/Z/Fnd4xp1ZbFjLXCO0WrH7F7PI8diYW7aEQTfw1VwOGl7jjYrSj3E
khZNcTD6suP2A8P0GFB5PJ37l2Hc7ci6wn4YSH+l2fZVTHe4azVKYBBLbRDNhvtK
7SjuF/zZwIoJ9oJrR+NCH6sMCyvltISy6KhjjFmAp3Sy8vvtR+2BQznClEl4G25Y
/g8lVrLhbol8qDltP+pdIabHTZnHVRIbE7Afn3s901qKqlV4HSvTdTf6QBE4LPlf
4FRhzZbXVu4UiJv34EDmrk0xCCO/ki2r0tU8ck2Ov+Ai8LZS77kuLWG2pU3uid48
c6BUJXAO1zIa4pvPBbdY4kcmMdoJ9Z4vADxft6xHM3sJYq6w52Y/rjBgnFvGee3Z
bKiUc0JD8o2MtHvm8ZU0
=Agp/
-----END PGP SIGNATURE-----

--npwcmtrmabwt6p77--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
