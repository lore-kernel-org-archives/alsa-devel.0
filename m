From: Hynek Hanke <hanke@brailcom.org>
Subject: Re: How to interrupt snd_pcm_writei in blocking mode?
Date: Thu, 30 Jun 2005 20:42:28 +0200
Message-ID: <20050630184228.GA3755@brailcom.cz>
References: <20050629180540.GA12922@brailcom.cz> <Pine.HPX.4.33n.0506301140550.15584-100000@studcom.urz.uni-halle.de> <s5h8y0s59vh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8y0s59vh.wl%tiwai@suse.de>
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

> > Hynek Hanke wrote:
> > > I'm running it in two separate threads. One does all the preparations and calls
> > > snd_pcm_writei() in blocking mode. The other one then decides it wants to stop
> > > playing, so it calls snd_pcm_drop(). This causes the device to switch from
> > > state RUNNING to state SETUP, but the snd_pcm_writei() hangs forever and never
> > > returns. Why is this so?
> Well, but pcm_lib.c::snd_pcm_lib_write1() should check the state SETUP
> and break the loop immediately.  Ditto for snd_pcm_lib_read1().
> The quick hack is below.  Please give a shot.

I tried to apply the patch to the 2.6.11 kernel but after
compilation/instalation, there is no difference. It still hangs. Logfiles say
it was in the state RUNNING just before snd_pcm_drop() was called and got into
state SETUP immediatelly after. The logfile from the other thread shows
snd_pcm_writei() never returns (not even after the sound would surely be
completed).

So, what can I do? Do I really have to use the non-blocking mode or is this
supposed to work (if I take care about all the other thread related issues
myself)? My colleague is reporting it's working for him under some different
configuration.

Can I enable some debugging messages or something to help you to see what's
wrong?

With Reagards,
Hynek


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
