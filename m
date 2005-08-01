From: Hynek Hanke <hanke@brailcom.org>
Subject: Re: snd_pcm_drain() always fails
Date: Mon, 1 Aug 2005 20:10:15 +0200
Message-ID: <20050801181015.GE10144@brailcom.cz>
References: <20050801172719.GB10144@brailcom.cz> <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out3.iol.cz (smtp-out3.iol.cz [194.228.2.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98B61196
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:13:21 +0200 (MEST)
Received: from antivir3.iol.cz (unknown [192.168.30.206])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 89BD0318681
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:13:22 +0200 (CEST)
Received: from localhost (antivir3.iol.cz [127.0.0.1])
	by antivir3.iol.cz (Postfix) with ESMTP id 8210B6DC003
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:13:22 +0200 (CEST)
Received: from smtp-out3.iol.cz (unknown [192.168.30.28])
	by antivir3.iol.cz (Postfix) with ESMTP id 7172D6DC002
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:13:22 +0200 (CEST)
Received: from chopin (unknown [80.188.214.108])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 3249F3BF89
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:13:22 +0200 (CEST)
Received: from hanke by chopin with local (Exim 3.36 #1 (Debian))
	id 1Dzejw-000634-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Aug 2005 20:10:16 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Nothing. If drain() is supposed to wait until all data are played and 
> you're using the non-blocking mode, then it's definitely an error (thus 
> -EAGAIN is returned - and it means from the driver perspective - I must 
> wait and the application does not want this from me).

The documentation is very unclear about this. My guess was that it should bring
me to the state DRAINING which should remain until all frames are played.
 
> Set the blocking mode before drain() is called (and return the mode back 
> after it, if you want).

This is not possible. I'm using the non-blocking mode and poll() specifically
because I need to receive external events (not comming from ALSA) too.

> The better way might be setting sw_params to wakeup app after all frames are
> played and use the standard poll() call to wait in app.  

How can I do this or where can I read about it? I still need to receive those
external events on other file descriptors. Is it possible with this approach?

With regards & thank you,
Hynek Hanke


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
