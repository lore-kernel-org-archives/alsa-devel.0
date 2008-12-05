From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 19:41:19 +0000
Message-ID: <20081205194119.GA3669@localhost>
References: <20081205160215.GA3295@localhost>
	<434768.7988.qm@web65408.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B848243F2
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 20:28:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <434768.7988.qm@web65408.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pete <peterpion@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 08:11:36AM -0800, Pete wrote:
> So even if the kernel is not a RT kernel, processes can run with real
> time priority? How is this so? From what ive read about the RT kernel
> it sounds like the kernel has to cooperate with the processes running
> on the system to allow a process to awaken (on an interrupt for instance). 
> Otherwise the kernel will be stuck in some non interruptable state for 
> some time, blocking the interrupt from being serviced - is that wrong?
> 
> If Jack has a way to grab higher priority through some other mechanisim,
> could I build this into arecord I wonder. I have of course tried nicing
> the process to very unnice.
 
nice values are irrelevant to processes with rtprio. Any rtprio process
will have priority over any process with just a nice value. jackd -R
defaults to rtprio 10 (in a range of 0-99). You can raise that by 
specifying the value on the command line eg. jackd -R -P80
which would increase it to 80 (usually unnecessary and possibly
inadvisable). You can look at what's running with rtprio on your system
with ps, eg.:   ps -Leo pid,cmd,rtprio

rtprio makes use of SCHED_FIFO or SCHED_RR (as opposed to SCHED_NORMAL).
These are static soft realtime scheduling policies provided by the
standard kernel. The -rt kernels attempt to get closer to hard realtime.
Don't confuse the two.

On the current kernels, a non-root user has to belong to a realtime
scheduling group (eg. the audio group) and the kernel config needs to
have CONFIG_RT_GROUP_SCHED=y to allow rtprio to be used. The relevant
configuration must also be present in /etc/security/limits.conf. There
are plenty of articles on the web describing how to set up limits.conf.

John
