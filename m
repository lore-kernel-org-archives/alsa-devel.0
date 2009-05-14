From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 13:57:37 -0400
Message-ID: <9e4733910905141057t64c515a2n8473a26da852fdfd@mail.gmail.com>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
	<9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	<1242322832.31458.1911.camel@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D1E724484
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 19:57:39 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2589583qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 10:57:37 -0700 (PDT)
In-Reply-To: <1242322832.31458.1911.camel@finisterre>
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

On Thu, May 14, 2009 at 1:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, 2009-05-14 at 12:43 -0400, Jon Smirl wrote:
>> > My main objection is to your abuse of platform devices here - there is
>> > no need for this on non-PowerPC platforms and a platform device affects
>> > everyone. So long as you come up with a solution that does not impact
>> > other platforms I'm less worried.
>
>> This is the part you don't like?
>> +static void __init efika_declare_platform_devices(void)
>> +{
>
> That bit's OK - it's the device you've added for the CODEC which is
> concerning me.

Now I see what you mean. I need to make the codec into a device so
that I can dynamically load and find it. On PowerPC the codecs don't
have to be compiled in, they can be on an initrd. The code in
of_simple will find the right driver and get it into memory. The
platform device is what triggers the kernel to go searching for the
module on initrd.

The .name field is what lets the kernel find the module on initrd....
static struct platform_driver wm9712_driver =
{
	.probe = wm9712_probe,
	.driver = {
			.name = "wm9712",
	},
};


The i2c core just went through this same change. Previously i2c
drivers had to be compiled in. Now they can just be on initrd and
loaded on demand by the device tree.  The equivalent to of_simple for
i2c is in drivers/of/of_i2c.c. It is much smaller since more of the
support has been pushed into the i2c core.

This isn't platform specific, other platforms could implement this but
they don't have anything like a device tree telling them which modules
to load. A device tree is a probing mechanism for devices that can't
be probed.

-- 
Jon Smirl
jonsmirl@gmail.com
