From: Paul Davis <pbd@op.net>
Subject: Re: Repeatable exact I/O-delay
Date: Sun, 28 Jul 2002 09:54:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207281353.PAA29236@alsa.alsa-project.org>
References: <Pine.LNX.4.21.0207281418001.661-100000@summer.quitte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA29236
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 15:53:53 +0200
In-Reply-To: Your message of "Sun, 28 Jul 2002 14:40:34 +0200."
             <Pine.LNX.4.21.0207281418001.661-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Anders Torger <torger@ludd.luth.se>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>The way you'd do this is to link the capture and playback streams of
>the device you use with snd_pcm_link(). They will start together and

we still haven't established the timing for this. its possible that
its not fast enough for the two streams to be started within
<<1sample, particularly if and when 192kHz h/w appears. it might even
be problematic with 96kHz operation. i would be suprised if this was
true, but it needs to be measured and checked.

>Implementing memory-mapped IO isn't exactly what you do in a day.

:))

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
