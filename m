From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 09:50:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19GJ2Q-0001vk-00@sc8-sf-list1.sourceforge.net>
References: <5.1.0.14.2.20030515141943.0343a510@pop.gmx.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 May 2003 14:35:30 +0200."
             <5.1.0.14.2.20030515141943.0343a510@pop.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Vollmer <remllov_@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>my goal is to copy captured data (ice1712 multitrack mode, 12 interleaved 
>channels, S32_LE data) with low latency (max 50 ms) and as little overhead 
>as possible, so my first thought was to use mmap and async handlers.

sorry to sound like a broken record for so many people, but is there
any reason not to just use JACK? JACK goes down significantly below 50ms.

>Now I found a recent thread about using async handlers
>(http://www.geocrawler.com/mail/thread.php3?subject=%5BAlsa-devel%5D+Restartin
>g+when+in+async+mode&list=12349) 
>
>and I guess I have to think again about poll(2) and a multithreaded 
>application. What would you suggest to be the fastest access method under 
>these circumstances ?

the speed difference will be negligible. you have to trade off rather
limited "legal" functionality from an async handler with the
complexities and freedom of poll+threads.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
