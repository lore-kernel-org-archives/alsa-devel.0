From: Eric Dantan Rzewnicki <rzewnickie@rfa.org>
Subject: Re: Re: alsa-devel@lists.sourceforge.net
Date: Mon, 2 Dec 2002 13:06:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021202180646.GB2650@rfa.org>
References: <200211212056.33194.info.mz@gmx.de> <Pine.LNX.4.44.0212020109070.1113-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212020109070.1113-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: Mark Ziegler <info.mz@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon 02/12/2002 01:14:54, Kai Vehmanen wrote:
> Sorry for the late response..
> 
> On Thu, 21 Nov 2002, Mark Ziegler wrote:
> 
> > thank you. You are right: my ide-dma is turned off. I only activated it in the 
> > SUSE setup, but I've never check if it is really switched on.
> > Unfortunately I can not turn on the dma:
> [...] 
> > linux:/home/woody # hdparm -m 8 -d 1 -u 1 -c 1 /dev/hda
> > /dev/hda:
> >  setting 32-bit IO_support flag to 1
> >  setting multcount to 8
> >  setting unmaskirq to 1 (on)
> >  setting using_dma to 1 (on)
> >  HDIO_SET_DMA failed: Operation not permitted
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
FWIW a co-worker and I have both seen this problem recently with Intel's
D845EBG2 motherboard. 845E is the chipset on the board. The ICH4 IDE
controller (82801DB I/O Controller Hub 4) is supposed to be capable of
ATA 66/100. But, with 2.4.19 and 2.4.18 we were unable to set
using_dma = 1 
When we try we get the same "Operation not permitted" error noted 
above. My co-worker has worked around it by using the 2.2.20 kernel. For 
whatever reason the 2.2.20 kernel let's him turn dma on with this 
chipset. I've chosen to stay with my old box rather than downgrade to
the 2.2 series kernel.

I know this isn't a solution, but perhaps the extra info will help
someone.

> >  multcount    =  8 (on)
> >  IO_support   =  1 (32-bit)
> >  unmaskirq    =  1 (on)
> >  using_dma    =  0 (off)
> 
> This is bad. You should check the linux-kernel archives and other 
> relevant mailing lists... hopefully some newer kernel provides dma-support 
> for your ide-chipset. This is critical for low-latency audio.
> 

-Eric Rz.


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
