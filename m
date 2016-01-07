From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [alsa-devel] [PATCH 6/6] [ALSA] portman2x4 - use new parport
 device	model
Date: Thu, 7 Jan 2016 16:14:34 +0530
Message-ID: <20160107104434.GA9809@sudip-pc>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1452150951-1571-6-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hwprlhehn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hwprlhehn.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 07, 2016 at 11:26:44AM +0100, Takashi Iwai wrote:
> On Thu, 07 Jan 2016 08:15:51 +0100,
> Sudip Mukherjee wrote:
> > 
> > Modify portman driver to use the new parallel port device model.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> Did you actually test this?

No. :(
I donot have the hardware. But since the only change is in the way it
registers with the parport so it should not break.
I was preparing v2 for this and the other one. I missed seeing some more
points.
> 
> Also about the changes:
> 
> > ---
> >  sound/drivers/portman2x4.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
> > index 5fcde7d..88b25ca 100644
> > --- a/sound/drivers/portman2x4.c
> > +++ b/sound/drivers/portman2x4.c
> > @@ -704,9 +704,10 @@ static void snd_portman_detach(struct parport *p)
> >  }
> >  
> >  static struct parport_driver portman_parport_driver = {
> > -	.name   = "portman2x4",
> > -	.attach = snd_portman_attach,
> > -	.detach = snd_portman_detach
> > +	.name		= "portman2x4",
> > +	.match_port	= snd_portman_attach,
> > +	.detach		= snd_portman_detach,
> > +	.devmodel	= true,
> >  };
> >  
> >  /*********************************************************************
> > @@ -734,6 +735,7 @@ static int snd_portman_probe(struct platform_device *pdev)
> >  	struct snd_card *card = NULL;
> >  	struct portman *pm = NULL;
> >  	int err;
> > +	struct pardev_cb portman_cb;
> >  
> >  	p = platform_get_drvdata(pdev);
> >  	platform_set_drvdata(pdev, NULL);
> > @@ -758,13 +760,15 @@ static int snd_portman_probe(struct platform_device *pdev)
> >  	sprintf(card->longname,  "%s at 0x%lx, irq %i",
> >  		card->shortname, p->base, p->irq);
> >  
> > -	pardev = parport_register_device(p,                     /* port */
> > -					 DRIVER_NAME,           /* name */
> > -					 NULL,                  /* preempt */
> > -					 NULL,                  /* wakeup */
> > -					 snd_portman_interrupt, /* ISR */
> > -					 PARPORT_DEV_EXCL,      /* flags */
> > -					 (void *)card);         /* private */
> > +	memset(&portman_cb, 0, sizeof(portman_cb));
> > +	portman_cb.private = card;                      /* private */
> > +	portman_cb.irq_func = snd_portman_interrupt;    /* ISR */
> > +	portman_cb.flags = PARPORT_DEV_EXCL;            /* flags */
> 
> You can put them initializers except for private.  Then the explicit
> memset can be omitted.
> 
> > +
> > +	pardev = parport_register_dev_model(p,		   /* port */
> > +					    DRIVER_NAME,   /* name */
> > +					    &portman_cb,   /* callbacks */
> > +					    device_count); /* device number */
> 
> Does device_count really work similarly for
> parport_register_dev_model()?  I supposed the argument being the
> device id number while you're passing the number of devices to
> create.

This device_count is actually used for the device name in
/sys/bus/parport/devices. Something like DRIVER_NAME.device_count.

Regards
Sudip
