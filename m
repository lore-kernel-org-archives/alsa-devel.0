From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v8 01/13] Documentation: Add SLIMbus summary
Date: Fri, 1 Dec 2017 11:27:58 +0100
Message-ID: <20171201102758.bcziygl3k46iepc6@latitude>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
 <20171130174200.6684-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7555buyfd4hlmmdc"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130174200.6684-2-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--7555buyfd4hlmmdc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, some small nits below.

On Thu, Nov 30, 2017 at 05:41:48PM +0000, srinivas.kandagatla@linaro.org wr=
ote:
> From: Sagar Dharia <sdharia@codeaurora.org>
>=20
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
>=20
> The summary of SLIMbus and API is documented in the 'summary' file.
>=20
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/driver-api/slimbus/index.rst   |  15 ++++
>  Documentation/driver-api/slimbus/summary.rst | 108 +++++++++++++++++++++=
++++++
>  2 files changed, 123 insertions(+)
>  create mode 100644 Documentation/driver-api/slimbus/index.rst
>  create mode 100644 Documentation/driver-api/slimbus/summary.rst

It would probably make sense to Cc the documentation maintainers/mailing
list on this patch (AFAICS, you didn't do that).

When do you plan to add slimbus to Documentation/driver-api/index.rst?

> diff --git a/Documentation/driver-api/slimbus/index.rst b/Documentation/d=
river-api/slimbus/index.rst
> new file mode 100644
> index 000000000000..586f979659e6
> --- /dev/null
> +++ b/Documentation/driver-api/slimbus/index.rst
> @@ -0,0 +1,15 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +SLIMbus Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   summary
> +
> +.. only::  subproject
> +
> +   Indices
> +   =3D=3D=3D=3D=3D=3D=3D
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/driver-api/slimbus/summary.rst b/Documentation=
/driver-api/slimbus/summary.rst
> new file mode 100644
> index 000000000000..ba165611725a
> --- /dev/null
> +++ b/Documentation/driver-api/slimbus/summary.rst
> @@ -0,0 +1,108 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Linux kernel SLIMbus support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +What is SLIMbus?
> +----------------
> +SLIMbus (Serial Low Power Interchip Media Bus) is a specification develo=
ped by
> +MIPI (Mobile Industry Processor Interface) alliance. The bus uses master=
/slave
> +configuration, and is a 2-wire multi-drop implementation (clock, and dat=
a).
> +
> +Currently, SLIMbus is used to interface between application processors o=
f SoCs
> +(System-on-Chip) and peripheral components (typically codec).SLIMbus uses
> +Time-Division-Multiplexing to accommodate multiple data channels, and
> +a control channel.
> +
> +The control channel is used for various control functions such as bus
> +management, configuration and status updates.These messages can be unica=
st (e.g.
                                               ^^ space after period, please

> +reading/writing device specific values), or multicast (e.g. data channel
> +reconfiguration sequence is a broadcast message announced to all devices)
> +
> +A data channel is used for data-transfer between 2 SLIMbus devices. Data
> +channel uses dedicated ports on the device.
> +
[...]
> +
> +Device notifications to the driver:
> +-----------------------------------
> +Since SLIMbus devices have mechanisms for reporting their presence, the
> +framework allows drivers to bind when corresponding devices report their
> +presence on the bus.
> +However, it is possible that the driver needs to be probed
> +first so that it can enable corresponding SLIMbus device (e.g. power it =
up and/or
> +take it out of reset). To support that behavior, the framework allows dr=
ivers
> +to probe first as well  (e.g. using standard DeviceTree compatbility fie=
ld).

Typo: s/compatbility/compatibility/

> +This creates the necessity for the driver to know when the device is fun=
ctional
> +(i.e. reported present). device_up callback is used for that reason when=
 the
> +device reports present and is assigned a logical address by the controll=
er.
> +
> +Similarly, SLIMbus devices 'report absent' when they go down. A 'device_=
down'
> +callback notifies the driver when the device reports absent and its logi=
cal
> +address assignment is invalidated by the controller.
> +
> +Another notification "boot_device" is used to notify the slim_driver when
> +controller resets the bus. This notification allows the driver to take n=
ecessary
> +steps to boot the device so that it's functional after the bus has been =
reset.
> +
> +Clock-pause:
> +------------
> +SLIMbus mandates that a reconfiguration sequence (known as clock-pause) =
be
> +broadcast to all active devices on the bus before the bus can enter low-=
power
> +mode. Controller uses this sequence when it decides to enter low-power m=
ode so
> +that corresponding clocks and/or power-rails can be turned off to save p=
ower.
> +Clock-pause is exited by waking up framer device (if controller driver i=
nitiates
> +exiting low power mode), or by toggling the data line (if a slave device=
 wants
> +to initiate it).
> +
> +Messaging APIs:
> +---------------
> +The framework supports APIs to exchange control-information with a SLIMb=
us
> +device. APIs can be synchronous or asynchronous.
> +From controller's perspective, multiple buffers can be queued to/from
> +hardware for sending/receiving data using slim_ctrl_buf circular buffer.
> +The header file <linux/slimbus.h> has more documentation about messaging=
 APIs.

Once the kerneldoc documentation (i.e. the /** ... */ comments in the
source) is included somewhere, I think it would make sense to make
slim_ctrl_buf a clickable link to the struct's documentation.


Thanks,
Jonathan Neusch=C3=A4fer

--7555buyfd4hlmmdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaIS6lAAoJEAgwRJqO81/bCmIP/iwOelNOwoOzAGuQ594zSwU4
nGEAj9COKOYCrsuRDktG3hMgTXQQ4FUCYM5Cy/oOguaaCcssLpPkJrEokNDJ0KRI
RVpSgyUdhFIq8rUcT3Z6N/ZwcJvwpScw3nlHuerP/Z6cFvwq2ErH85z7ao3TXv9l
1yGUTA/XoExqycxXCuwRG6bsdiusjQFCw8GyhlqXMrnQm5DaWXwu0Iv1jR86Scvw
vGq4cRPJj9qsKHdJX4gDyMJwQKSUsjAVMlPBg+Pd4D46zWlB1YcOu7RBWGXZR4On
uSnoIVn47hgm4/bh50+o9ypcz9RA+WZO2CGfQxAdrzyKz38l77k3hOolCxOZILhd
yefCg85rNnuGAcjk6Jhh/14gA+2kdtc86PGHRlQv9X8oKlJbcq5NUcLfecNabQc5
/QJSMRC5t254CBJu8lOXHZc2DCL1IjIUTaZdBE9bLE152jgvSPkwTCyqrlZQQKJV
/pdfnscZotStDN7vzbbyCtNayfv04MbQzm9+yGeeqt1lmM8a5CrdyXHX3sMNzg6M
v+hMw8C2YBp0iJ4yoZjED/LM4eFPiEooSz6q8O8mYl2a+lvwo6U2s9O6yq5hJEBj
omFm1ZkCzEt85O1BduMWn9HACJgH9ZMlEixOnTUn60KWaVepRVCLuM9JSc2YC7DD
kfUZ0Uw/bEobndkdCvgP
=YxQl
-----END PGP SIGNATURE-----

--7555buyfd4hlmmdc--
