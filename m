From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Improving wine support for alsa.
Date: Thu, 06 May 2004 21:49:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
References: <20040506234248.GB30822@zewt.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out005.verizon.net (out005pub.verizon.net [206.46.170.143])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA18127
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 03:49:40 +0200
In-reply-to: Your message of "Thu, 06 May 2004 19:42:48 EDT."
             <20040506234248.GB30822@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <g_sf@zewt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Kernel people: is poll() less effective than using SND_PCM_ASYNC and a
>signal handler for low-latency sound?  I'm guessing it is, but there

at the risk of endlessly repeating myself, SIGIO is basically
useless. your handler executes in signal-handling context, and can do
very, very little. not even all system calls are legal in this context.
SIGIO is basically a "poor man's thread system", and not much more.

also, poll wakes a task quicker than a signal. this is easy to
establish empirically. from a theoretical perspective, signal handling
is a much more complex situation that simply continuing on with
whatever function was blocked.

--p


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
