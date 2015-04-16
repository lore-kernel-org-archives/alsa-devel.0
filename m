From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 04/39] sound: Use hrtimer_resolution instead of
 hrtimer_get_res()
Date: Thu, 16 Apr 2015 11:08:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504161108260.3845@nanos>
References: <20150414203303.702062272@linutronix.de> <20150414203500.799133359@linutronix.de> <s5h618wsdho.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h618wsdho.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Marcelo Tosatti <mtosatt@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Apr 2015, Takashi Iwai wrote:
> At Tue, 14 Apr 2015 21:08:30 -0000,
> Thomas Gleixner wrote:
> > 
> > No point in converting a timespec now that the value is directly
> > accessible. Get rid of the null check while at it. Resolution is
> > guaranteed to be > 0.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.de>
> 
> Would you like me picking up this through sound git tree, or apply the
> whole set through tip?  In the latter case, feel free to take my ack:
>   Acked-by: Takashi Iwai <tiwai@suse.de>

I pick it up as it has a dependency on core code changes.

Thanks,

	tglx
