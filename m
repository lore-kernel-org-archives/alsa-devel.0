From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - Add support for the OQO Model 2
Date: Fri, 01 Feb 2008 08:19:58 -0800
Message-ID: <1201882798.24072.31.camel@razman.gruemaster.com>
References: <1201822394.23369.108.camel@razman.gruemaster.com>
	<s5hejbw3mc8.wl%tiwai@suse.de>
	<1201878104.24072.22.camel@razman.gruemaster.com>
	<s5hmyqk1zh0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF28244C5
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 17:20:00 +0100 (CET)
In-Reply-To: <s5hmyqk1zh0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 2008-02-01 at 16:13 +0100, Takashi Iwai wrote:

> Also, I had some very strange audio garbage with the tip on an HD
> Audio platform
> > that normally works ok.  I'm going to be tracking it down this
> morning, once I
> > get to work (1 hour).  I'm not sure if it is related to the AD1986a
> or the SCH
> > (gcap patch).
> 
> AD1986A has a known problem when you assign the single stream to
> multiple DACs.  But, we should have fixed this already in 1.0.16rc2.

If that's the case, then it isn't fixed as of yesterday's snapshot.  I
have brought in an ALC268 test board to replace the AD1986a.  I will
know real soon if this is the issue.



> 
> >  I do know that GCAP returns 2200 on this system, whereas a normal
> > ICH returns 4401.  The last bit may be significant (64bit vs 32bit
> stream).  I
> > need to reverify the SCH value, but this may be causing the issue.
> This is
> > critical for a launch coming up.
> 
> Hm, this bit hasn't been tested.  OK, we need a fix for that.
> (But I think OQO has no more than 4GB RAM, no?)
> 

This isn't for the OQO, this is for a new Intel platform.  And it will
market with 256M-1G memory.  If that bit is only for 64bit memory
addressing, then I'm not worried about it.  Sorry my earlier mail was
confusing.  I was getting ready for work and wanted to toss a quick
head's up.




-- 
Tobin Davis 


Most people feel that everyone is entitled to their opinion.
