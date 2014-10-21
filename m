From: Kim Taylor <kmtaylor@gmx.com>
Subject: Re: Serial MIDI driver for PL011 - as found on BCM2835
 hardware
Date: Wed, 22 Oct 2014 09:24:35 +1100
Message-ID: <1413930275.13334.19.camel@linux-host>
References: <1413847835.13334.8.camel@linux-host>
 <1413848459.13334.9.camel@linux-host> <54460930.6060603@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 99E26260681
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 00:25:36 +0200 (CEST)
In-Reply-To: <54460930.6060603@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-10-21 at 09:20 +0200, Daniel Mack wrote:
> Hi,
> 
> Thanks for sharing this!
> 
> On 10/21/2014 01:40 AM, Kim Taylor wrote:
> > I've written a driver for raw MIDI using the PL011. It is obviously
> > based on the snd-serial-u16550 module, with a couple of improvements:
> >
> >  - I've implemented a drain() callback.
> > 
> >  - I've also implemented a half duplex mode based on a timer callback
> > which was necessary for reliable communication with my eMagic Unitor 8
> > hardware. (Testing with a serial link to other hardware shows that the
> > full duplex mode is also working.)
> 
> So I guess you could patch the existing driver to make it work for your
> use case, right? I haven't looked at the code in detail, but from what
> you describe, that should be possible.

I'm not sure about that. As it uses a different UART chip, there is a
new probe() function, it uses memory mapped I/O, instead of i386
inb/outb, it gathers information from the ARM AMBA bus...

The only things that would remain unchanged are the output_trigger() and
output_write() functions. One possibility might be to abstract out all
read/write operations using function pointers, however, I believe that
the new driver is different enough to constitute a new module.

Or maybe there should be a third module (for example snd-serial-core,
containing any common functions, exporting them to both
snd-serial-u16550 and snd-serial-pl011?

> 
> > It can be found here:
> > https://github.com/kmtaylor/rpi_patches/blob/master/serial-pl011.c
> > 
> > If you think it should be included in the ALSA repository, please let me
> > know what to do next.
> 
> Clone this repository:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> 
> and integrate your changes there, then send patches to this mailing
> list. Especially if you're doing it for the first time,
> Documentation/SubmittingPatches is a good read to omit some typical
> pitfalls.

Will do. Thanks.
