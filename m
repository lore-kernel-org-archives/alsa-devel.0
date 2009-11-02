From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs4236: detect chip in one pass
Date: Mon, 2 Nov 2009 22:13:06 +0100
Message-ID: <20091102221306.f95800ed.krzysztof.h1@poczta.fm>
References: <20091101165038.e3f5b0e9.krzysztof.h1@poczta.fm>
	<s5hiqdtxm6t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id C9EC8243B3
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 21:55:54 +0100 (CET)
In-Reply-To: <s5hiqdtxm6t.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, wim@djo.tudelft.nl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 02 Nov 2009 11:20:26 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 1 Nov 2009 16:50:38 +0100,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The cs4236 was two step detection with call to the snd_wss_free()
> > between two steps. The snd_wss_free() did not free a sound device
> > created in the snd_wss_create(). This caused an OOPS during module
> > removal as the same sound device was released twice. The same OOPS
> > happened if the cs4236 module loading failed.
> > 
> > Fix this by adapting the snd_cs4236_create() to correctly work with
> > chips less capable then cs4236. The snd_cs4236_create() behaves the
> > same as the snd_wss_create() if the chip is less capable than the cs4236.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > This is the second version of the patch with added snd_device_free() call
> > in error path.
> 
> Thanks.  The change looks good, but...
> 
> > @@ -281,83 +285,89 @@ int snd_cs4236_create(struct snd_card *card,
> ...
> >  	err = snd_wss_create(card, port, cport,
> >  			     irq, dma1, dma2, hardware, hwshare, &chip);
> >  	if (err < 0)
> >  		return err;
> >  
> > -	if (!(chip->hardware & WSS_HW_CS4236B_MASK)) {
> > -		snd_printk(KERN_ERR "CS4236+: MODE3 and extended registers "
> > -			   "not available, hardware=0x%x\n", chip->hardware);
> > -		snd_device_free(card, chip);
> > -		return -ENODEV;
> 
> I'd just return 0 here instead of error (with *rchip = chip, of course).
> Then the code flow gets simpler and the patch becomes smaller.
> 

These lines now inside if (CS4236B) clause. If one removes this condition, 
the CS4236B cannot be fully initialized and the CS4236 controls do not work 
(some of them require control port access).

If a driver does not want to use full capabilities of the CS4236B due to lack of 
the control port, it should force compatible codec type which does not require
the control port (e.g. CS4232).

Regards,
Krzysztof

Tanie rozmowy telefoniczne!
Sprawdz >> http://link.interia.pl/f2410
