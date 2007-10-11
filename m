From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: How to enforce 32bit access?
Date: Thu, 11 Oct 2007 12:29:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710111153260.13556@shell4.speakeasy.net>
References: <1191339247.30745.23.camel@localhost>
	<1191604193.5762.2.camel@localhost>
	<s5h8x6cveo5.wl%tiwai@suse.de> <1192022382.5545.9.camel@localhost>
	<s5hr6k3qf3a.wl%tiwai@suse.de> <1192030808.5545.23.camel@localhost>
	<s5hhckyqbkh.wl%tiwai@suse.de> <1192109451.25924.50.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8]) by alsa0.perex.cz (Postfix) with ESMTP id 01DCE24403
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 21:29:08 +0200 (CEST)
In-Reply-To: <1192109451.25924.50.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Foerster <mls.JOFT@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Oct 2007, Joachim Foerster wrote:
> On Thu, 2007-10-11 at 10:50 +0200, Takashi Iwai wrote:
> > The problem is that the driver still accepts the 16bit format mono
> > stream.  That's what I pointed in my previous post.  There is no
> > format conversion in alsa-lib at all.  It's only channel expansion
> > >from mono to stereo.  The hardware accepts 16bit stereo.  So, there is
> > nothing wrong from this viewpoint.
>
> By "conversion framework" I actually meant the channel expansion - code
> which somehow "works in the data" before sending it to the hardware.
>
> And yes, 16 bit samples are the only sample format supported by the
> hardware. But "by design of the hardware" the smallest write access has
> to be 32 bit wide (2 samples, stereo only)
[...]
> So, do I understand you right, when I say: an ALSA driver does _not_ hav
> ethe possibility to force alsa-lib to write 32 bit entities, only?

Joachim, it sounds like your alsa driver memory maps your device's memory
buffer?  And since this buffer is not normal system memory, it cannot be
necessarily be accessed the same way.  In this case, it only supports 32-bit
accesses.

ALSA doesn't put any requirements on a mmaped sound buffer.  I think most
hardware has the buffer in system memory and uses DMA, so there aren't any
requirements about how to access it.

Even if alsa-lib only did 32-bit accesses, any random userspace program using
mmap mode might do 16 or 8 or un-aligned or whatever.

One could add a flag to ALSA for this, SNDRV_PCM_INFO_MMAP_32BIT, that means
the mmap area must be accessed with aligned 32-bit (or more?) operations.  But
no software knows about this (yet), and it sounds like you've got the only
hardware that needs it.

You could modify your driver so that it no longer supports mmap.  You would
need to create a bounce buffer in system memory (ALSA has code for this) and
then your driver will copy from the bounce buffer into your device memory.  Of
course, this is less efficient and will have more latency.

It sounds like when alsa-lib does mono to stereo conversion, it does two 16
bit writes instead of one 32 bit.  Duplicating the 16-bit data in a register
and doing one 32 bit write should be faster.  Regardless of your deivce, this
seems like a good optimization to make.  I know modern x86 processors don't
like combining 16 and 32 bit access to the same memory; it causes partial
memory stalls.

Maybe you could make this optimization to alsa-lib, and then your device would
work well enough for your needs?
