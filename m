From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Reasonable sound hardware parameters?
Date: Mon, 28 May 2007 14:30:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705281419030.7894@tm8103.perex-int.cz>
References: <000401c7a10e$71729fe0$5457dfa0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C114A24715
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 14:30:06 +0200 (CEST)
In-Reply-To: <000401c7a10e$71729fe0$5457dfa0$@de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lorenz Kolb <alsa-dev@lkmail.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 May 2007, Lorenz Kolb wrote:

> > On Sat, 26 May 2007, Joachim F?rster wrote:
> > 
> > >
> > > First question: To implement mmap on such kind of device IO memory, 
> > > I have to use snd_pcm_lib_mmap_iomem() as mmap() callback - like it 
> > > is used in the rme32 driver, right?
> > 
> > Yes. rme32 is quite similar.
> > 
> > > Second question: Do the following parameters make sense regarding 
> > > the size of the HW ring buffer and period sizes:
> > >
> > > .buffer_bytes_max=16*1024;
> > > .period_bytes_max=8*1024;
> > > .period_bytes_min=?? resonable value ??
> > 
> > 32 or 64
> > 
> > > .periods_min=2;
> > > .periods_max=?? resonable value ??
> > 
> > 16
> > 
> > > Furthermore, the sound controller will fire an interrupt after one 
> > > period is played. Are there any arguments against these values? Any 
> > > comments?
> > 
> > Yes, I think that the access through a PCI I/O window to a PCI device 
> > is much slower than PCI DMA transfers with bursts. I would really 
> > consider to design hardware with real DMA. Of course, if it's only 
> > experimental stuff, then don't worry.

> Hi Jaroslav,
> 
> First of all: thanks for Your answer.
> Second: We do not have a PCI Bus. It is an embedded system with an OCP-Bus
> (aka OPB).
> 
> The ML403 holds a SoC with PPC and FPGA.
> 
> So the only difference between DMA with bursts and a dedicated memory (as
> far as we do see it) is the amount of time the bus gets occupied.
> With dedicated memory the system will (hopefully ;-)) do a burst write each
> period. So what happens in DMA case (except the more complex hardware as the
> DMA controller has to be written (in VHDL) as well and even more memory is
> located at an more complex bus (PLB - processor local bus): the bus will be
> occupied twice: (1) CPU writes data to memory. --> start DMA --> (2)
> Controller fetches data from memory.
> While (2) is in progress the poor CPU is "disconnected" from the bus.
> In an embedded system with a not too powerful CPU (PPC 405 @300MHz) this
> might be quite inefficient.
> Or did we miss something?

Probably not :-) I was speaking about standard PCI architecture in PC. 
Your design is quite different. Anyway, I wonder for what purpose you 
need such embedded platform with Linux? Perhaps, I'm too curious ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
