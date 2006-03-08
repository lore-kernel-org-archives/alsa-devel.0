From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Date: Wed, 8 Mar 2006 12:48:47 +0100
Message-ID: <20060308114847.GA20591@elte.hu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu> <20060307220628.GA27536@elte.hu> <1141800836.6150.3.camel@cmn3.stanford.edu> <s5h4q29rwfg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4q29rwfg.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org


* Takashi Iwai <tiwai@suse.de> wrote:

> > > could you get a tasklist-dump? It's either SysRq-T, or:
> > > 
> > > 	echo t > /proc/sysrq-trigger
> > > 
> > > that should dump all tasks and their backtraces - including the hung 
> > > rosegardensequencer task.
> > 
> > I'll try to do that tomorrow. 
> 
> That'll be helpful.  A deadlocked mutex could be easily found by a 
> backtrace.

furthermore, in the -rt kernel (if PREEMPT_RT and DEBUG_DEADLOCKS is 
enabled), all locks will also be printed, and their owners, and the site 
where they got acquired, etc. A deadlocked mutex/semaphore should in 
fact be detected by the kernel, if those options are enabled.

	Ingo


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
