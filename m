From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsamixer on cvs
Date: Wed, 11 Sep 2002 09:32:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209110931080.607-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0209092323320.16688-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0209092323320.16688-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Sep 2002, Fernando Pablo Lopez-Lezcano wrote:

> > > > The updated code in CVS should be more verbose. Could you try it and send 
> > > > me related lines from /var/log/messages? Thanks.
> > > 
> > > Here's the error message from the cvs version, it appears to add a little 
> > > bit more information to what I sent before:
> > > 
> > > Sep  9 20:25:57 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
> > > to 64
> > > Sep  9 20:25:58 pc1 kernel: ALSA 
> > > ../../alsa-kernel/pci/ac97/ac97_codec.c:1519: AC'97 1:0 does not respond - 
> > > RESET [REC_GAIN = 0x0]
> > > Sep  9 20:25:58 pc1 kernel: Intel ICH soundcard not found or device busy
> > 
> > I've forgot to apply a next patch to intel8x0.c yesterday. Could you test 
> > it again? It should be initialized properly, but you'll see debug messages.
> > Also, output from /proc/asound/card0/intel8x0 might help me a lot.
> 
> That did it! It loads now, it seems to take longer than before.
> Here's the extra debugging output:
> 
> Sep  9 23:28:58 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
> to 64
> Sep  9 23:29:00 pc1 kernel: ALSA 
> ../../alsa-kernel/pci/ac97/ac97_codec.c:1519: AC'97 1:0 does not respond - 
> RESET [REC_GAIN = 0x0]
> Sep  9 23:29:00 pc1 kernel: ALSA ../alsa-kernel/pci/intel8x0.c:1584: 
> Unable to initialize codec #0 [device = 3146496, GLOB_STA = 0xc2907cf4]
> Sep  9 23:29:00 pc1 kernel: intel8x0: clocking to 48000
> Sep  9 23:29:00 pc1 alsasound: Starting sound driver snd-intel8x0 
> succeeded
> 
> And this cat /proc/asound/card0/intel8x0
> Intel8x0
> 
> Global control        : 0x00000002
> Global status         : 0x00300300
> AC'97 codecs ready    : primary secondary

It seems that the second codec is MC'97 (modem codec) without audio 
capabilities. I've added the detection code for MC'97 to CVS. Could you 
try it? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
In remembrance
www.osdn.com/911/
