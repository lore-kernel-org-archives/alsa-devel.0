From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to lock the sample rate ?
Date: Sat, 6 Mar 2004 15:17:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403061516490.3190@pnote.perex-int.cz>
References: <20040306115426.6b48eaaf.pochini@shiny.it>
 <Pine.LNX.4.58.0403061157220.1881@pnote.perex-int.cz>
 <20040306140542.GM25734@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040306140542.GM25734@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Mar 2004, Adam Tla/lka wrote:

> On Sat, Mar 06, 2004 at 11:59:45AM +0100, Jaroslav Kysela wrote:
> > On Sat, 6 Mar 2004, Giuliano Pochini wrote:
> > 
> > > On the Echoaudio cards the sample rate is a global setting, so I need a way
> > > to prevent an app to change the rate if someone else already set it (the
> > > card han several devices/subdevices). I was thinking to put a simple
> > > "if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
> > > but this solution is racy.
> Talking about race conditions you could use a variable which is set to 0
> at the beginning. Now if app wants to set a rate it does atomic compare
> and increase (cmpxchg on  x86) instruction so only one app could set
> rate. The other could only read memorized rate settins and report an
> error if rate is different.

We have already a number of locking features in kernel (spinlocks, 
mutexes, atomic integer operations, atomic bitmap operations etc).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
