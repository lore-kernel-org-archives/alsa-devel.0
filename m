From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 17:21:33 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
References: <s5hll3slj32.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll3slj32.wl%tiwai@suse.de>
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
Cc: Jaroslav Kysela <perex@suse.cz>, Giuliano Pochini <pochini@shiny.it>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> At Wed, 27 Jul 2005 10:30:36 +0200,
> I wrote:
> >
> > The problem is that it's not clearly defined how to find the bound
> > control for the currently opened pcm.  We may assume that the index
> > number corresponds to the substream index, but this may be different
> > on drivers.
>
> Well, I mean, we have no API for providing this information.
> Not only PCM but other controls (e.g. effects like chorus/reverb)
> would be bound to a PCM voice, so only defining consistent control
> names wouldn't suffice.
>
> I believe PCM iface attribute could be used for such a purpose,

As far as I see, the iface/device/subdevice fields were designed for
exactly this purpose, i.e., associating a control with a specific
(sub)device.

> but unfortunately, the situation is confusing.  Some drivers
> already use PCM iface for different purposes (e.g. hdsp) and some
> use mixer iface for exactly this purpose (e.g. emu10k1)...

Then I'd consider these drivers buggy.

I'll write a patch unless anybody objects ...


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
