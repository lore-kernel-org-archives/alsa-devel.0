From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy ZS
Date: Thu, 16 Jun 2005 14:01:41 +0100
Message-ID: <42B17835.7090807@superbug.co.uk>
References: <200506160635.j5G6ZXfw028094@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506160635.j5G6ZXfw028094@www4.pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: tmintel@gmail.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Zubaj wrote:

>Hi,
>
>Audigy 2 ZS Notebook is not supported.
>
>AFAIK no one from developers has this card. No doc. This means nobody
>tryed to write driver for it, and probably nobody will try to write
>driver. 
>
>Peter Zubaj
>  
>

This is not exactly true. I have updated the ALSA sound card matrix.

I (an ALSA developer) have received a Audigy 2 ZS Notebook PCMCIA card 
from Creative for the purposes or writing a drive for Linux.
I have run up against a bug in the Linux kernel PCMCIA code that I 
cannot fix. So effectively, until the PCMCIA code is fixed, the ALSA 
development cannot start.
Unfortunately, the PCMCIA standards are not open and free, so I also 
cannot provide any sensible suggestions on how to fix the PCMCIA code.

If you are interested, the bug is in regard of the PCMCIA Cardbus 
section of the kernel involved in assigning IOPORT resources to the PCI bus.
In effect, although the Audigy 2 NZ Notebook appears in "lspci", and it 
contains valid IOPORT resources, if the driver code makes an "outb()" 
instruction to any address in the IOPORT range, the PC hangs.

James



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
