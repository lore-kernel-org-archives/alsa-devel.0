From: Paul Davis <pbd@op.net>
Subject: Re: Repeatable exact I/O-delay
Date: Sun, 28 Jul 2002 10:57:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207281456.QAA29896@alsa.alsa-project.org>
References: <20020728143945.D582D902@mail.it4u.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA29896
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 16:56:04 +0200
In-Reply-To: Your message of "Sun, 28 Jul 2002 16:39:50 +0200."
             <20020728143945.D582D902@mail.it4u.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>By the way, I tried to search for the same code in rme9652.c, and found 
>something similar, but it does not seem to activate both capture and 
>playback with a single write to the control register. I'm not sure how 
>the hardware works (nor the driver) though so I may be wrong. 

there are no distinct capture/playback streams in the h/w. the card is
either running or not. hence, capture and playback always run exactly
in sync, and there are no separate interrupts for each stream. its a
properly designed card for full-duplex operation.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
