From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about kernel timers
Date: Fri, 28 Jul 2006 09:01:50 +0200
Message-ID: <20060728070150.GA25118@turing.informatik.uni-halle.de>
References: <1153864917.25859.238.camel@mindpipe>
	<1154049487.2927.98.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1154049487.2927.98.camel@mindpipe>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Tue, 2006-07-25 at 18:01 -0400, Lee Revell wrote:
> > I've found that the kernel Oopses if you allocate a timer on the
> > stack, so I use kmalloc().  It seems to work, but leaks memory, as
> > there's no opportunity to free() all the timer_lists I'm creating on
> > the fly.
> 
> I've solved this problem by passing a pointer to the struct timer_list
> to the timer function, and kfree()ing it at the end.  It seems pretty
> ugly but it works.

When the device is closed, you have to cancel all timers (or wait for
them to finish), so I think you have to put them into a list or
something like that.

Is there an upper bound on the number of timers?

Another possibility would be to use one timer and to write your own
event handling logic, but this is probably not worth the effort.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
