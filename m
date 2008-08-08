From: Timur Tabi <timur@freescale.com>
Subject: Re: How to report error in _pointer function?
Date: Fri, 08 Aug 2008 10:55:56 -0500
Message-ID: <489C6C8C.7020706@freescale.com>
References: <ed82fe3e0807300856q6c6daf99n224df8ae4bfe6954@mail.gmail.com>	<s5hhca7s64k.wl%tiwai@suse.de>	<489A1D9E.7040709@freescale.com>	<s5hfxpg6b65.wl%tiwai@suse.de>	<ed82fe3e0808071159k7aea218cm6184680a9c63d3d2@mail.gmail.com>
	<s5h1w0z67eq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 14EE824B29
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 18:10:09 +0200 (CEST)
In-Reply-To: <s5h1w0z67eq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> What about ltrace?  I'd like to know which functions are called.

This is an embedded system.  I don't have ltrace or strace installed.

I suspect that this problem can easily be reproduced on any system.  Just modify
the _pointer function to always return XRUN, and see what aplay does.

Anyway, I tried debugging aplay.  I'm not familiar with ALSA application
programming (just drivers), so I don't know what to look for, but I did find a
pattern.

I set a breakpoint on function snd_pcm_hw_writei(), which I presume is an
alsa-lib function.  When I run aplay, the breakpoint is hit:

Breakpoint 1, snd_pcm_hw_writei (pcm=0x10024fd8, buffer=0x100250e8, size=6000)
    at pcm_hw.c:627
627             err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi);
(gdb)

I hit continue, and then it immediately stops at this function again.  I can do
continue four more times and it does the same thing.  On the sixth "continue",
there is an 8-second delay.  Then my driver prints a message saying that it's
returning XRUN, and GDB stops again at snd_pcm_hw_writei().  I don't know what's
happening during that 8-second delay.

This whole process repeats forever.

-- 
Timur Tabi
Linux kernel developer at Freescale
