From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 19:05:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 73B2B243F1
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 19:05:16 +0100 (CET)
In-Reply-To: <20100201180139.GC15509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Kai Vehmanen <kvehmanen@eca.cx>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Feb 2010, Mark Brown wrote:

> On Mon, Feb 01, 2010 at 11:20:25AM -0600, pl bossart wrote:
>
>> My suggestion would be to add a 'fifo' parameter to the runtime
>> structure (so that it's visible to the core), let the driver developer
>> fill the value in the .open routine, and use this parameter in rewind
>> to prevent rewinding too much. This parameter would include both
>> hardware FIFOs and DMA buffers.
>
> I think we want to split these concepts out a bit - with some devices
> the stuff that's in the FIFO is not represented to the ALSA data
> management code because it's past where the DMA controller says it's
> working and trying to retrofit the data into what the DMA controller
> reports gets too complicated.  I'd also expect a degree of lumpiness in
> the memory regions the DMA controller is working on which it might be
> useful to convey to applications.  Perhaps for the DMA we could add a
> pointer for the first area the CPU can currently access safely?
>
> For FIFO style latencies I think we'd want to allow the value reported
> to be variable (since for example changes in any DSP algorithms that are
> active could change the latency), and since it's not entirely joined up
> with the DMA itself it might be better to just explicitly report to
> applications and let them figure out what they think is a sensible way
> of dealing with it.  This seems easier than trying to integrate the
> information with the DMA data and more useful for latencies which we
> know as actual time delays rather than buffer sizes in the hardware.

+1 - the runtime->delay is exactly for this information (number of 
samples queued in hardware) and can be changed in the lowlevel driver at 
runtime depending on the actual hardware state.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
