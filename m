From: jayakumar alsa <jayakumar.alsa@gmail.com>
Subject: Re: [Alsa-devel] [RFC 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Date: Thu, 15 Sep 2005 20:32:28 +0800
Message-ID: <47f5dce3050915053266745a8f@mail.gmail.com>
References: <200509150904.j8F94NKP000991@localhost.localdomain>
	 <s5hk6hi8wnr.wl%tiwai@suse.de>
Reply-To: jayakumar.alsa@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964952AbVIOMce@vger.kernel.org>
In-Reply-To: <s5hk6hi8wnr.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 9/15/05, Takashi Iwai <tiwai@suse.de> wrote:
> Just small glitches I found below:

Much appreciated. Thanks for reviewing. :-)

> You can put this header filer into sound/pci/cs5535, so that it won't
> be exported.  Then you don't need __KERNEL__ check, too.

Will do.

> > +     u16 eot:1;
> > +} cs5535audio_dma_desc_t;
> 
> The bitfield isn't portable to use to comminucate with the hardware.
> Better to use u16 and normal bit operations.

I think 5535 is x86-32 specific, but you are right, I shouldn't use
bit fields. I'll convert over to masks.

> The loop with do_delay() should be replaced with more portable ones
> like msleep().

Will do.

> 
> > +{
> > +     unsigned long regdata=0;
> 
> Unnecessary initialization :)

Good catch.

> > +     cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
> 
> Let's use the new kzalloc().

Will do.

> > +     spin_lock(&cs5535au->reg_lock);
> > +     dma->ops->disable_dma(cs5535au);
> > +     dma->ops->setup_prd(cs5535au, jmpprd_addr);
> > +     spin_unlock(&cs5535au->reg_lock);
> 
> You need spin_lock_irq() here, instead.
> 

Got it. Will do.

Thanks,
jk
