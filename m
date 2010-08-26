From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Thu, 26 Aug 2010 19:52:26 +0100
Message-ID: <20100826185226.GC24381@opensource.wolfsonmicro.com>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
	<20100826124757.GC5721@sirena.org.uk>
	<AANLkTinY5mcCPKEJcm+Yru-+7U+nEWe+VaWL558UhhrB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D925103841
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 20:52:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinY5mcCPKEJcm+Yru-+7U+nEWe+VaWL558UhhrB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: Mike Frysinger <vapier@gentoo.org>, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 26, 2010 at 02:06:43PM -0400, Adam Rosenberg wrote:

> Thank you for the reply.  I emailed Barry Song on July 30th to request some
> help moving to the new ASoC standards but received no response.

Please don't top post, and remember to include context in your reply so
people can understand the context of your message0.  This is standard
for Linux kernel mailing lists.

> I have not entered any constraints into the driver because there really
> should be no need.  The driver just copies whatever PCM data that is
> provided directly to the DMA buffer.  It seems that the problem occurs
> because the location to copy to is based on the pos suggested by the
> callback function.  I am still finding it difficult to tell how ALSA decides
> there is an underrun or overrun.  I am definitely trying to read or write
> the pcm data fast enough but it seems as though I get these errors anyway.

I've no idea what "the callback function" is?  As far as determining
the overrun and underrun conditions goes the source is available -
obviously and overrun is where you try to write more data than there's
space for and an underrun is when the hardware runs out of data.

This can either mean that the driver is reporting that data is being
consumed at the wrong rate (possibly as a result of hardware
misconfiguration resulting in a misunderstanding about the format of
incoming data, or misconfiguration of clocks) or it can mean that the
application is getting confused.

> Questions:
> 1.  How do I implement an ASoC-style driver that supports multiple chips
> when they are connected to the same SPORT but use different SPI chip
> selects?

Look at current ASoC in -next, I've never tried this multi drop DAI
setup directly myself but it does support multiple CODECs in the system.

> 2.  How do I define the proper buffer/period size constraints or should I
> ignore the suggested position during copy operations and just keep track of
> the position within the DMA buffer myself?

Your constraints will flow from the requirements of the hardware plus
any additional requirements that the driver you've written imposes.  For
example, if you always need a period of data ready to start DMA on which
the application can't touch for coherency reasons then you need to make
sure that there's at least three periods (running, about to run and
updatable), or if your hardware DMAs in blocks you need a minimum period
size for that.

> 3.  Can you suggest a good way to debug underrun/overrun problems?

There's a few settings for XRUN detection diagnostics in the ALSA core
code which can be useful - see pcm_lib.c and the SND_PCM_XRUN_DEBUG
config option.
