From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Mon, 9 Sep 2002 12:53:34 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209091251510.6898-100000@cmn37.stanford.edu>
References: <s5hwupvzcop.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwupvzcop.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > > > > > # alsamixer
> > > > > > > alsamixer: simple.c:869: simple_add1: Assertion
> > > > > > > `!simple->ctls[type].elem' failed.
> > > > > > > Aborted
> > > > > >
> > > > > > could you try to remove the assert() at alsa-lib/src/mixer/simple.c
> > > > > > line 869?  this looks like a wrong conditional...
> > > > >
> > > > > It's ok. Could you send us output from alsactl utility? We have probably
> > > > > two controls with same name.
> > > > 
> > > > Sure, it is included at the end of the email. I found the
> > > > same problem yesterday in an ens1371 based soundcard.
> > > 
> > > I've fixed the problem in CVS for intel8x0
> > 
> > Something else has changed, I now get a:
> > 
> > Sep  5 12:36:12 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
> > to 64
> > Sep  5 12:36:14 pc1 kernel: Intel ICH soundcard not found or device busy
> > Sep  5 12:36:14 pc1 insmod: 
> > /lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/pci/snd-intel8x0.o: 
> > init_module: No such device
> > Sep  5 12:36:14 pc1 insmod: Hint: insmod errors can be caused by incorrect 
> > module parameters, including invalid IO or IRQ parameters
> > Sep  5 12:36:14 pc1 insmod: 
> > /lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/pci/snd-intel8x0.o: 
> > insmod snd-card-0 failed
> > 
> > And the module does not load.
> 
> could you check where the error is returned (e.g. by primitive printk's)
> ? i guess somewhere in snd_ac97_mixer in pci/ac97_codec.c, but not
> sure...

I'll try, I don't know exactly where it could be failing but I'll try to 
find out (I'll have to read a lot of code :-) The error is not 
instantaneous, it takes almost a second (maybe) to fail, there must be a 
timeout somewhere. 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
