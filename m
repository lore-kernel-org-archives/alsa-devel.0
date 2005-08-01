From: "Hynek Hanke,,," <hanke@volny.cz>
Subject: Re: snd_pcm_drain() always fails
Date: Mon, 1 Aug 2005 20:04:17 +0200
Message-ID: <20050801180417.GD10144@brailcom.cz>
References: <20050801172719.GB10144@brailcom.cz> <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out3.iol.cz (smtp-out3.iol.cz [194.228.2.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E86F3196
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:07:22 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > Or, what is the correct way to wait until the rest of the sound is 
> > played when I'm using the poll() approach?
> Set the blocking mode before drain() is called (and return the mode back 
> after it, if you want). 

Not possible. I'm waiting for other events (not comming from ALSA) too in the
poll().

> The better way might be setting sw_params to wakeup app after all frames are
> played and use the standard poll() call to wait in app.

How do I do this or where can I read about it? Still, I need to receive other events
too while waiting for the sound to stop playing.

Thank you,
Hynek Hanke


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
