From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-2
Date: Tue, 16 Nov 2004 14:16:41 +0100
Message-ID: <20041116131641.GB11053@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <61930.195.245.190.94.1100529227.squirrel@195.245.190.94> <20041115161159.GA32580@elte.hu> <33583.195.245.190.93.1100537554.squirrel@195.245.190.93> <32825.192.168.1.5.1100558154.squirrel@192.168.1.5> <20041116104143.GA31090@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261972AbUKPNJP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041116104143.GA31090@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>, Thomas Gleixner <tglx@linutronix.de>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, Karsten Wiese <annabellesgarden@yahoo.de>, Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com, Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Already testing with RT-0.7.26-5 now. No good. Same lockup behavior on
> > alsa shutdown, altought not always, but very frequently. Nothing comes
> > out via serial console. Not even SysRq is of any help, pretty hard
> > these lockups are.
> 
> i'm rebasing to -rc2-mm1 currently, it should be completed today and
> we'll see whether those ALSA problems are upstream related.
> 
> is it stable if you dont unload the ALSA modules?

i just found a potential problem that could cause a near-lockup during
module removal. This code in __module_put_and_exit() could loop for
quite long time:

        while (current->lock_depth != -1)
                unlock_kernel();

since for specifically ALSA's no-BKL purpose i've introduced the notion
of ->lock_depth going below -1. So if we happen to put the module while
->lock_depth is -2, it could take quite some time for it to go down to
zero again ... (and it could cause other problems as well)

i fixed this in the -V0.7.27-2 release, freshly uploaded to the usual
place:

      http://redhat.com/~mingo/realtime-preempt/

do you still see lockups with this patch?

	Ingo
