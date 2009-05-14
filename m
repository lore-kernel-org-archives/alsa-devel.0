From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 14:15:17 -0400
Message-ID: <9e4733910905141115p2f682f0bwf16ae3eab5d22618@mail.gmail.com>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
	<9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	<1242322832.31458.1911.camel@finisterre>
	<9e4733910905141057t64c515a2n8473a26da852fdfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 9865224495
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 20:15:19 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1008540qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 11:15:18 -0700 (PDT)
In-Reply-To: <9e4733910905141057t64c515a2n8473a26da852fdfd@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 1:57 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Thu, May 14, 2009 at 1:40 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, 2009-05-14 at 12:43 -0400, Jon Smirl wrote:
>>> > My main objection is to your abuse of platform devices here - there is
>>> > no need for this on non-PowerPC platforms and a platform device affec=
ts
>>> > everyone. So long as you come up with a solution that does not impact
>>> > other platforms I'm less worried.
>>
>>> This is the part you don't like?
>>> +static void __init efika_declare_platform_devices(void)
>>> +{
>>
>> That bit's OK - it's the device you've added for the CODEC which is
>> concerning me.
>
> Now I see what you mean. I need to make the codec into a device so
> that I can dynamically load and find it. On PowerPC the codecs don't
> have to be compiled in, they can be on an initrd. The code in
> of_simple will find the right driver and get it into memory. The
> platform device is what triggers the kernel to go searching for the
> module on initrd.

I'm juggling too many balls. ASoC needs some more rework to make the
modules load dynamically.  The codecs need to implement .id_table.

.id_table is pretty trivial

static const struct i2c_device_id ds1682_id[] =3D {
	{ "ds1682", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, ds1682_id);

static struct i2c_driver ds1682_driver =3D {
	.driver =3D {
		.name =3D "ds1682",
	},
	.probe =3D ds1682_probe,
	.remove =3D ds1682_remove,
	.id_table =3D ds1682_id,
};


> The .name field is what lets the kernel find the module on initrd....
> static struct platform_driver wm9712_driver =3D
> {
> =A0 =A0 =A0 =A0.probe =3D wm9712_probe,
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "wm9712",
> =A0 =A0 =A0 =A0},
> };
>
>
> The i2c core just went through this same change. Previously i2c
> drivers had to be compiled in. Now they can just be on initrd and
> loaded on demand by the device tree. =A0The equivalent to of_simple for
> i2c is in drivers/of/of_i2c.c. It is much smaller since more of the
> support has been pushed into the i2c core.
>
> This isn't platform specific, other platforms could implement this but
> they don't have anything like a device tree telling them which modules
> to load. A device tree is a probing mechanism for devices that can't
> be probed.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
