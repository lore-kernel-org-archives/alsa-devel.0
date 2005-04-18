From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: HW mix
Date: Mon, 18 Apr 2005 12:06:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504181206180.1759@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0504181156540.10408-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504181156540.10408-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Dino <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Apr 2005, Clemens Ladisch wrote:

> Dino wrote:
> >    i want to mix some pcm streams using hardware (where possible). One process
> > with some thread witch want to play with one device (hw:0,0). Actually i simply
> > open the device as it can (32 at max for me) with snd_pcm_open() and hw:0,0 as
> > the device. It's seems to work but i don't know if it's the rigth way.
> 
> "hw:0,0" will fail if another program has already opened it.
> Use "hw:0" which instructs ALSA to open the first available subdevice.

Nope, hw:0,0 is correct (CARD,DEVICE). You meant probably hw:0,0,0 
(CARD,DEVICE,SUBDEVICE).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
