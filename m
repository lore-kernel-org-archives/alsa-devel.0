From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_drain() always fails
Date: Mon, 1 Aug 2005 19:57:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz>
References: <20050801172719.GB10144@brailcom.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76730196
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 19:57:41 +0200 (MEST)
In-Reply-To: <20050801172719.GB10144@brailcom.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Aug 2005, Hynek Hanke wrote:

> 
> Hi,
> 
> I'm still having problems programming ALSA backend for my app. I open the
> device, I try to write as many frames as possible, I poll() for events (and
> check for XRUNs and SUSPENDs, they don't happen). When I get notification that
> ALSA is ready for more frames, I send more (typically 32 or 64). After all
> frames are sent, I call snd_pcm_drain() ... and want to wait in poll() until
> ALSA gets out of SND_PCM_STATE_DRAINING.
> 
> But snd_pcm_drain() always fails with ``Resource temporarily unavailable''
> error.  The state after snd_pcm_drain() fails is still RUNNING. Why is this?
> What can I do about it?

Nothing. If drain() is supposed to wait until all data are played and 
you're using the non-blocking mode, then it's definitely an error (thus 
-EAGAIN is returned - and it means from the driver perspective - I must 
wait and the application does not want this from me).

> Or, what is the correct way to wait until the rest of the sound is 
> played when I'm using the poll() approach?

Set the blocking mode before drain() is called (and return the mode back 
after it, if you want). The better way might be setting sw_params to 
wakeup app after all frames are played and use the standard poll() call to 
wait in app.

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
