From: Paul Davis <pbd@op.net>
Subject: Re: Underruns (borken pipes)
Date: Mon, 15 Jul 2002 13:57:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17UA4a-0006F5-00@usw-sf-list1.sourceforge.net>
References: <3D326D99.5F419B7C@tele-ip.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 15 Jul 2002 16:37:13 +1000."
             <3D326D99.5F419B7C@tele-ip.com>
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

>OK. I believe I now understand the tradeoffs. Also, it was not clear
>to me that the Jack audio driver would solve my problems since most
>of what Jack is about is allowing multiple audio clients (which I
>don't have, and in fact don't want at all in this case).

Thats not entirely true. At least 30-50% of JACK's design comes from
the desire to have a simple, highly abstracted, highly efficient model
for audio i/o. 95%+ of the time that i use JACK, its with one client
(for now, anyway).

>Would you care to speculate that the reason it works better *without*
>poll is that on average I'm stuffing something into the buffers
>before they are totally empty (which would be the case for poll), so
>the impact of a long system latency just prior to stuffing is less
>since there's a bit more left in the hardware buffer ?

well, there's that aspect of things, but just as likely is the
behaviour of the kernel is scheduling certain things, which is
erratic, and though deterministic in a strict sense, tends to feel
mostly random.

>I suspect writing less in each time won't help because the behaviour
>of 'poll' remains unchanged only reporting when the hardware buffer
>is empty (too late !).

no, poll reports back to you when the amount of data/space equals or
exceeds the "avail_min" count set by your program.

>> you're just facing the inevitable poor scheduling latency of the
>
>...and this would be fixed by jack driver style code, or would
>require the low latency kernel patch as well ?  No point going to
>Jack at this stage if it's not going to help.  The fact that it's
>much better without Xwindows supports the occasional latency problem.

the problems you have will not be solved by JACK alone. however, you
will find that JACK's design and what it forces on your application,
will provide some assistance in this area.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
