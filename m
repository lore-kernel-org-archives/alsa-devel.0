From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Date: Thu, 02 Sep 2004 03:04:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094108653.11364.26.camel@krustophenia.net>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu>  <20040902065549.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267512AbUIBHER@vger.kernel.org>
In-Reply-To: <20040902065549.GA18860@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-09-02 at 02:55, Ingo Molnar wrote:
> i've released the -Q8 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q8
> 
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 

Here are traces of a 145, 190, and 217 usec latencies in
netif_receive_skb:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace2.txt
http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace3.txt
http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace4.txt

Some of these are with ip_conntrack enabled, at the request of another
poster, this does not make much of a difference, it increases the worst
case latency by 20 usec or so.

Also there is the rt_garbage_collect issue, previously reported.  I have
not seen this lately but I do not remember seeing that it was fixed.

Lee
