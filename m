From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: 2.6.15-rt20, "bad page state", jackd (alsa 1.0.10 vs. recent kernels)
Date: Mon, 13 Mar 2006 10:25:53 +0100
Message-ID: <20060313092553.GF5780@elte.hu>
References: <1141846564.5262.20.camel@cmn3.stanford.edu> <20060309084746.GB9408@osiris.boeblingen.de.ibm.com> <1141938488.22708.28.camel@cmn3.stanford.edu> <4410B2D7.4090806@yahoo.com.au> <1141958866.22708.69.camel@cmn3.stanford.edu> <441109BC.9070705@yahoo.com.au> <1142016627.6124.33.camel@cmn3.stanford.edu> <44121351.2050703@yahoo.com.au> <1142210977.7471.27.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1142210977.7471.27.camel@cmn3.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, cc@ccrma.Stanford.EDU, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
> with alsa stable 1.0.10 and googled for the obvious two chunks that
> stood out :-)
> 
> It's apparently an old issue, see here and follow the thread:
>   http://lkml.org/lkml/2005/11/21/9
> So, 1.0.10 obviously did not include these two patches:

ah, great detective work! FYI, current upstream has the fix included, so 
2.6.16-rc6-rt2 should not have this particular problem.

	Ingo


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
