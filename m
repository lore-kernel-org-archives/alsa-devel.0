From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Simple ALSA capture/playback example and help wanted
Date: Thu, 28 Mar 2002 22:06:48 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020328220648.A18690@mlug.missouri.edu>
References: <3CA3D05A.5060102@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.94.75])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA13745
	for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2002 05:06:53 +0100
Content-Disposition: inline
In-Reply-To: <3CA3D05A.5060102@acm.org>; from abramsh@acm.org on Thu, Mar 28, 2002 at 06:24:26PM -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Howard Abrams <abramsh@acm.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There are several examples, but out of hubris I'll point you to my webpage: (all the examples are linked from the top)

http://mlug.missouri.edu/~markrages/wiki/index.php?WritingAnAlsaClient

In particular, I'd recommend you jook at JACK (jackit.sourceforge.net) before worrying too much about the ALSA details.

Regards,
Mark
markrages@mlug.missouril.edu

> 
> All,
> 
> I'm new to ALSA, and I'm using whatever version is in the
> 2.5.7 kernel w/ a Midiman Dio 2448 (cmipci driver).
> 
> I'm trying to write a simple app that reads some samples,
> does a small bit of processing, and writes them back out
> to the same device.
> 
> The card is full duplex, but I cannot seem to open a pcm
> device for reading and writing at the same time. Even the
> "latency.c" doesn't work. Is the driver just broke?
> 
> Two questions:
> 
> 1. What is the best way to accomplish my task?
> 
> 2. Does anyone have a simple example to do this?
> 
> Thanks,
> 
> h.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
