From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Wed, 19 Aug 2009 12:48:26 +0000
Message-ID: <1250686106.2060.16.camel@sl>
References: <1250677339.3516.17.camel@shinel> <s5hd46scctf.wl%tiwai@suse.de>
	<1250679571.500.20.camel@shinel>  <s5h7hx0c8l2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg76.qq.com (smtpbg76.qq.com [119.147.10.235])
	by alsa0.perex.cz (Postfix) with SMTP id 40F6224405
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 14:49:06 +0200 (CEST)
In-Reply-To: <s5h7hx0c8l2.wl%tiwai@suse.de>
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

On Wed, 2009-08-19 at 14:05 +0200, Takashi Iwai wrote:
> > 
> > But the irq last issued should be at 0x3e80, but not 0x3800 + 0x800 =
> > 0x4000. The DMA engine loaded 0x680 frame not 0x800 frame at the last
> > time.
> 
> Then it's a driver bug.  If unaligned period size is allowed, it means
> that the irq is really generated in that period, not at the buffer
> boundary.  Otherwise, it must have a proper hw-constraint to align the
> period size to the buffer size.
> 
> What hardware is it?

Yes, but there's no constraint code currently to force to align the
period size to the buffer size. The bug occurs on linux-2.6.31-rc6 on
ASoC s3c24xx platform.

The constraint to force to align the period size to the buffer size
should not be hardware depended, it shoud be done in the generic layer,
is it?

> 
> 
> thanks,
> 
> Takashi
