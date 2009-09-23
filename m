From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: DaVinci: Voice Codec Interface
Date: Wed, 23 Sep 2009 17:39:14 +0100
Message-ID: <20090923163914.GB31134@opensource.wolfsonmicro.com>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk>
	<4ABA3C52.6010509@ridgerun.com>
	<20090923154916.GA4257@sirena.org.uk>
	<4ABA4855.9080201@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFF1C103831
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 18:39:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ABA4855.9080201@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2009 at 10:09:57AM -0600, Miguel Aguilar wrote:
> Mark Brown wrote:

>> That'd stop you using both simultaneously but it shouldn't stop you
>> having both compiled into the kernel simultaneously.  Would it be
>> difficult to make the DMA driver do something like return -EBUSY if it
>> was started opened twice?

> [MA] But how I can tell the kernel to use one or the other one in 
> runtime?, and Why do we need to have both compiled at the same time? if 
> this is really needed What is the best way to that?

The kernel would just expose both devices to user space so the choice
would be down to the application layer.  This would give maximum
flexibility to systems, allowing them to chop and change at runtime if
they needed to for some reason (eg, using a lower quality but lower
power voice output for telephony style applications but a higer quality
higher power output for MP3 playback).  It'd also mean that for the EVM
the user would be able to use a single kernel image to evaluate both
outputs which makes life easier for things like distros.

The implementation I suggested above with returning EBUSY if the DMA is
already in use would probably work.

>> The name of the device should have no influence on the name of the clock
>> - the clock API should be able to 

> The problem is that clock name is the same as the device, by using 
> pdev->name, most of the drivers does it in this way.

The DaVinci API doesn't need that - you should be able to use a fixed
string (or even a null string) for the clock name and have the clock API
figure things out based on the struct device.  Look at how the ASP is
set up for an example.

>> I suspect that you do need a little MFD here, it sounds like all the
>> resources need to be allocated to a single device which can then dole
>> them out to the CODEC and DAI drivers.

> [MA] I haven't use MFD, can you bring me more details.

> Do you mean create just one device with the whole voice codec instead of 
> use vcif and cq0093 separately?

Sort of - see drivers/mfd for examples.  You have a device driver that
is instantiated by the platform and has all the resources allocated to
it.  It then manages allocating the resources to subdevices that do the
actual work and ensuring that the subdevices don't step on each other.

>
>>
>
>
> Thanks,
>
> Miguel Aguilar
