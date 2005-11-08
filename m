From: R C <v4l@cerqueira.org>
Subject: Re: [Patch 1/1] V4L (926) Saa7134 alsa can only be autoloaded
	after	saa7134 is active
Date: Tue, 08 Nov 2005 12:07:50 +0000
Message-ID: <1131451671.2863.4.camel@frolic>
References: <1131397121.6632.127.camel@localhost>
	 <s5hd5lbnzg6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965006AbVKHMIb@vger.kernel.org>
In-Reply-To: <s5hd5lbnzg6.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, akpm@osdl.org, video4linux-list@redhat.com, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, nshmyrev@yandex.ru
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-11-08 at 12:36 +0100, Takashi Iwai wrote:
[...]

>   Note that "goto done" may
> require the lock again.  Also, the succeeding saa7134_dma_stop() is
> superfluous.
> 

No, it's not. dma_stop also affects the main saa7134 module, and it's
needed there.

[...]


> @@ -973,18 +963,17 @@ int alsa_card_saa7134_create (struct saa
> >  	chip->irq = saadev->pci->irq;
> >  	chip->iobase = pci_resource_start(saadev->pci, 0);
> >  
> > -	err = request_irq(chip->pci->irq, saa7134_alsa_irq,
> > +	err = request_irq(saadev->pci->irq, saa7134_alsa_irq,
> >  				SA_SHIRQ | SA_INTERRUPT, saadev->name, saadev);
> 
> Hmm, still I don't see any call of free_irq() in the driver?
> 

It was added to v4l CVS shortly after Mauro sent the last patchset,
should be sent upstream in the next patchset.
[...]


--
RC
