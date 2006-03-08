From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden ->
	alsa hangs
Date: Wed, 08 Mar 2006 09:54:59 -0800
Message-ID: <1141840499.5262.8.camel@cmn3.stanford.edu>
References: <1141800836.6150.3.camel@cmn3.stanford.edu>
	 <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
	 <20060308140635.GA16972@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751822AbWCHRz3@vger.kernel.org>
In-Reply-To: <20060308140635.GA16972@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, karsten wiese <annabellesgarden@yahoo.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-08 at 15:06 +0100, Ingo Molnar wrote:
> * karsten wiese <annabellesgarden@yahoo.de> wrote:
> 
> > ALSA Midi sequencer uses tasklets. there are 2 kinds of
> > them: lo and hi.
> > In rt-18 PREEMPT-RT, tasklet_hi_schedule() didn't work,
> > 'cause it woke up tasklet_lo's thread.
> > Thats what my patch fixed.
> 
> ah - i thought that -rt18 had your fix already - but indeed it's -rt19 
> that added it. So it's probably the same bug.

I agree, I just booted into -rt20 and the problem seems to be gone. Let
me know if you still want the trace, I can always boot again into the
buggy kernel. 

Thanks for the help!
-- Fernando
