From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Timer?
Date: Wed, 6 Mar 2002 17:57:54 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203061741300.2187-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19359
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:00:24 +0100
In-Reply-To: <200203061631.LAA17147@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Mar 2002, Paul Davis wrote:

> >Is there any documentation on the timer api that goes beyond what's on the als
> >a-project pages? We're trying to sync Video and Audio, and all we need is a wa
> >y to query the current time relative to some arbitrary start point.
> 
> i don't believe that the timer API has much to do with this. its more
> a way of getting a trigger from a timer, not of reading time per se.
> 
> to sync audio + video you have to keep track of the number of frames
> you've delivered to both streams. the audio stream is giving you
> exactly the same timing info (albeit implicitly) as it would do if you
> used as a timer.

You're right. But it would be really nice to have a continuous timer 
source in some resolution (microseconds?) available for all platforms
to satisfy synchronization requirements. 

It's not probably required exactly for this example where timing from one
audio target is sufficient, but I can imagine several applications
synchronized together. As far as I know, Linux has not a continous timer.
I am ready to work on this issue. It is very simple to create an interface
with one ioctl returning struct timeval with the absolute timer value
measured from system boot on i386 using rdtsc instruction.

Perhaps, I'm trying to reinvent wheel, so please, let me know, if someone 
solved this issue.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
