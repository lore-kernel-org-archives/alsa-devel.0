From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Question about kernel timers
Date: Fri, 28 Jul 2006 09:00:03 +0100
Message-ID: <44C9C403.8040301@superbug.co.uk>
References: <1153864917.25859.238.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1153864917.25859.238.camel@mindpipe>
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
> I am writing a driver in which every time some event occurs, two
> single-shot timers must be scheduled.  This event could happen many
> times per second so many of these timers can be pending at once.  Can
> someone point me to an example of a driver that does something like
> this?
> 
> All the ALSA drivers I can find that use timers have a single periodic
> timer and use a struct timer_list in the card record.  However I think
> this is not an option for me, as I must create new timers on the fly.
> 
> I've found that the kernel Oopses if you allocate a timer on the stack,
> so I use kmalloc().  It seems to work, but leaks memory, as there's no
> opportunity to free() all the timer_lists I'm creating on the fly.
> 
> Can I do this with a single struct timer_list?  Is it possible to
> schedule multiple timers using add_timer() then changing the parameters
> and add_timer() again?
> 
> It seems that this should be documented somewhere but it's not - LDD3
> was no help.  All the examples were very simplistic.
> 
> Lee
> 

What is the purpose of these event timers?
I can't think of any sound card that needs this sort of stuff.
Can you use polling instead?

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
