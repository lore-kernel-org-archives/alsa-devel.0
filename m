From: Peter Vollmer <remllov_@gmx.de>
Subject: Re: snd_async_add_pcm_handler() and
  SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 14:35:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030515141943.0343a510@pop.gmx.net>
References: <Your message of "Thu, 15 May 2003 10:23:41 +0200." <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030515121341.10071gmx1@mx009.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At 08:18 15.5.2003 -0400, you wrote:
> >I am trying to use the mmap access method together with an async_handler
> >function (ice1712 in multitrack mode),
>
>i just want to remind anyone using the async handlers that the list of
>system calls you can make in an async handler is extremely
>limited. make sure you limit yourself to that list.

thanks for the prompt response,
my goal is to copy captured data (ice1712 multitrack mode, 12 interleaved 
channels, S32_LE data) with low latency (max 50 ms) and as little overhead 
as possible, so my first thought was to use mmap and async handlers.

Now I found a recent thread about using async handlers
(http://www.geocrawler.com/mail/thread.php3?subject=%5BAlsa-devel%5D+Restarting+when+in+async+mode&list=12349) 

and I guess I have to think again about poll(2) and a multithreaded 
application. What would you suggest to be the fastest access method under 
these circumstances ?

Peter





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
