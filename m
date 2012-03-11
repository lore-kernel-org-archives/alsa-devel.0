From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Sun, 11 Mar 2012 19:39:04 +0200
Message-ID: <1331487544.3326.27.camel@puukko.homenet-68>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
	<4F59FA9D.8070009@ti.com>
	<CANOLnOM+9M2BTXasnAUqFyYAg03LE0TD266ArYDyxfRsY26QsQ@mail.gmail.com>
	<4F5A08B3.8080705@ti.com>
	<CANOLnOPZ+bMy8FyAJ0s6QSz1NMEZjgjX_ZXDkT+dFU3q8vefgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C0A024482
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 18:36:43 +0100 (CET)
In-Reply-To: <CANOLnOPZ+bMy8FyAJ0s6QSz1NMEZjgjX_ZXDkT+dFU3q8vefgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-03-09 at 23:07 +0200, Grazvydas Ignotas wrote:
> On Fri, Mar 9, 2012 at 3:42 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > On 03/09/2012 03:25 PM, Grazvydas Ignotas wrote:
> >>> If this is a real issue in Pandora, could it be solved with adding
> >>> /etc/asound.conf to the filesystem, and limit the period size via that?
> >>
> >> We are already doing that, however we encourage people to install
> >> their own distros on pandora, and now they have to drag whole ALSA
> >> configuration for things to work. IMHO device driver like this must be
> >> able to work without any special userspace configuration.
> >
I agree. What's the use case where the problem shows up? Or actually hw
parameters in that use case so can it be repeated using plain
aplay/arecord?

> > We have two issues here:
> > if you are using the element mode (dma_op_mode) you might want to have
> > bigger period size than the FIFO size. However if you are using the
> > threshold mode you will be fine with a period size between fifo_size/2,
> > and fifo_size.
> 
> Threshold mode doesn't seem to help, I still need to go over FIFO
> size. From what I can see in the code it's setting the threshold to
> period size, so I still get underflow condition after first write, as
> first write goes to FIFO, DMA shows that it has nothing left to send
> after first write finishes.
> 
Period size smaller than FIFO size has used to work in element mode too
but I think I have always used in my tests multiple periods. What I'm
thinking if we have a boundary condition with 2-3 periods and where
buffer size is near FIFO size.

I think instead of limiting minimum period size to FIFO size we should
find that boundary condition. Like if min buffer > FIFO + 1 period or
something like that in order to keep possible to use small periods.

-- 
Jarkko
