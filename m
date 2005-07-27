From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 18:16:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507271750440.10303@denise.shiny.it>
References: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 27 Jul 2005, Clemens Ladisch wrote:

> > Well, I mean, we have no API for providing this information.
> > Not only PCM but other controls (e.g. effects like chorus/reverb)
> > would be bound to a PCM voice, so only defining consistent control
> > names wouldn't suffice.
> >
> > I believe PCM iface attribute could be used for such a purpose,
>
> As far as I see, the iface/device/subdevice fields were designed for
> exactly this purpose, i.e., associating a control with a specific
> (sub)device.

How do they work ?


> > but unfortunately, the situation is confusing.  Some drivers
> > already use PCM iface for different purposes (e.g. hdsp) and some
> > use mixer iface for exactly this purpose (e.g. emu10k1)...
>
> Then I'd consider these drivers buggy.
>
> I'll write a patch unless anybody objects ...

The tutorial says nothing about control names, interfaces and their
arrangement and expecially how they are meant to be sorted out. In my
driver we have A analog channels and D digital channels. The driver
registers a "PCM Playback Volume" control as an array of A+D integers,
where each element is the gain (-128..+6) of each channel, but they don't
map directly to the PCM channels because the driver exports analog and
digital channels as two separate devices (this feature can be removed
easily). So pcmvol[0..A-1] controls the volume of hw:0,0 and
pcmvol[A..A+D-1] controls the volume of hw:0,1. Furthermore, the user
can open hw:0,0,x to address the xth channel.
The driver also has other controls that are quite hw-specific and I don't
think a generic application would be able to use them. Those controls are
not a problem, because I wrote echomixer to manage them. It is important
that apps can access basic controls, though.

If the way I arranged things is wrong, let me know...


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
