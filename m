From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] AC97 bus interface for ad-hoc drivers
Date: Wed, 27 Jul 2005 09:05:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
References: <1121775624.14604.14.camel@cearnarfon>
 <s5hbr4old2a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hbr4old2a.wl%tiwai@suse.de>
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
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@lists.sourceforge.net, Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Jul 2005, Takashi Iwai wrote:

> At Tue, 19 Jul 2005 13:20:24 +0100,
> Liam Girdwood wrote:
> > 
> > This patch adds support for ad-hoc AC97 device drivers (e.g WM97xx and
> > UCB touchscreen drivers) and was originally posted to the list by
> > Nicolas Pitre as an RFC. 
> > 
> > Changes from RFC version :-
> > 
> >   o Now matches codec name within codec group.
> >   o Added ac97_dev_release() to stop kernel complaining about no release
> > method for device.
> 
> Thanks for the patch.  The idea is fine, and the code looks almost
> OK except for the below.
> 
> Could you describe the full changelog (or paste Nicolas' RFC) ?
> 
> 
> > diff --git a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
> > --- a/sound/pci/ac97/Makefile
> > +++ b/sound/pci/ac97/Makefile
> > @@ -12,7 +12,7 @@ endif
> >  snd-ak4531-codec-objs := ak4531_codec.o
> >  
> >  # Toplevel Module Dependency
> > -obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o
> > +obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o ac97_bus.o
> 
> Better to keep snd- prefix for ac97_bus module (although it can be
> used independently from ALSA)...?  It's an open question.

The idea is to be able to use ALSA as modules and the extra function 
driver linked in, or vice versa.  Therefore ac97_bus.o should probably 
be selected with its own config symbol allowing for things like:

config UCB1400_TS
	tristate "UCB1400 touchscreen interface"
	select AC97_BUS


And similarly:

config SND_AC97_CODEC
	...
	select AC97_BUS

This way there is no hard linkage depedency between ALSA and any ad-hoc 
codec function driver.


Nicolas


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
