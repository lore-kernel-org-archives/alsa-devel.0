From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: Re: why do elements disappear?
Date: Thu, 03 Mar 2005 09:57:45 +0100
Message-ID: <1109840265.2840.45.camel@tux.lan>
References: <1108501973.2845.87.camel@tux.lan> <s5hll9obxar.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
In-reply-to: <s5hll9obxar.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I tried playing with what you said but must have misunderstood.

On Wed, 2005-02-16 at 11:42, Takashi Iwai wrote:
> At Tue, 15 Feb 2005 22:12:53 +0100,
> Ronald S. Bultje wrote:
> > It appears that alsa removes the EMU10K1 PCM elements when I call
> > snd_mixer_handle_events(). Why does it do that, how do I make it stop
> > doing it and/or how do I handle this?
> 
> EMU10K1 PCM control is dynamically added/removed when the
> corresponding PCM is opened/closed (more precisely, INACTIVE flag is
> removed/added at each open/close).
> 
> If the app is programmed in a passive manner, it will receive the ADD
> and REMOVE events when new controls are created/deleted.  Then the app
> has to take the corresponding action.

I'm probably hitting a wall here, because I cannot really find any
sample code (google) or API docs (alsa website) on this. I tried setting
a snd_mixer_set_callback() [that's the right function, right?], and I
get a bunch of 'event number 4' when I start the mixer (did I mention
that the masks are undocumented? :) ). But nothing more. And a crash at
the end, still. What other function should I use to listen for
removed/added elements? Is there working sample code?

Honestly, at this point, I don't mind a quick hack (to do the right
thing later) if there is one and it's simpler.

Thanks,

Ronald

-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
