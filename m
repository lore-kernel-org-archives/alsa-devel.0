From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Sound Blaster 4.1 problem (ens1371)
Date: Tue, 14 Jan 2003 18:51:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301141851.22286.pieter.palmers@student.kuleuven.ac.be>
References: <Pine.LNX.4.33.0301141721240.504-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0301141721240.504-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I pinned the problem down to this too...

I suppose you don't have any documentation from creative labs?

If you don't I might have a solution at hand though. I'm currently trying to 
figure out the internals of the Guillemot Maxisound ISIS card, in order to 
write an ALSA driver for it. As Guillemot is VERY reluctant to release any 
information I had to explore other means of information gathering. (I'll 
definately won't buy a guillemot product ever again, but nevertheless, I 
don't have the money to repace my ISIS)
I tried disassembling windows drivers, spying on pci register access in dos, 
etc... it gave me a lot of insight into windows/pci/driver/assembly 
internals, but not the information I wanted.
Then I came across 'bochs', which is an open-source pentium emulator (like 
VMWare). It has several features, including PCI bus simulation. It's possible 
to install a Windows98 copy inside this emulation enviroment.

What I'm now trying to do is bridging the simulated PCI bus with the real PCI 
device (in this case the ISIS). This would allow me to intercept & log the 
traffic from & to the target card made by the windows drivers, with the card 
actually responding to this IO.

And it seems to work, although there are some problems still to be adressed.
All PCI operations are functional. Windows detects & configures the card as if 
it is connected to the simulated bus. IO space operations (inb/outb & 
friends) also work. Interrupt handling should also work, but it's difficult 
to test this. I wrote a little linux device driver that intercepts the IRQ 
from the card and passes it on to the simulation enviroment. Topics that I 
still have to address are DMA transfers and memory mapped IO.

The results are quite promising, as I already capured a large part of the ISIS 
traffic on startup. But there is always a 'but'... my linux box freezes when 
booting this windows enviroment. This seems to happen at random times, and is 
quite fatal: no oops, no ctrl-alt-delete, no sysreq, nothing.
I have some ideas on the reason for this:
- The DMA transfers are set up using IO space commands and thus succeed, but 
the memory locations used as DMA source/target addresses are not 'real', i.e. 
they are the addresses as seen inside the emulation enviroment. So the card 
transfers data to locations that are in use, and the system is compromised. 
This could explain the randomness. But when examining the log files 
generated, I can't seem to find any DMA transfer setup. Maybe the system 
crashes before this setup is logged. A FIFO buffered producer-consumer 
strategy is used to log the traffic, in order not to disturb burst timing. Or 
maybe the reason lies elsewhere...
- I might have made a mistake in my linux device driver, although I used 
another kernel module as template. Can a faulty device driver totally crash 
the system?
- Maybe timing issues are causing the system to deadlock. Dunno.

Anyway, the statement I wanted to make is: maybe I can use the same approach 
to try spying on the ens1371. I already experienced that you can obtain a lot 
of info fast if you know what you're looking for.

Should you have any suggestions on how I should build/enhance the 'bridge', 
they are very welcome. I'm new to linux driver design, and kernel level code.

Regards,

Pieter Palmers
===============================
pieter.palmers@student.kuleuven.ac.be
M.Sc. µElectronics student 
@ ESAT laboratory
KULeuven, Belgium


On Tuesday 14 January 2003 17:22, you wrote:
> On Tue, 14 Jan 2003, Pieter Palmers wrote:
> > Hi,
> >
> > I own a soundblaster 4.1 and I experience the following problem: I can't
> > get the rear channel to work. There isn't even a volume control for it
> > (neither in amixer nor in alsamixer). I'm using the snd-ens1371 driver
> > that should do the job.
> >
> > The card is a basic design using a CT5880 PCI controller and a Sigmatel
> > STAC9708T codec. That's what's printed on the chips.
>
> The whole problem is, that I don't know, how we can route the signal to
> rear slots of AC'97 codec (STAC9708T). Documentation is missing.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
