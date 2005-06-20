From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: move AC97 codec and HDA codec drivers
Date: Mon, 20 Jun 2005 19:40:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506201938320.1753@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0506201038020.1753@pnote.perex-int.cz>
 <s5hfyvdosky.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF3E11D4
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2005 19:40:02 +0200 (MEST)
In-Reply-To: <s5hfyvdosky.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Jun 2005, Takashi Iwai wrote:

> At Mon, 20 Jun 2005 10:58:15 +0200 (CEST),
> Jaroslav wrote:
> > 
> > Hi,
> > 
> > 	because AC97 codec and HDA codec drivers are universal and might
> > be used also with another than PCI hardware (as seen with PDAs or embedded 
> > systems), I propose to move this code to:
> > 
> > alsa-kernel/drivers/ac97
> > alsa-kernel/drivers/hdac
> 
> Fine with me.  But, hda-intel will remain in pci, right?

Exactly. It's the PCI component.

> > 	It will remove the "CONFIG_PCI" dependency in the alsa-kernel/pci 
> > tree. Opinions? Also we have the i2c tree for this purpose, but I feel
> > that we should rename i2c to something more appropriate like components
> > in this case and move i2c code to the components/i2c tree.
> 
> I don't think moving i2c to a depper directory is a good idea, unless
> we have many components.  Moving files is confusing especially on
> CVS.

Ok, I also feel this. 

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
