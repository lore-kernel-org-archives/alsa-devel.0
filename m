From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: "Cannot allocate memory" problem with latest CVS
Date: Mon, 28 Oct 2002 13:21:48 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021028132148.74586.qmail@web40607.mail.yahoo.com>
References: <s5h8z0i4vgp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z0i4vgp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ouch. This means that this problem will always appear
eventually, and the only way to clear it is waiting
for Linux to free a large amount of cache memory.
<flamebait>Or I could reboot my machine.</flamebait>

In the meantime, I have no PCM playback via my
SB-Live!. Is this a 2.4 or a SB-Live limitation?

Chris

 --- Takashi Iwai <tiwai@suse.de> wrote: > Hi,
> 
> At Sun, 27 Oct 2002 18:05:41 +0000 (GMT),
> Chris Rankin wrote:
> > 
> > Hi,
> > 
> > The 'cannot allocate memory' problem has returned
> on
> > my machine:
> > 
> (snip) 
> > 
> > $ free -t
> >              total       used       free    
> shared   
> > buffers     cached
> > Mem:       1033544    1020348      13196         
> 0   
> >   30228     748684
> > -/+ buffers/cache:     241436     792108
> > Swap:       498004      10668     487336
> > Total:     1531548    1031016     500532
> > 
> > 
> > $ vmstat
> >    procs                      memory      swap    
>    
> >  io     system      cpu
> >  r  b  w   swpd   free   buff  cache   si   so   
> bi  
> >  bo   in    cs us sy id
> >  2  0  0  10668  13096  30284 748728    0    0    
> 1  
> >   3   10    14 97  3  0
> > 
> > 
> > I am using the snd-emu10k1 driver with a SB-Live!
> > card, on a 2.4.19-SMP box with 1 GB memory, so
> this
> > out-of-memory error is a bit of a mystery. Are
> there
> > any other statistics that would be useful? I
> expect
> > (hope!) that this error will disappear soon, so
> I'd
> > recommend a swift response, if required.
> 
> i guess actually your box has no free space "for the
> sb live card".
> the emu10k1 chip requires the 29bit PCI DMA mask,
> and it cannot use
> the whole 1GB memory.  hence, even if you have
> memory on the high-mem
> region, still this problem may happen.
> 
> please note that the current emu10k1 driver
> allocates pages
> dynamically at each pcm playback, while the older
> version grabbed the
> large contiguous area at the module loading time. 
> this makes the
> difference of behavior as you found before.
> 
> this problem could be solved by using
> get_free_page() with GFP_KERNEL
> (without ATOMIC) like on 2.2 kernels, since
> pci_alloc_consistent()
> uses always GFP_ATOMIC flag so that it can be called
> from interrupt
> handlers.  but it would be really a hack...
> 
> 
> Takashi 

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
