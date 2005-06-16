From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Audigy ZS
Date: Thu, 16 Jun 2005 15:09:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506161508260.2025@pnote.perex-int.cz>
References: <200506160635.j5G6ZXfw028094@www4.pobox.sk> <42B17835.7090807@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42B17835.7090807@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Jun 2005, James Courtier-Dutton wrote:

> If you are interested, the bug is in regard of the PCMCIA Cardbus 
> section of the kernel involved in assigning IOPORT resources to the PCI bus.
> In effect, although the Audigy 2 NZ Notebook appears in "lspci", and it 
> contains valid IOPORT resources, if the driver code makes an "outb()" 
> instruction to any address in the IOPORT range, the PC hangs.

Did you try to contact pcmcia people? Maybe they will have some 
suggestions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
