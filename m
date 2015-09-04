From: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH (alsa-lib)] pcm: Modify check condition
 in snd_pcm_sw_params_set_avail_min
Date: Fri, 4 Sep 2015 10:39:54 +0800
Message-ID: <1441334394.32609.24.camel@mtksdaap41>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de> <1441266346.32609.18.camel@mtksdaap41>
 <55E8014B.8030800@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <55E8014B.8030800-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-03 at 10:14 +0200, Clemens Ladisch wrote:
> Koro Chen wrote:
> > On Thu, 2015-09-03 at 09:08 +0200, Takashi Iwai wrote:
> >> On Thu, 03 Sep 2015 05:20:54 +0200,
> >> Koro Chen wrote:
> >>> When we use a ping-ping buffer in capture, and if hw_ptr reported
> >>> at IRQ is a little smaller than period_size:
> >>>
> >>> |xxxxxxxxxxxxxxxxxxxxxxxxxxxx--|-----------------------------|
> >>>                             hw_ptr < period_size
> >>
> >> How this happens?  The period size is the size where irq (or wakeup)
> >> wakes up for read/write.  Why the driver wakes up even if there is no
> >> enough data?
> >
> > Yes it is odd to what we would normally expect. Due to our HW design,
> > when irq comes, audio HW actually has collected a full period of data,
> > but there is a buffer between the audio HW and memory, so at that moment
> > some samples are still in the buffer, not on the memory.
> 
> Please note that ALSA (both the kernel and the userspace API) requires
> that after a period interrupt, the _complete_ period has been read from/
> written to the memory buffer.  This is needed because the interrupt is
> the mechanism that synchronizes software and the DMA controller.
> (Except when using the NO_PERIOD_WAKUP flag, but you cannot rely on the
> software using it.)
> 
> 
> Typically, any buffering is done inside the DMA controller, which also
> issues interrupts, so this problem should not happen with correctly
> working hardware.
> 
> (On PCI systems, writes to system memory can be buffered, but if the
> interrupt handler does a read from a device register, the PCI memory
> ordering rules ensure that all DMA accesses started before the interrupt
> are finished before the read.)
> 
> 
> How does your hardware work?  I guess that whatever component does the
> buffering is independent of the component that generates interrupts, and
> it does not enforce any memory ordering either?  And there isn't
> a mechanism to flush the buffer?
> 
Yes, your guess is correct...our IRQ hardware is just a separated timer
which is not related to any memory control. I am not sure if there is
any way to manipulate the buffer and I will check it. Thanks for your
advice! 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
