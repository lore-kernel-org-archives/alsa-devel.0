From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Date: Thu, 02 Sep 2004 19:32:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094167928.1571.13.camel@krustophenia.net>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <1094108653.11364.26.camel@krustophenia.net>
	 <20040902071525.GA19925@elte.hu>
	 <1094167534.1571.10.camel@krustophenia.net>
	 <20040902232839.GA32440@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269306AbUIBXfS@vger.kernel.org>
In-Reply-To: <20040902232839.GA32440@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-09-02 at 19:28, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Do you see any optional networking features in the trace (other than
> > ip_conntrack)?  I was under the impression that I had everything
> > optional disabled.
> 
> yeah, it seems to be only ip_conntrack and netfilter (which conntrack
> relies on).
> 

FWIW these seem to only slow down the single packet path by about 10%. 
This is pretty good.

Lee
