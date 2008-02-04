From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - AD1986a issues.
Date: Mon, 04 Feb 2008 08:38:10 -0800
Message-ID: <1202143090.28351.33.camel@razman.gruemaster.com>
References: <1201822394.23369.108.camel@razman.gruemaster.com>
	<s5hejbw3mc8.wl%tiwai@suse.de>
	<1201878104.24072.22.camel@razman.gruemaster.com>
	<s5hmyqk1zh0.wl%tiwai@suse.de>
	<1201906655.24072.69.camel@razman.gruemaster.com>
	<s5h8x203g21.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id A41B7103885
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 17:38:14 +0100 (CET)
In-Reply-To: <s5h8x203g21.wl%tiwai@suse.de>
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


On Mon, 2008-02-04 at 16:19 +0100, Takashi Iwai wrote:

> At Fri, 01 Feb 2008 14:57:35 -0800,
> Tobin Davis wrote:
> > 
> > On Fri, 2008-02-01 at 16:13 +0100, Takashi Iwai wrote:
> > 
> >     > Also, I had some very strange audio garbage with the tip on an HD Audio
> >     platform
> >     > that normally works ok.  I'm going to be tracking it down this morning,
> >     once I
> >     > get to work (1 hour).  I'm not sure if it is related to the AD1986a or the
> >     SCH
> >     > (gcap patch).
> >    
> >     AD1986A has a known problem when you assign the single stream to
> >     multiple DACs.  But, we should have fixed this already in 1.0.16rc2.
> > 
> > Ok, I can confirm on my test system that the HDA-GCAP and HDA-SCH patches are
> > ok.  I tested them on 1.0.15 with an AD1986a and they work fine.  Same system
> > with HG20080130 is aweful.  I'm trying to revert the patch_analog patches one at
> > a time to see which one is the problem.
> 
> Did you find out the problem?  I vaguely remember that EAPD may play a
> bad role for headphones.  This should be disabled except for the
> speaker output.

The problem I noticed only occurred on my SCH based system.  It was
solved with the snoop bit check/set.  I'll double check to see if I have
any issues on my laptop (Asus Z62F w/ ad1986a - model=laptop-eapd).

Oddly enough, the system worked fine with 1.0.15 and the two earlier
patches (GCAP and SCH PCI IDS).  Not sure what to make of that.  I'll do
more testing today.

> 
> >     >  I do know that GCAP returns 2200 on this system, whereas a normal
> >     > ICH returns 4401.  The last bit may be significant (64bit vs 32bit
> >     stream).  I
> >     > need to reverify the SCH value, but this may be causing the issue.  This
> >     is
> >     > critical for a launch coming up.
> >    
> >     Hm, this bit hasn't been tested.  OK, we need a fix for that.
> > 
> > No need to worry about this bit I guess.  It may only be relevant on a system
> > that runs 64bit OSes, and I'd assume that bit doesn't exist for systems that
> > can't.
> 
> The fix itself would be pretty easy.  Check this bit and reset the dma
> consistent mask to 32bit if it's 32bit only.
> 
> Hm, this reminds me that we should call set_mask with 64bit as
> default.  Needs more investigation...

Is this dependent on system/OS?  My thought was it was for supporting
x86-64 architecture.  That being the case, it should be added to the
TODO list, but not critical for 1.0.16 release.  

Actually, there are other potential issues that I noticed with regards
to GCAP and our current usage.  For example, bi-directional stream
support and number of serial data out signals.  Both are hardwired in
the ICH family of chipsets, but for how long?


-- 
Tobin Davis 


Better dead than mellow.
