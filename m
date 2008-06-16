From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 09:26:31 -0400
Message-ID: <9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id D573B245A8
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 15:26:37 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2655079ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 06:26:31 -0700 (PDT)
In-Reply-To: <1213612755.6599.51.camel@odin>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6/16/08, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Sun, 2008-06-15 at 14:10 -0400, Jon Smirl wrote:
>  > I'm trying to sort out an architecture that will let all of the code
>  > used in my ASOC drivers to be automatically loaded by the kernel.  So
>  > if I'm confused and have some of this wrong please explain where I've
>  > gone astray.
>  >
>  > First, what are the physical hardware devices present? From the device
>  > tree it says I have two i2s controllers each with an i2c controlled
>  > codec. It also says I have a system wide DMA controller. And finally
>  > there is the "fabric" which represent the specific pcb (populated
>  > jacks, etc) used by the system (the root of the device tree).
>  >
>  > Upon booting the kernel it will find the five open firmware devices
>  > (two i2s, two codecs, one DMA) and load the appropriate of drivers for
>  > them. Note that this is the system wide DMA driver, not the ASOC one.
>  > Three drivers will be loaded and five devices will be created.
>  >
> I assume your system is PPC.

Yes, similar patterns to this happen on the other platforms. They use
code in the arch directories to load their drivers instead of a device
tree.

>
>
>  > The codec devices will each register one codec and multiple codec
>  > DAIs. Each i2c channel will register a platform_dai.
>  >
>
> I also assume you mean I2S instead of I2C here ;)

yes

>
>  A codec will only register a DAI (Digital Audio Interface - I2S, PCM,
>  AC97) for each physical or logical DAI it has. i.e. the WM8750 on the
>  Sharp Tosa only has 1 physical DAI and registers only 1 DAI with the
>  core. However, the WM8753 used on the OpenMoko Neo1973 has 2 physical
>  DAIs and can also reconfigure them at runtime and hence registers 4 DAIs
>  with the core.

yes, the ones I am writing have done this

>  A platform (i.e. SoC CPU platform) will register a DAI for every DAI
>  present at DAI module load time. i.e. on pxa2xx we can register a DAI
>  for AC97, I2S and PCM (SSP).

i agree

>  > The next part, the platform device,  is where I'm having trouble. Why
>  > is the DMA subsystem in it's own ASOC device? I already have a
>  > separate system wide device for my DMA hardware.  Looking at the
>  > implementations of a couple of the ASOC DMA drivers, there is nothing
>  > global about the driver, everything is done with per channel
>  > instances.
>  >
>  > Should the DMA code instead simply be a library that is linked to by
>  > the i2s drivers? And then move the entry points registered by the DMA
>  > driver up into the platform_dai? It seems to me like implementation of
>  > the DMA code should be a private matter for the platform_dai/i2s
>  > driver. Note that I'm not saying that there shouldn't be modularized
>  > ASOC DMA code, instead, why should ASOC be aware of this shared code?
>  > To see if this model would work I tried to visualize a system where
>  > one i2s controller is using DMA and the second is doing programmed IO.
>  >
>  > So if the DMA API is pushed into the platform_dai that would free up
>  > the platform device. It could then be used to support the fabric code
>  > (fabric is the motherboard specific bits of code). It should probably
>  > be renamed to the machine device instead of platform device. To handle
>  > the case of HDA not needing a fabric driver,  ASOC would have a
>  > default internal machine driver that a fabric driver could override.
>  > This also implies that the fabric driver can't be the last driver
>  > registered with ASOC.
>
> HDA has it's own controller and codec spec and hence won't require ASoC.
>  ASoC is only for codecs and CPUs with simple DAIs i.e. I2S, PCM and
>  AC97.

I haven't worked with HDA, only i2s and ac97. So far none of the SOC
CPUs have HDA.

>  > There would be one global fabric driver, but it would get called on a
>  > per instance basis. You could implement (made up scenarios)  two amps
>  > on the motherboard and only enough power to turn one of them on. Or
>  > maybe a front panel switch that switches which channel the front panel
>  > controls act on.
>  >
>  > I'd end up with this object model
>  >
>  > generic machine (optional machine specific fabric override)
>  >     platform i2s (platform_dai, soc_snd_card)
>  >         generic codec (choice of codec dai)
>  >     platform i2s (platform_dai, soc_snd_card)
>  >         generic codec (choice of codec dai)
>  >
>  > The platform specific i2s drivers are linked to a shared library of
>  > platform DMA code.
>  >
>
>
> Ok, I think I have a good idea of what you are proposing here.
>
>  The ASoC DMA is currently very much like a library in that it exports
>  it's ALSA PCM functions to the core (by registering itself) and whilst
>  the DMA functions are not directly called by client CPU DAI drivers they
>  are indirectly called on the client DAIs behalf by the ASoC core (in
>  response to ALSA core). This means we don't have to burden our DAI
>  drivers with CPU DMA specific calls.

You're missing the part I'm have trouble with. My company has four
board models that all use the same PCB but are populated differently .
The device tree for each different population model has a different
name so the kernel can tell exactly which hardware it is running on.

I'd like to have these drivers:
codec - generic driver for my codec chip
platform_dai - in my case an i2s driver, links to a private DMA
library, this code is generic to my SOC CPU
machine(fabric) - a driver that specifically handle this board's configuration.

I'd like for the fabric driver to be dynamically loaded by the device tree.

Given the way I'm looking at the problem, the current design is
inverted. With current code the machine driver is loaded, it then in
turn registers the cpu_dai and codec. This causes all of the common
registration code to end up in the machine driver. These drivers then
get copy/pasted for all of the different machine variants.

The root of my problem is that I want to handle my four board variants
with a single kernel. So when the kernel loads, I need to figure out
which board specific code to load. In the current ASOC design it is
assumed that this code is permanently linked in as a platform driver.

I need a slightly different boot sequence.

kernel boots
of_platform drivers load - this loads the i2s driver and the codec driver
in i2s probe it looks at the device tree and loads the right
machine(fabric) driver.
asoc_register hooks everything up

The current model works like this:
kernel boots
linked in platform drivers initialize - machine(fabric) driver
of_platform drivers load - this loads the i2s driver and the codec driver
i2s probe occurs
asoc_register hooks everything up
--- the machine(fabric) driver was determined at kernel compile time.

I can't make the machine(fabric) driver in to an of_platform driver
because there is no real hardware behind it. In older threads we
discussed creating a virtual OF device for it but
nobody liked the idea.

If I keep thinking about this sooner or later I'll come up with a boot
sequence that works.


>  Fwiw, I do think platform driver could really be better named to be more
>  function specific e.g. dma driver. I'm also considering a rename of
>  machine to fabric.
>
>  We also have CPU DAIs that are shared between different CPU
>  architectures (with different DMA). e.g. i.MX31 and FSL PPC share the
>  same SSI architecture - breaking the tightly coupled library model.

Nothing I propose stops this, there just isn't any requirement that
ASOC be aware that it is happing. struct snd_pcm_ops could hang off
from the cpu_dai.

-- 
Jon Smirl
jonsmirl@gmail.com
