From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Date: Mon, 15 Nov 2004 17:11:59 +0100
Message-ID: <20041115161159.GA32580@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261616AbUKOPOe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>, Thomas Gleixner <tglx@linutronix.de>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, Karsten Wiese <annabellesgarden@yahoo.de>, Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com, Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

>   1) Almost everytime the P4/SMP box locks up while unloading the ALSA
> modules e.g.on shutdown. This has been an issue for quite some time on
> the latest RT patches, not exclusive to RT-V0.7.26-3. Probably it
> started since the merge into -mm3, but not sure.

hm, the syslog you sent suggests that it's the 2.6.10-rc1-mm3-RT-V0.7.24
kernel that crashed:

 Nov 11 12:39:46 lambda kernel: EFLAGS: 00010083   (2.6.10-rc1-mm3-RT-V0.7.24)

not -V0.7.26-3. The particular rmmod crash you got:

 Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (8)
 Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (12)
 Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (12)

seems to be quite related to one of the fixes that -V0.7.25 includes:

 - added upstream fix for kobject related crash, pointed out by Shane
   Shrybman.

so ... unless you got similar crashes with -V0.7.25 or later kernels
(but no syslog traces), please try the latest one (-V0.7.26-4), does
that one crash in rmmod too?

	Ingo
