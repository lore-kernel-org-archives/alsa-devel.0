From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Question on snd_soc_dai_link
Date: Tue, 29 May 2007 15:19:16 +0100
Message-ID: <1180448356.5816.145.camel@a10072.wolfsonmicro.main>
References: <46575B3E.2020603@freescale.com>
	<1180354777.5816.39.camel@a10072.wolfsonmicro.main>
	<465B83B4.4000801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EE5A24388
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 16:19:18 +0200 (CEST)
In-Reply-To: <465B83B4.4000801@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-05-28 at 20:36 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> >> The problem I'm having with this approach is that everything is hard-coded.  On PowerPC, 
> >> this approach doesn't work well, because we have a "device tree" that dictates what 
> >> devices are present on the SOC.
> > 
> > Fwiw, ASoC was designed to only handle static DAI mappings between a
> > codec and SoC CPU. 
> 
> On PowerPC, the mapping *is* static, but unknown until boot time.  OK, maybe that's not what you meant by static.
> 
> > This is because the audio codec was never intended to
> > physically change DAI at runtime or be probed (most codecs don't support
> > any device readback). The DAI mapping between CPU and codec was constant
> > and always known to the machine driver.
> 
> On PowerPC, the device tree contains information about the board that cannot be obtained via probing the hardware.  Well, sometimes it contains information that *could* be obtained by probing, but that information is there only for probing.  The idea is that we can use a device tree to store device-specific information (like the I2C bus address) instead of passing command-line parameters to the device drivers.
> 
> > Although, I can now see the need for a more dynamic approach for PowerPC
> > based systems. Btw, I'm not very familiar with PowerPC, would you be
> > able to point me at some example "device tree" initialisation code.
> 
> All of the device trees are in arch/powerpc/boot/dts/.  A detailed description of the layout can be found in booting_without_of.txt.
> 
> In summary, the device tree is a hierarchy of "nodes", where each node lists a device (usually some controller on the SOC or some peripheral on the board), its address (e.g. the base address of the device's memory mapped registers), and a bunch of properties that the driver needs to initialize and communicate with the device.
> 
> I have not yet figured out how to represent the codec in the device tree.  In this particular case, the problem is unusual in that there is no I2C bus connected, so there's no way to control the codec, and so there's not much need for a node.

Ok, I now think I can see now how the PowerPC tree structure defines the
machine. If my understanding is correct, I think it may be possible to
parse the tree and build the DAI mappings and sound configuration at
init, although this may require some device-type additions:-

e.g.

sound-dev@0 {
	device-type = "asoc-sound";
	dai-link@0 {
		device-type = "audio-interface";
		i2s@2400 {		// PSC3
			device_type = "i2s-dai"; // I2S digital audio interface	
			compatible = "mpc5200-psc-i2s";
			cell-index = <2>; // i2s port 3
			reg = <2400 100>;
		};
		codec@0 {
			device_type = "codec";
			compatible = "codec name"; // e.g. WM8731
			i2c_addr = <34>;
		};
	};
	asoc-platform@xxxx {
		device-type = "audio-dma";
		compatible = "&mpc5200_dma";
	};
	asoc-machine@xxxx {
		device-type = "sound";
		compaitble = "machine name";
		interrupts = <2 3 0>;
		interrupt-parent = <&mpc5200_pic>;
	};
};

This maps the WM8731 codec to an imaginary PowerPC 5200 based machine
using PSC3 for I2S audio. It would be preferable to only probe the
parent device and not the children, although I'm not sure if this is
possible using this model. ASoC works on other SoC by being a platform
device.

Please let me know if I'm way off here. The device tree looks like an
elegant solution for machine initialisation/description.

Liam
