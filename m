From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Date: Mon, 15 Nov 2004 16:40:59 +0100
Message-ID: <20041115154059.GA31143@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261615AbUKOOml@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>, Thomas Gleixner <tglx@linutronix.de>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, Karsten Wiese <annabellesgarden@yahoo.de>, Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com, Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

>   2) Serial console (or netconsole, if that matters) aren't showing
> anything relevant for debugging; SysRq-T is just silent, only printing
> a "Show State" one liner. No traces, no dumps.

next time around could you try SysRq-D first?

> OK. Just some last resort questions: is there any plans (or recipe) on
> merging the RT patch(es) against the 2.6.10(-rc1) vanilla kernel? Or,
> at least for my laptop's sake, on top of this late and "well" behaved
> -mm2 ?

there should be an -rc2-mm1 kernel out within the next day or two, at
which point i'll merge. (-rc1-mm5 has some problems.)

	Ingo
