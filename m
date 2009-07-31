From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
Date: Fri, 31 Jul 2009 08:31:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907310831160.13462@ask.diku.dk>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
 <1248963420.16129.0.camel@johannes.local> <Pine.LNX.4.64.0907301627260.8734@ask.diku.dk>
 <s5hws5pid6u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752195AbZGaGbj@vger.kernel.org>
In-Reply-To: <s5hws5pid6u.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Jul 2009, Takashi Iwai wrote:

> At Thu, 30 Jul 2009 16:29:54 +0200 (CEST),
> Julia Lawall wrote:
> > 
> > On Thu, 30 Jul 2009, Johannes Berg wrote:
> > 
> > > On Thu, 2009-07-30 at 16:11 +0200, Julia Lawall wrote:
> > > > From: Julia Lawall <julia@diku.dk>
> > > > 
> > > > Check that the result of kzalloc is not NULL before a dereference.
> > > 
> > > >  		irq_client = kzalloc(sizeof(struct pmf_irq_client),
> > > >  				     GFP_KERNEL);
> > > > +		if (!irq_client) {
> > > > +			err = -ENOMEM;
> > > > +			printk(KERN_ERR "snd-aoa: gpio layer failed to"
> > > > +				" register %s irq (%d)\n", name, err);
> > > > +			goto out_unlock;
> > > > +		}
> > > 
> > > Looks good, thanks, but I'd really drop the printk if only to not have
> > > the string there, that doesn't really seem interesting.
> > 
> > The printk is based on similar error handling code a few lines later:
> 
> But another problem is that the same error message is reused although
> the error condition is totally different.  The kzalloc NULL isn't
> about the registration error.  So, it's rather confusing.
> 
> However, for this particular error path, I agree with Johannes; we can
> skip the error message since the error code ENOMEM is obvious.

OK, I will send a new patch.

julia
