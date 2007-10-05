From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC v2 on PowerPC
Date: Fri, 05 Oct 2007 12:07:57 +0100
Message-ID: <1191582477.12060.243.camel@localhost.localdomain>
References: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 07978244A1
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Oct 2007 13:07:59 +0200 (CEST)
In-Reply-To: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-10-04 at 13:12 -0400, Jon Smirl wrote:
> I'm looking into write a ASoC v2 driver for the Efika. Efika uses a
> Freescale MPC5200B and a STAC9766. This is a practice driver before
> writing one for our target hardware (which doesn't work yet, same CPU
> but different codec).
> 
> I've brought the changes from wolfson/asoc-v2-dev into my powerpc tree
> and got a couple of config errors with ARCH=powerpc.
> 
> sound/soc/pxa/Kconfig:23:warning: 'select' used by config symbol
> 'SND_PXA2XX_SOC_SSP' refers to undefined symbol 'PXA_SSP'
> sound/soc/au1x/Kconfig:35:warning: 'select' used by config symbol
> 'SND_SOC_EXM1200_SSI' refers to undefined symbol 'SND_SOC_CS4251X'
> 

Thanks, I'll fix this.

> Suggestions on the best way to start? Target hardware also has a WM8804 on it.
> 

A good place to start would be looking at the other supported
architectures and codecs and see what fits in best with your target SoC
CPU. Fwiw, Timur Tabi has some working PPC code, although I'm not sure
if it will work on Efika.

I usually start with the I2S driver and the codec in slave mode. Then
move onto the DMA when I see the I2S bits toggling correctly. After the
DMA is up and running I can complete the codec and I2S drivers.

Liam
