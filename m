From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v7 11/13] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Thu, 23 Nov 2017 17:42:12 +0100
Message-ID: <20171123164212.655yliz3tmlpsjje@latitude>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-12-srinivas.kandagatla@linaro.org>
 <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="knjhfwnnbku77kry"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--knjhfwnnbku77kry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Srinivas and Charles,

On Thu, Nov 23, 2017 at 10:07:03AM +0000, Charles Keepax wrote:
> On Wed, Nov 15, 2017 at 02:10:41PM +0000, srinivas.kandagatla@linaro.org =
wrote:
> > From: Sagar Dharia <sdharia@codeaurora.org>
> >=20
> > This controller driver programs manager, interface, and framer
> > devices for Qualcomm's slimbus HW block.
> > Manager component currently implements logical address setting,
> > and messaging interface.
> > Interface device reports bus synchronization information, and framer
> > device clocks the bus from the time it's woken up, until clock-pause
> > is executed by the manager device.
> >=20
> > Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
[...]
> > +static void qcom_slim_rxwq(struct work_struct *work)
> > +{
> > +	u8 buf[SLIM_MSGQ_BUF_LEN];
> > +	u8 mc, mt, len;
> > +	int i, ret;
> > +	struct qcom_slim_ctrl *ctrl =3D container_of(work, struct qcom_slim_c=
trl,
> > +						 wd);
> > +
> > +	while ((slim_get_current_rxbuf(ctrl, buf)) !=3D -ENODATA) {
> > +		len =3D SLIM_HEADER_GET_RL(buf[0]);
> > +		mt =3D SLIM_HEADER_GET_MT(buf[0]);
> > +		mc =3D SLIM_HEADER_GET_MC(buf[1]);
> > +		if (mt =3D=3D SLIM_MSG_MT_CORE &&
> > +			mc =3D=3D SLIM_MSG_MC_REPORT_PRESENT) {
> > +			u8 laddr;
> > +			struct slim_eaddr ea;
> > +			u8 e_addr[6];
> > +
> > +			for (i =3D 0; i < 6; i++)
> > +				e_addr[i] =3D buf[7-i];
> > +
> > +			ea.manf_id =3D (u16)(e_addr[5] << 8) | e_addr[4];
> > +			ea.prod_code =3D (u16)(e_addr[3] << 8) | e_addr[2];
> > +			ea.dev_index =3D e_addr[1];
> > +			ea.instance =3D e_addr[0];
>=20
> If we are just bitshifting this out of the bytes does it really
> make it much more clear to reverse the byte order first? Feels
> like you might as well shift it out of buf directly.

In any case, there is a predefined function to make this code a little
nicer in <asm/byteorder.h>:

	le16_to_cpu(x):  Converts the 16-bit little endian value x to
	                 CPU-endian
	le16_to_cpup(p): Converts the 16-bit little endian value pointed
	                 to by p to CPU-endian

If you use le16_to_cpup, you need to cast your pointer to __le16 *:

	ea.manf_id =3D le16_to_cpup((__le16 *)&e_addr[4]);

Like Charles, I don't quite see the point of the for loop that fills
e_addr. I guess it did effectively a byteswap, so the original code,
that assumed little-endian, could simply dereference a u16 *. This does
not make a lot of sense anymore, once you use properly (CPU-)endian-
independent code. (Of course, you'll need to replace le16 with be16 if
you drop that loop.)


Thanks,
Jonathan Neusch=C3=A4fer

--knjhfwnnbku77kry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaFvpdAAoJEAgwRJqO81/b3PEP/RRAYO4xMTLAH105EMLGB3/J
CJL984xFxuICot4hjcKOmx+C0uy52S4O3qy5CHUJKI5/+LKMU7nOsUdkESq5ftlN
bm6s0GWY51EjWPxtlmi1dL7S5b8/VW9Y3DsRnJpDO+PyGgSucijFKqxClVnNsfIB
i4qFw9Vo719eJofbRVcQBpjoprBaSqwHG8ZAnrqjVsWFjF3/0yIohnzy6ZrgzIeZ
ZNlvtwnwKq8TmIudcWDNw3JmkipqKsQxdOXhYEJqIC/6hgJO3PMxQErKVINrIHYt
ZiHuXhs3vbXNCZx4q4uuyW1W/YdEor5WMvYLPJmWHZbSygGRnmviIhUaeio4REE1
oMjBVus815NviFLRvWRwuS1VwEvNGY+9MzpOiPxGA0DDO0xGhweTx7frbpOknqHL
EXxxp/RUhO6WcOHumviEhhKvwroqV7TXp9LfMKMPnw2mRlf/QtScZLS8ddeBESfL
TOlFfbIzUEMX4h/LzbbcgQPiRBdXUTbZ8LgVxPTTX889kzgiUn5ie2RIHy1V+hNu
eUVCwWJqu0Wc5TtYbNSDJd5Ysiuz62b4t/+MuVt8C62/CrizXdzELndLbxSPRZG4
4wb084GR2/WP35R0DTWIa33k0QXK5IiRboQEA6fHCJzE8FOrW1LY0CbAVE8slzO7
etfHmr89OMEc8+Eedrqu
=FqbW
-----END PGP SIGNATURE-----

--knjhfwnnbku77kry--
