From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to interrupt snd_pcm_writei in blocking mode?
Date: Thu, 30 Jun 2005 12:05:49 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506301140550.15584-100000@studcom.urz.uni-halle.de>
References: <20050629180540.GA12922@brailcom.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050629180540.GA12922@brailcom.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hynek Hanke <hanke@brailcom.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hynek Hanke wrote:
> I'm running it in two separate threads. One does all the preparations and calls
> snd_pcm_writei() in blocking mode. The other one then decides it wants to stop
> playing, so it calls snd_pcm_drop(). This causes the device to switch from
> state RUNNING to state SETUP, but the snd_pcm_writei() hangs forever and never
> returns. Why is this so?

The ALSA library isn't thread safe.

I guess you have to use non-blocking mode.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
