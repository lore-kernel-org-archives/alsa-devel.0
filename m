From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Wed, 11 Sep 2002 13:32:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209112032.NAA19147@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0209110931080.607-100000@pnote.perex-int.cz>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209110931080.607-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > I've forgot to apply a next patch to intel8x0.c yesterday. Could you test
> > > it again? It should be initialized properly, but you'll see debug
> > > messages. Also, output from /proc/asound/card0/intel8x0 might help me a
> > > lot.
> >
> > That did it! It loads now, it seems to take longer than before.
> > Here's the extra debugging output:
> >
> > Sep  9 23:28:58 pc1 kernel: PCI: Setting latency timer of device 00:1f.5
> > to 64
> > Sep  9 23:29:00 pc1 kernel: ALSA
> > ../../alsa-kernel/pci/ac97/ac97_codec.c:1519: AC'97 1:0 does not respond - 
> > RESET [REC_GAIN = 0x0]
> > Sep  9 23:29:00 pc1 kernel: ALSA ../alsa-kernel/pci/intel8x0.c:1584:
> > Unable to initialize codec #0 [device = 3146496, GLOB_STA = 0xc2907cf4]
> > Sep  9 23:29:00 pc1 kernel: intel8x0: clocking to 48000
> > Sep  9 23:29:00 pc1 alsasound: Starting sound driver snd-intel8x0
> > succeeded
> >
> > And this cat /proc/asound/card0/intel8x0
> > Intel8x0
> >
> > Global control        : 0x00000002
> > Global status         : 0x00300300
> > AC'97 codecs ready    : primary secondary
>
> It seems that the second codec is MC'97 (modem codec) without audio
> capabilities. I've added the detection code for MC'97 to CVS. Could you
> try it? Thanks.

You are right, this is probably a modem (I have not yet tested
it but there is a driver out there that supposedly works -
the laptop is a Sony GRX580)

I just tried cvs and I'm getting an unresolved symbol error
on snd.o, pci_alloc_consistent

-- Fernando


-------------------------------------------------------
In remembrance
www.osdn.com/911/
