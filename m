From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 18:01:39 +0000
Message-ID: <20100201180139.GC15509@sirena.org.uk>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F2E40243F3
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 19:01:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kvehmanen@eca.cx>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2010 at 11:20:25AM -0600, pl bossart wrote:

> My suggestion would be to add a 'fifo' parameter to the runtime
> structure (so that it's visible to the core), let the driver developer
> fill the value in the .open routine, and use this parameter in rewind
> to prevent rewinding too much. This parameter would include both
> hardware FIFOs and DMA buffers.

I think we want to split these concepts out a bit - with some devices
the stuff that's in the FIFO is not represented to the ALSA data
management code because it's past where the DMA controller says it's
working and trying to retrofit the data into what the DMA controller
reports gets too complicated.  I'd also expect a degree of lumpiness in
the memory regions the DMA controller is working on which it might be
useful to convey to applications.  Perhaps for the DMA we could add a
pointer for the first area the CPU can currently access safely?

For FIFO style latencies I think we'd want to allow the value reported
to be variable (since for example changes in any DSP algorithms that are
active could change the latency), and since it's not entirely joined up
with the DMA itself it might be better to just explicitly report to
applications and let them figure out what they think is a sensible way
of dealing with it.  This seems easier than trying to integrate the
information with the DMA data and more useful for latencies which we
know as actual time delays rather than buffer sizes in the hardware.
