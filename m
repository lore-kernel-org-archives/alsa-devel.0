From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: General Guidelines?  (MIDI)
Date: Wed, 15 Jan 2003 12:43:18 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301151227400.2915-100000@studcom.urz.uni-halle.de>
References: <20030114212004.GA24898@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030114212004.GA24898@bhv1.adelphia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brian Victor wrote:
>   * On first run, the test program will only play the note on tick 0,
>     and nothing beyond that.
>
>   * On subsequent runs, the test program doesn't even play that.  I
>     would chalk it up to poor garbage collection (I'm doing a ^C to stop
>     the program), but miniArp will still run fine after that, and then
>     my test program performs as the first run again.

Running queues are visible in /proc/asound/seq/timers IIRC. And in theory,
ALSA should properly free queues/timers when doing ^C.

>   * Above I use output_direct.  Should I just be using output for events
>     that should occur in the future?

Yes. output_direct send the event directly to the destination port,
without going through a queue.

>   * Does the output pool need to be big enough to accomodate any data my
>     program will have in the queue at once?  Or just big enough to allow
>     for some buffering?

No. Yes.


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
