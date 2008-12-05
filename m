From: Pete <peterpion@yahoo.com>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 07:20:27 -0800 (PST)
Message-ID: <227999.32830.qm@web65402.mail.ac4.yahoo.com>
References: <20081205151709.GA3160@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65402.mail.ac4.yahoo.com (web65402.mail.ac4.yahoo.com
	[76.13.9.22]) by alsa0.perex.cz (Postfix) with SMTP id 7E16E24531
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:20:28 +0100 (CET)
In-Reply-To: <20081205151709.GA3160@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John thanks,

I spoke to you about 2 weeks ago about this and have been trying the various tweaks you suggested. But so far I have found no configs which have worked flawlessly, although one config had it down to about one xrun every 20 mins or so average.

Thing is I am after capturing live gigs, which you dont get a second chance with. Although I suspect a small xrun would be easy to disguise but its not ideal. So I am trying to hunt down the elusive 'perfection' config.

Its interesting that when I comment out the actual write call in arecord, there are no xruns. Tonight I will try the exact config you mention below. I suspect that the problem I am getting might be related to the hardware I am on though, which does not have much in the way of configurable bios. Perhaps something should be turned off which I can not access through this basic bios.

Anyway on discovering the stack trace system it was obvious that I must get it working so if it works under a non RT kernel thats where I will go next. Although it would be nice if someone could tell me a tool which would work with the RT kernel as it does interest me what could be screwing up this supposedly real time system, just from a technical interest point of view.

John Rigg <aldev@sound-man.co.uk> wrote: On Fri, Dec 05, 2008 at 06:48:43AM -0800, Pete cat wrote:
> I understand. Im only a fairly basic C coder and such, so could you
> recommend a tool which is fairly easy to use? Or would it be better
> to revert to a non RT kernel (there did not seem to be much improvement
> when I moved to the RT kernel)?

FWIW I've never been able to run an RT-patched kernel with pcm_multi.
I've been using a non-rt preempt SMP kernel with three Delta 1010s for
about three years now without too many problems, currently with
alsa-lib-1.0.16 and 2.6.25.x kernel.

John
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
