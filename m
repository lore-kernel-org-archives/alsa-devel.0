From: Tim Goetze <tim@quitte.de>
Subject: Re: Repeatable exact I/O-delay
Date: Sat, 27 Jul 2002 17:18:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0207271704220.666-100000@summer.quitte>
References: <20020727125116.B57458D1@mail.it4u.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA12513
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 17:19:12 +0200
In-Reply-To: <20020727125116.B57458D1@mail.it4u.net>
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

Anders Torger wrote:

>Does anyone have any comments on this? Is repeatable exact I/O-delay 
>possible to achieve today with current hardware (and ALSA)?

It is the normal mode of operation for memory-mapped IO.

The only thing that could change the delay is your application taking
too long to process the data to meet the deadline (xrun). In this case
you'd probably enlarge the total delay by a factor two until a cycle
is long enough to process or you exceed the maximum buffer size
supported by the hardware.

If I'm not mistaken most cards support audio cycles of 2048 frames,
for a software-through latency of 4096 frames. On the ice1712, this is
the upper limit.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
