From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: isa_bus: sb8
Date: Sat, 17 Mar 2007 20:58:29 +0100
Message-ID: <20070317195829.GA6455@sygehus.dk>
References: <45E4A2F5.3080607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45E4A2F5.3080607@gmail.com>
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

On Tue, Feb 27, 2007 at 10:30:29PM +0100, Rene Herman wrote:
> 1. sb8 only probed for it's port, and then failed the load with "can't 
> grab irq 65535". This does away with the port autoprobe as well; if you 
> insist, I can add back irq and dma autoprobe instead as well.

   I have an Aztech Sound Galaxy NX Pro which means EEPROM instead of
jumpers for port, irq and dma configuration. Autoprobe would be nice for irq
and dma because I only know that the port is 0x220.

> However, when I tried driving an SB16 with the SB8 driver, it didn't 
> actually work. Would you happen to know/remember if this is expected? Or 
> is it a "bug"?

   IIRC, the SB16 is not SBPro compatible. Look at the Sound Blaster
Hardware Programming Guide.

-- 
Rask Ingemann Lambertsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
