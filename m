From: Timur Tabi <timur@freescale.com>
Subject: Question on snd_soc_dai_link
Date: Fri, 25 May 2007 16:55:10 -0500
Message-ID: <46575B3E.2020603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 487D12450A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 23:55:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a question about these DAI structs for ASoC.

Let's take eti_b1_wm8731.c as an example.  It contains this structure:

static struct snd_soc_dai_link eti_b1_dai = {
	.name = "WM8731",
	.stream_name = "WM8731",
	.cpu_dai = &at91_i2s_dai[1],
	.codec_dai = &wm8731_dai,
	.init = eti_b1_wm8731_init,
	.ops = &eti_b1_ops,
};

Notice that the .cpu_dai field is hard-coded to use the 2nd I2S device on the AT91.

The problem I'm having with this approach is that everything is hard-coded.  On PowerPC, 
this approach doesn't work well, because we have a "device tree" that dictates what 
devices are present on the SOC.

For a Freescale SOC that has two I2S devices (for example), both devices would be listed 
in the device tree, with the base address of the memory-mapped registers.  This means that 
a Freescale I2S driver would have its 'probe' function called (much like PCI does) each 
time the kernel processes an I2S node in the device tree.

This means that when the machine driver (which has the snd_soc_dai_link structure) loads, 
there's no guarantee that the I2S driver has also loaded and the probe functions have been 
called.  It gets even more complicated if only one I2S device has a codec connected to it, 
because then I need to kmalloc the snd_soc_cpu_dai structures and somehow tell the 
snd_soc_dai_link structure which one to use.

Has any thought been given to making these structures more dynamic and handling 
interdependencies among the drivers?  As it stands now, it looks like I'm going to have to 
hard-code everything in the drivers and break the device tree paradigm.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
