From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 0/5] ASoC multi-component support : core
Date: Thu, 24 Jun 2010 20:24:27 +0100
Message-ID: <1277407467.3100.579.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6ECD124466
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 21:24:26 +0200 (CEST)
Received: by wyb38 with SMTP id 38so2318604wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 12:24:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, jassisinghbrar <jassisinghbrar@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Ryan Mallon <ryan@bluewatersys.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

ASoC is now coming up to it's 5th birthday and is beginning to show it's
age a little when it comes to supporting the next generation of smart
phones and multimedia devices with it's current single CODEC and single
DMA platform design.

Historically, ASoC is designed around an embedded sound card with a
single CODEC and a single platform DMA driver (with multiple DAIs). This
design works great for most of the current audio hardware in production,
however we are now seeing hardware designs for the next generation of
devices that can have many CODECs, DMAs, DSPs and a host of other audio
peripherals connected to the audio subsystem.

So we now need ASoC to support new audio hardware architectures with
multiple audio CODECs, DMA engines, DSPs, DAIs etc.
 


This patch series allows an ASoC sound card to support multiple
components (CODECs, DAI and DMA) and is the first part in a series of
work (other parts coming later in the year from Mark and I) designed to
enhance ASoC for modern mobile audio hardware.

This patch series provides the following important features:-

 1) Allow sound cards to have multiple CODECs and platform DMA controllers.
 2) Allow CODEC drivers to support more than one CODEC device.
 3) Allow all CODEC, platform DMA and DAI drivers to have platform data.

This is achieved by: -

 1) Separating the component struct driver data from the component struct device data.
 2) Making all components kernel devices.

(A side effect of this change is that we can now store all our component
private data in struct device private data (like everyone else) and
there is also now less pointer indirection for components.)

The change mainly affects only the probe() and remove() sections of
component drivers and the component enumeration section of the core. The
core also now handles setting up the CODEC data structs too (meaning
CODEC drivers dont have to do this). All component PCM, DAPM and
Kcontrol operations remain unchanged.



I've so far tested the new multi-component enumeration on the TI OMAP
and Marvell PXA platforms with AC97, MFD and I2C based CODECs. I do
however need ASoC platform maintainers to test on their systems (as I
only have a subset of the hardware). Some ASOC platforms do need a
little extra checking/fixups too :- 

 o Samsung platform: required the most work to untangle the components.
 o i.MX platform: required work to de-couple components.
 o Injenic J4740 platform: I do not have a toolchain to even build this
arch so it will also need someone to build it too.

If you find your platform does not work then the most likely reason is
that I'm missing a platform_device registration for your CODEC, DAI,
etc. device in your arch board.c or device.c files. Please let me know
or send a patch :)

All the multi-component code is in my multi-component branch here :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

This RFC post contains the changes to ASoC core only. I'll post the
multi-component CODEC and platform changes as separate RFCs in order not
to flood the list (as there are 38 patches in all). This patch series
will eventually be rebased into a single patch for upstream so we dont
break bisect. The subsequent patches for CODECs and platforms in this
series can be found in the git branch above.

The intention is to upstream this for 2.6.36

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
