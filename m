From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Date: Thu, 02 Sep 2004 19:25:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094167534.1571.10.camel@krustophenia.net>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <1094108653.11364.26.camel@krustophenia.net>
	 <20040902071525.GA19925@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269301AbUIBX2e@vger.kernel.org>
In-Reply-To: <20040902071525.GA19925@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-09-02 at 03:15, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here are traces of a 145, 190, and 217 usec latencies in
> > netif_receive_skb:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace2.txt
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace3.txt
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace4.txt
> 
> these all seem to be single-packet processing latencies - it would be
> quite hard to make those codepaths preemptible.
> 
> i'd suggest to turn off things like netfilter and ip_conntrack (and
> other optional networking features that show up in the trace), they can
> only increase latency:
> 

Do you see any optional networking features in the trace (other than
ip_conntrack)?  I was under the impression that I had everything
optional disabled.

Lee  
