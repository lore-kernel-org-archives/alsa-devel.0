From: Paul Davis <pbd@op.net>
Subject: Re: Underruns (borken pipes)
Date: Fri, 12 Jul 2002 08:53:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17Szsx-0001PX-00@usw-sf-list1.sourceforge.net>
References: <3D2E4B59.60ACA464@tele-ip.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 12 Jul 2002 13:22:01 +1000."
             <3D2E4B59.60ACA464@tele-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I got around my previous problems (readn) in an output/capture
>application with an envy24
>(ice1712) by bypassing the plugin and going straight to hw:0,0. Had to
>change my code a bit
>but it's now **almost** working.

i humbly suggest that you:

  (1) read the source code for JACK's ALSA driver/client
  (2) consider using JACK

the first suggestion will reveal quite a bit. you additionally will
need to know that you can't avoid underruns with small buffer sizes
unless you run with SCHED_FIFO or SCHED_RR scheduling, and not without
a kernel with Andrew Morton's low latency patches. you didn't say what
buffer sizes you were using, so its hard to know if this is an issue.

the second suggestion will avoid you having to deal with any of this
nonsense altogether, and get focused on the core part of your
application.

http://jackit.sf.net/

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Gadgets, caffeine, t-shirts, fun stuff.
http://thinkgeek.com/sf
