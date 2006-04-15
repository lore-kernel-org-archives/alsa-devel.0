From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
Date: Sat, 15 Apr 2006 20:34:07 +0100
Message-ID: <1145129647.9504.3.camel@localhost.localdomain>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <s5hvetqac7i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751293AbWDOTfI@vger.kernel.org>
In-Reply-To: <s5hvetqac7i.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-03 at 17:52 +0200, Takashi Iwai wrote:

> > +static void __exit aica_exit(void)
> > +{
> > +
> > +	if (likely(dreamcastcard->card)) {
> 
> You don't need such an optimization in this place at all.
> 
> > +		snd_aicapcm_free(dreamcastcard);
> > +		snd_card_free(dreamcastcard->card);
> > +		kfree(dreamcastcard);
> > +		if (likely(pd)) {
> > +			struct device_driver *drv = (&pd->dev)->driver;
> > +			device_release_driver(&pd->dev);
> > +			driver_unregister(drv);
> > +			platform_device_unregister(pd);
> > +		}
> 
> This should be in remove callback.
> 

What is the remove callback?
