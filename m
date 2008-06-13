From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 07:11:59 -0500
Message-ID: <4852640F.8050808@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 14837244C6
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 14:12:02 +0200 (CEST)
In-Reply-To: <9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> I've been out of the loop for a few months working on something else.
> I just looked at this driver. My understanding of the fabric driver is
> different than the way you implemented it. 

Well, my fabric driver does work, so it can't be that different. :-)

> I thought the fabric driver
> would only contain the essence of code specific to the board. 

No, the fabric driver also tells ASoC how the other three drivers are 
connected.  That is, it tells ASoC "please connect SSI1 to the codec at 
address 4F, and here's the DMA information that the SSI driver needs".

> In my model a lot of the code in your fabric driver would be pushed
> into the ssi driver. So if you used ssi and a codec in the standard
> manner, the board wouldn't need a fabric driver at all. That would
> probably be the case for most AC97/HDA systems.

The SSI driver is only concerned with talking to an SSI.  I don't see 
how you could get away with no fabric driver.  That just isn't the model.

> My fabric driver contains code for hooking processor GPIOs up to the
> codec, initializing an external clock generator, etc. All of the code
> for parsing the device tree and setting up DMA is in the ssi driver.

That's how my driver *used* to be.  With ASoC V2, I chose to move some 
of that code from the SSI driver into the fabric driver.  It just makes 
more sense to me.
