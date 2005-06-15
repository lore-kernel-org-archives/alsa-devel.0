From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: time stamp and dmix
Date: Wed, 15 Jun 2005 14:19:12 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506151404430.24998-100000@studcom.urz.uni-halle.de>
References: <loom.20050614T040426-721@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <loom.20050614T040426-721@post.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?utf-8?b?ancsTGVl?= <jwstyle@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jw,Lee wrote:
> I use ALSA lib v1.0.6
> and I got some question about time stamp and dmix in ALSA lib.
>
> 1>I want to make application that use dmix like mplayer with dmix option
> (one or more application play sound concurrently->this is what I want).
> then, I must use snd_pcm_dmix_open instead snd_pcm_open?

Use snd_pcm_open with an appropriate device name.  For dmix, this
would be something like "dmix:plughw:X".

In later ALSA versions, sound cards that cannot do hardware mixing
automatically use dmix when being accessed with the "default" device
name.

> 2>How can I get the currnt time stamp?

With gettimeofday().  ;-)

What do you mean with "current time"?  Real time elapsed since
playback started?  Number of samples sent to the hardware, or played
by the hardware?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
