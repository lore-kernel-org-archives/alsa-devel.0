From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: isa_bus: sb8
Date: Sun, 18 Mar 2007 01:56:59 +0100
Message-ID: <20070318005659.GA10328@sygehus.dk>
References: <45E4A2F5.3080607@gmail.com> <20070317195829.GA6455@sygehus.dk>
	<45FC79A2.6080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45FC79A2.6080807@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 18, 2007 at 12:28:34AM +0100, Rene Herman wrote:
> The unfortunate thing is that autoprobe on ISA is a quite horribly bad 
> idea...
> 
> On a PCI/ISA system you need to know the IRQ and DMA channel(s) the card 
> is using _anyway_ since you need to tell the BIOS to not hand those out 
> to PCI or ISA-PnP cards (or, in the case of IRQs, even tell it to make 
> that IRQ available to ISA).

   I have one of those nearly useless AmiBIOSes in a Pentium2 box. It does
nothing for ISA-PnP cards except to print their names. I have forced it to
assign the same IRQ to all PCI cards or I would not have any left for ISA
cards, ISA-PnP or not.

   Considering that
1) there are only a few valid SB8 ports, and
2) a wrong port is detected immediately, and
3) there are only three valid DMA channels
I think an IRQ auto-probe is the most useful one of the three. You'd need an
average of 15 attempts to guess IRQ and DMA at the same time (10 possible
IRQs, 3 possible DMAs). AFAIK, autoprobing for IRQ works well in practice.

> By the way -- are you in fact using a SG NX Pro? Not a SG NX Pro 16 or 
> some other 16-bit SG? The NX Pro should have an FCCID of I38-MMSD802. If 
> you are in fact using a 16-bit SG the card's better of being used in 
> it's native WSS mode, though snd-sgalaxy.

   The FCCID is I38-SGNXPRO. According to
<URL:http://www.amitech.dk/includes/drivers/lydkort.asp>, all of
I38-SGNXPRO, I38-MMSN802 and I38-MMSD802 are SG NX Pro. The three largest
chips on the board are AZT-NXPMIX0592, AZTSSPT0592-U01 and AZTDSP31H. There
is room for a SCSI controller chip and a SCSI connector. There is a Mitsumi
CDROM interface.

-- 
Rask Ingemann Lambertsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
