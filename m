From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Thu, 5 Sep 2002 12:45:09 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209051237450.2123-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0209050829550.524-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209050829550.524-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > > > # alsamixer
> > > > > alsamixer: simple.c:869: simple_add1: Assertion
> > > > > `!simple->ctls[type].elem' failed.
> > > > > Aborted
> > > >
> > > > could you try to remove the assert() at alsa-lib/src/mixer/simple.c
> > > > line 869?  this looks like a wrong conditional...
> > >
> > > It's ok. Could you send us output from alsactl utility? We have probably
> > > two controls with same name.
> > 
> > Sure, it is included at the end of the email. I found the
> > same problem yesterday in an ens1371 based soundcard.
> 
> I've fixed the problem in CVS for intel8x0

Something else has changed, I now get a:

Sep  5 12:36:12 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
to 64
Sep  5 12:36:14 pc1 kernel: Intel ICH soundcard not found or device busy
Sep  5 12:36:14 pc1 insmod: 
/lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/pci/snd-intel8x0.o: 
init_module: No such device
Sep  5 12:36:14 pc1 insmod: Hint: insmod errors can be caused by incorrect 
module parameters, including invalid IO or IRQ parameters
Sep  5 12:36:14 pc1 insmod: 
/lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/pci/snd-intel8x0.o: 
insmod snd-card-0 failed

And the module does not load.

After reloading a previous version of the driver it loads successfully and
alsamixer duly reports the problem (I kept the newer lib and utils):

ALSA lib simple.c:877:(simple_add1) helem (MIXER,'Master Mono Playback 
Switch',0,0,0) appears twice or more

And this is what I get from the ens1371 card:

ALSA lib simple.c:877:(simple_add1) helem (MIXER,'IEC958 Playback 
Switch',0,0,0) appears twice or more

Let me know when I can test again...
-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
