From: Hynek Hanke <hanke@brailcom.org>
Subject: How to interrupt snd_pcm_writei in blocking mode?
Date: Wed, 29 Jun 2005 20:05:40 +0200
Message-ID: <20050629180540.GA12922@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Hello,

I'm seeking some help with a problem I encountered in my audio output module
for alsa-lib.

I'm running it in two separate threads. One does all the preparations and calls
snd_pcm_writei() in blocking mode. The other one then decides it wants to stop
playing, so it calls snd_pcm_drop(). This causes the device to switch from
state RUNNING to state SETUP, but the snd_pcm_writei() hangs forever and never
returns. Why is this so?

What are the exact circumstances I'm allowed to use snd_pcm_drop() under and
what exactly is it supposed to do? (The alsa-lib documentation doesn't provide
enough details.)

Thank you,
Hynek Hanke





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
