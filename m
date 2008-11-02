From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Bug in sound-unstable-2.6 ice1724
Date: Sun, 2 Nov 2008 15:21:05 +0200
Message-ID: <200811021421.06450.fzu@wemgehoertderstaat.de>
References: <fd3eb9bf0810190236r68dc5f0bvc948acd5c6904810@mail.gmail.com>
	<200811011808.59462.fzu@wemgehoertderstaat.de>
	<s5hr65uicw5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout4.freenet.de (mout4.freenet.de [195.4.92.94])
	by alsa0.perex.cz (Postfix) with ESMTP id 0248A24366
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2008 14:21:00 +0100 (CET)
In-Reply-To: <s5hr65uicw5.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Vedran =?utf-8?q?Mileti=C4=87?= <rivanvx@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Sonntag, 2. November 2008 schrieb Takashi Iwai:
> nAt Sat, 1 Nov 2008 19:08:59 +0200,
> Karsten Wiese wrote:
> > 
> > Hi Takashi,
> > 
> > Am Sonntag, 26. Oktober 2008 schrieb Takashi Iwai:
> > > At Sun, 26 Oct 2008 17:31:02 +0100,
> > > =?UTF-8?Q?Vedran_Mileti=C4=87?= wrote:
> > > > 
> > > > Yeap, that one does it. No need to revert it fully, though. I just
> > > > uncommented the unsigned char mask line and removed that #if 0 and
> > > > #endif. Now it works perfectly. Thanks! Can you fix it in your tree?
> > > 
> > > Well, before doing that, I'd like to understand the problem more.
> > > 
> > > If the problem is about the initial IRQ mask value, setting 0 should
> > > work as well.
> > > Could you change the code just to do like below, and check whether it
> > > works?
> > > 	outb(0, ICEREG1724(ice, IRQMASK));
> > 
> > Makes a pc hang sometimes here, while reverting the entire patch is stable.
> > no midi tested though, only audio.
> 
> Hmm, that's a bad news.
> Basically my change is just to disable MPU_TX irq when unresolved irqs
> occur.  The detection was already there, but it was enabled only when
> CONFIG_SND_DEBUG.
> 
> So, the question is, whether does the hang-up happens even with the
> old code when you enable CONFIG_SND_DEBUG?
> 
> Also, a bit more detail would be appreciated -- what kind of hang-up,
> whether you get the error message, or so.

the hang happened on an always on production machine. I don't have a second
card to test with currently, nor do i like to test on that machine again ;-)

May be its just that the mask has to be applied the other way round:
I'd guess a 1 means "masked" or "not active".

> @@ -382,23 +382,25 @@ static irqreturn_t snd_vt1724_interrupt(int
> irq, void *dev_id) unsigned char status_mask =
>                 VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX |
> VT1724_IRQ_MTPCM; int handled = 0;
> -#ifdef CONFIG_SND_DEBUG
>         int timeout = 0;
> -#endif
>
>         while (1) {
>                 status = inb(ICEREG1724(ice, IRQSTAT));
>                 status &= status_mask;
>                 if (status == 0)
>                         break;
> -#ifdef CONFIG_SND_DEBUG
>                 if (++timeout > 10) {
> -                       printk(KERN_ERR
> -                              "ice1724: Too long irq loop, status = 0x%x\n",
> -                              status);
> +                       status = inb(ICEREG1724(ice, IRQSTAT));

Not necessary to read from ICEREG1724(ice, IRQSTAT) a second time here.

> +                       printk(KERN_ERR "ice1724: Too long irq loop, "
> +                              "status = 0x%x\n", status);
> +                       if (status & VT1724_IRQ_MPU_TX) {
> +                               printk(KERN_ERR "ice1724: Disabling MPU_TX\n");
> +                               outb(inb(ICEREG1724(ice, IRQMASK)) &
> +                                    ~VT1724_IRQ_MPU_TX,
  -------------------------------------^^^^^^^^^^^^^^^^^^
If I'm correct, your patch would re-activate or unmask VT1724_IRQ_MPU_TX.

> +                                    ICEREG1724(ice, IRQMASK));
> +                       }
>                         break;
>                 }
> -#endif


Thanks,
Karsten
