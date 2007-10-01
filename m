From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASOC: Best way to get private data from
	machine	driver to the other drivers?
Date: Mon, 01 Oct 2007 11:53:41 +0100
Message-ID: <1191236021.3318.41.camel@localhost.localdomain>
References: <46FD6EAA.5050801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 525E02441B
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Oct 2007 12:53:42 +0200 (CEST)
In-Reply-To: <46FD6EAA.5050801@freescale.com>
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

On Fri, 2007-09-28 at 16:14 -0500, Timur Tabi wrote:
> I'm writing an ASOC driver.  When my machine driver loads, it determines some 
> hardware information for the DMA controllers, some other hardware information 
> for the I2S controller, and even more information for the codec.
> 
> I want to be able to pass all this information to each of the three other 
> drivers.  Unfortunately, it doesn't appear that I have enough "private_data" 
> pointers available to me.
> 
> The current ASOC drivers all use statically defined global structures and 
> indexes into arrays of these structures to identify individual devices, such 
> associating I2S controller #2 with DMA channels 3 and 4.  On PowerPC, this 
> doesn't work.  The actual hardware configuration is determined at runtime (see 
> arch/powerpc/boot/dts/), and so the machine driver needs to collect all the 
> information and make all the device-to-device associations.
> 
> For example, the PCM driver has an open function:
> 
> static struct snd_pcm_ops fsl_dma_ops = {
> 	.open           = fsl_dma_open,
> 	...
> 
> static int fsl_dma_open(struct snd_pcm_substream *substream)
> {
> 	...
> 
> What I would like is for fsl_dma_open() to be able to obtain pointers to the 
> DMA controller's registers (there are two controllers with 4 channels each) by 
> looking inside 'substream'.  How can I do that?
> 

I think we have addressed this now in ASoC V2. Every component driver
now registers as a standard Linux device driver. It would probably be
possible to read the dts configuration at probe() and then configure the
driver with the correct DMA pointers before calling driver_register().

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=shortlog;h=asoc-v2-dev

Could you have a look at the V2 i.mx31 SSI driver and let me know if we
need further changes for better dts support.

Thanks

Liam
