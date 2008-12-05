From: Pete <peterpion@yahoo.com>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 08:11:36 -0800 (PST)
Message-ID: <434768.7988.qm@web65408.mail.ac4.yahoo.com>
References: <20081205160215.GA3295@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65408.mail.ac4.yahoo.com (web65408.mail.ac4.yahoo.com
	[76.13.9.28]) by alsa0.perex.cz (Postfix) with SMTP id 44C9510380B
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 17:11:37 +0100 (CET)
In-Reply-To: <20081205160215.GA3295@localhost>
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

So even if the kernel is not a RT kernel, processes can run with real time priority? How is this so? From what ive read about the RT kernel it sounds like the kernel has to cooperate with the processes running on the system to allow a process to awaken (on an interrupt for instance). Otherwise the kernel will be stuck in some non interruptable state for some time, blocking the interrupt from being serviced - is that wrong?

If Jack has a way to grab higher priority through some other mechanisim, could I build this into arecord I wonder. I have of course tried nicing the process to very unnice.



John Rigg <aldev@sound-man.co.uk> wrote: On Fri, Dec 05, 2008 at 07:23:00AM -0800, Pete wrote:
> Is there likely to be any disadvantage to running arecord rather
> than say Jack to capture? Does (say) Jack read the card in a 'better' 
> way?

jackd runs with realtime priority if -R option is specified
when starting it. Running it without -R produces xruns fairly 
often, but with -R they almost never happen on a properly configured
system. I don't know if arecord can run with realtime priority.

John
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
