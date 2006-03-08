From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Date: Wed, 8 Mar 2006 15:06:35 +0100
Message-ID: <20060308140635.GA16972@elte.hu>
References: <1141800836.6150.3.camel@cmn3.stanford.edu> <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org


* karsten wiese <annabellesgarden@yahoo.de> wrote:

> ALSA Midi sequencer uses tasklets. there are 2 kinds of
> them: lo and hi.
> In rt-18 PREEMPT-RT, tasklet_hi_schedule() didn't work,
> 'cause it woke up tasklet_lo's thread.
> Thats what my patch fixed.

ah - i thought that -rt18 had your fix already - but indeed it's -rt19 
that added it. So it's probably the same bug.

	Ingo


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
