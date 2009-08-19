From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Wed, 19 Aug 2009 18:59:31 +0800
Message-ID: <1250679571.500.20.camel@shinel>
References: <1250677339.3516.17.camel@shinel> <s5hd46scctf.wl%tiwai@suse.de>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg75.qq.com (smtpbg75.qq.com [119.147.10.234])
	by alsa0.perex.cz (Postfix) with SMTP id 5586724149
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:59:45 +0200 (CEST)
In-Reply-To: <s5hd46scctf.wl%tiwai@suse.de>
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

On Wed, 2009-08-19 at 12:34 +0200, Takashi Iwai wrote:
> At Wed, 19 Aug 2009 18:22:19 +0800,
> Shine Liu wrote:
> > 
> > There's no restriction on that the runtime->period_size should be the
> > multiplicator of the runtime->buffer_size in current kernel code.
> > 
> > So "hw_ptr_interrupt = runtime->hw_ptr_interrupt +
> > runtime->period_size;" is not always the trueth.
> 
> The hw_ptr_interrupt is the expected position where the current irq is
> issued.  So, the current code should be correct -- it's simply
> increased in the size of period_size.

Yes, the period_size and buffer_size I used was 0x800 and 0x3e80.

The log from the kernel is :

period_update: pcmC0D0p:0: pos=0x809/0x800/0x3e80, hwptr=0x1c, hw_base=0x0, hw_intr=0x0
period_update: pcmC0D0p:0: pos=0x1008/0x800/0x3e80, hwptr=0x809, hw_base=0x0, hw_intr=0x800
period_update: pcmC0D0p:0: pos=0x1808/0x800/0x3e80, hwptr=0x10e3, hw_base=0x0, hw_intr=0x1000
period_update: pcmC0D0p:0: pos=0x2006/0x800/0x3e80, hwptr=0x1808, hw_base=0x0, hw_intr=0x1800
period_update: pcmC0D0p:0: pos=0x2808/0x800/0x3e80, hwptr=0x203f, hw_base=0x0, hw_intr=0x2000
period_update: pcmC0D0p:0: pos=0x3008/0x800/0x3e80, hwptr=0x2808, hw_base=0x0, hw_intr=0x2800
period_update: pcmC0D0p:0: pos=0x3808/0x800/0x3e80, hwptr=0x30e9, hw_base=0x0, hw_intr=0x3000
period_update: pcmC0D0p:0: pos=0x8/0x800/0x3e80, hwptr=0x3808, hw_base=0x0, hw_intr=0x3800
PCM: Unexpected hw_pointer value (stream=0, pos=8, intr_ptr=16384)

It's true that irq was issued when hw_ptr_interrupt is
0x800,0x1000,0x1800,...,0x3800,0x3e80.

But the irq last issued should be at 0x3e80, but not 0x3800 + 0x800 =
0x4000. The DMA engine loaded 0x680 frame not 0x800 frame at the last
time.

In the snd_pcm_update_hw_ptr_interrupt function, hw_ptr_interrupt is
caculated simply by increased in the size of period_size, but the
runtime->period_size is not always consistent with the effective loaded
size since the last irq. For example, the DMA engine loaded 0x680 frame
when buffer reached the end at 0x3e80, and the irq issued.

> 
> > I've encounter the problem of this bug, the kernel told me "PCM:
> > Unexpected hw_pointer value (stream=0, pos=8, intr_ptr=16384)".
> > 
> > The period_size and buffer_size I used was 0x800 and 0x3e80 when the bug
> > occured.
> > 
> > Following patch will fix the bug.
> 
> Does the problem happen with the latest driver code (as found in
> sound git tree or alsa-driver-snapshot)?  If yes, we'd need more
> further analysis, e.g. by enabling some xrun_debug flags.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > Signed-off-by: Shine Liu <shinel@foxmail.com>
> > -----------------------------------------------------------------------
> > 
> > --- a/sound/core/pcm_lib.c	2009-08-14 06:43:34.000000000 +0800
> > +++ b/sound/core/pcm_lib.c	2009-08-19 17:59:00.000000000 +0800
> > @@ -248,6 +248,12 @@
> >  	hw_base = runtime->hw_ptr_base;
> >  	new_hw_ptr = hw_base + pos;
> >  	hw_ptr_interrupt = runtime->hw_ptr_interrupt + runtime->period_size;
> > +	/* if the period_size is not the multiplicator of the 
> > + 	 * buffer_size, the hw_ptr_interrupt calculated above 
> > + 	 * may not be correct, should be fixed. 
> > + 	 */
> > +	if(hw_ptr_interrupt > hw_base + runtime->buffer_size)
> > +		hw_ptr_interrupt = hw_base + runtime->buffer_size;
> >  	delta = new_hw_ptr - hw_ptr_interrupt;
> >  	if (hw_ptr_interrupt >= runtime->boundary) {
> >  		hw_ptr_interrupt -= runtime->boundary;
> > 
> > 
> > 
> 
> 
> 
