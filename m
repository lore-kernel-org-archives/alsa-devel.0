From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Tue, 15 May 2012 11:00:25 +0300
Message-ID: <4FB20D19.3030801@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
	<20120511130816.GB3960@opensource.wolfsonmicro.com>
	<4FAD33D3.3050104@ti.com>
	<20120511203425.GB29835@opensource.wolfsonmicro.com>
	<4FB0EEAC.6060204@ti.com>
	<20120514121127.GR31985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
	[74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DC8F24C65
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 10:00:18 +0200 (CEST)
Received: by lbjn8 with SMTP id n8so6250834lbj.14
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2012 01:00:15 -0700 (PDT)
In-Reply-To: <20120514121127.GR31985@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 05/14/2012 03:11 PM, Mark Brown wrote:
> I'm just not seeing anything in the device tree that abstracts the chip
> top level from the function drivers; if there were then it'd be very
> much easier to see a general use for this.

While we are discussing on how to handle the twl6040 MFD deive via DT
and to whether load the child drivers via DT or to load them via
mfd_add_devices() I came up with this dts entry for the later case
(mfd_add_devices mode):

&i2c1 {
	twl6040: twl@4b {
		compatible =3D "ti,twl6040";
		reg =3D <0x4b>;

		interrupts =3D <0 119 4>;
		interrupt-parent =3D <&gic>;
		twl6040,audpwron-gpio =3D <&gpio4 31 0>;

		vio-supply =3D <&v1v8>;
		v2v1-supply =3D <&v2v1>;
		enable-active-high;

		/* regulators for vibra motor */
		vddvibl-supply =3D <&vbat>;
		vddvibr-supply =3D <&vbat>;

		vibra {
			/* Vibra driver, motor resistance parameters */
			ti,vibldrv-res =3D <8>;
			ti,vibrdrv-res =3D <3>;
			ti,viblmotor-res =3D <10>;
			ti,vibrmotor-res =3D <10>;
		};
	};
};

With this mode:
No need to tell that twl6040 is acts as interrupt controller since the
interrupts it is handling is only for internal functions dispatched via
a single irq line toward the CPU.

The audio (ASoC codec) child is always enabled since it is the main
function of the twl6040.

The tricky part is the vibra: it needs two regulators (to provide power
to the motors). Since the regulators can only be connected to the device
described in dt, this is what I need to do:
to get the vibra parameters (in the twl6040-vibra driver):

struct device_node *node =3D of_find_node_by_name(
				pdev->dev.parent->of_node, "vibra");

...
of_property_read_u32(node, "ti,vibldrv-res", &info->vibldrv_res);
...

To get the regulators needed by the vibra driver when booted with DT:

info->supplies[0].supply =3D "vddvibl";
info->supplies[1].supply =3D "vddvibr";
if (!pdata)
	ret =3D regulator_bulk_get(pdev->dev.parent,
		ARRAY_SIZE(info->supplies), info->supplies);
else
	ret =3D regulator_bulk_get(info->dev,
		ARRAY_SIZE(info->supplies), info->supplies);


I need to use the pdev->dev.parent to be able to get the needed
regulators. Is this acceptable?

-- =

P=E9ter
