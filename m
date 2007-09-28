From: Timur Tabi <timur@freescale.com>
Subject: ASOC: Best way to get private data from machine driver
 to the other drivers?
Date: Fri, 28 Sep 2007 16:14:18 -0500
Message-ID: <46FD6EAA.5050801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id C990924607
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 23:18:11 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8SLEIfA005068
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 14:18:10 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8SLEI32011525
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 16:14:18 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm writing an ASOC driver.  When my machine driver loads, it determines some 
hardware information for the DMA controllers, some other hardware information 
for the I2S controller, and even more information for the codec.

I want to be able to pass all this information to each of the three other 
drivers.  Unfortunately, it doesn't appear that I have enough "private_data" 
pointers available to me.

The current ASOC drivers all use statically defined global structures and 
indexes into arrays of these structures to identify individual devices, such 
associating I2S controller #2 with DMA channels 3 and 4.  On PowerPC, this 
doesn't work.  The actual hardware configuration is determined at runtime (see 
arch/powerpc/boot/dts/), and so the machine driver needs to collect all the 
information and make all the device-to-device associations.

For example, the PCM driver has an open function:

static struct snd_pcm_ops fsl_dma_ops = {
	.open           = fsl_dma_open,
	...

static int fsl_dma_open(struct snd_pcm_substream *substream)
{
	...

What I would like is for fsl_dma_open() to be able to obtain pointers to the 
DMA controller's registers (there are two controllers with 4 channels each) by 
looking inside 'substream'.  How can I do that?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
