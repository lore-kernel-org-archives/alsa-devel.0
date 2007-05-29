From: Timur Tabi <timur@freescale.com>
Subject: Re: Question on snd_soc_dai_link
Date: Mon, 28 May 2007 20:36:52 -0500
Message-ID: <465B83B4.4000801@freescale.com>
References: <46575B3E.2020603@freescale.com>
	<1180354777.5816.39.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 152AD2434F
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 03:35:36 +0200 (CEST)
In-Reply-To: <1180354777.5816.39.camel@a10072.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

>> The problem I'm having with this approach is that everything is hard-coded.  On PowerPC, 
>> this approach doesn't work well, because we have a "device tree" that dictates what 
>> devices are present on the SOC.
> 
> Fwiw, ASoC was designed to only handle static DAI mappings between a
> codec and SoC CPU. 

On PowerPC, the mapping *is* static, but unknown until boot time.  OK, maybe that's not what you meant by static.

> This is because the audio codec was never intended to
> physically change DAI at runtime or be probed (most codecs don't support
> any device readback). The DAI mapping between CPU and codec was constant
> and always known to the machine driver.

On PowerPC, the device tree contains information about the board that cannot be obtained via probing the hardware.  Well, sometimes it contains information that *could* be obtained by probing, but that information is there only for probing.  The idea is that we can use a device tree to store device-specific information (like the I2C bus address) instead of passing command-line parameters to the device drivers.

> Although, I can now see the need for a more dynamic approach for PowerPC
> based systems. Btw, I'm not very familiar with PowerPC, would you be
> able to point me at some example "device tree" initialisation code.

All of the device trees are in arch/powerpc/boot/dts/.  A detailed description of the layout can be found in booting_without_of.txt.

In summary, the device tree is a hierarchy of "nodes", where each node lists a device (usually some controller on the SOC or some peripheral on the board), its address (e.g. the base address of the device's memory mapped registers), and a bunch of properties that the driver needs to initialize and communicate with the device.

I have not yet figured out how to represent the codec in the device tree.  In this particular case, the problem is unusual in that there is no I2C bus connected, so there's no way to control the codec, and so there's not much need for a node.
