From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Date: Thu, 2 Sep 2004 10:23:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040902082324.GA27031@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267799AbUIBIWM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040902065549.GA18860@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


* Ingo Molnar <mingo@elte.hu> wrote:

> this release fixes an artificial 0-1msec delay between hardirq arrival
> and softirq invocation. This should solve some of the ALSA artifacts
> reported by Mark H Johnson. It should also solve the rtl8139 problems
> - i've put such a card into a testbox and with -Q7 i had similar
> packet latency problems while with -Q8 it works just fine.

the rtl8139 problems are not fixed yet - i can still reproduce the
delayed packet issues.

	Ingo
