From: Travis Place <wishie@wishie.net>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_Added_support_to_HDAIntel?=
	=?iso-8859-1?q?_driver_for_the=09Foxconn_P35AX-S_mainboard?=
Date: Mon, 26 May 2008 23:39:53 +1000
Message-ID: <200805262339.53255.wishie@wishie.net>
References: <200805210012.02703.wishie@wishie.net>
	<200805262333.18391.wishie@wishie.net>
	<s5h7idh18xh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-089.dial.usertools.net [202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B22324663
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 15:43:22 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id C274266A4A
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 14:04:35 +1000 (EST)
In-Reply-To: <s5h7idh18xh.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 26 May 2008 11:39:22 pm Takashi Iwai wrote:
> At Mon, 26 May 2008 23:33:18 +1000,
>
> Travis Place wrote:
> > On Mon, 26 May 2008 9:04:03 pm Takashi Iwai wrote:
> > > At Wed, 21 May 2008 00:12:02 +1000,
> > >
> > > Travis Place wrote:
> > > > Without forcing model type to 6stack-dig, the user gets no sound.
> > > >
> > > > Patch is attached, and alsa-info.sh output is at
> > > > http://pastebin.ca/1023781.
> > > >
> > > > Changelog: Added IDs for the Foxconn P35AX-S mainboard to
> > > > patch_realtek.c, so that ALC883_6ST_DIG is used by default.
> > > >
> > > > Signed-off-by: Travis Place <wishie at wishie dot net>
> > >
> > > It's also in the upstream, too.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > Sorry for the 3 seperate posts Takashi..
>
> Don't worry, I just wanted to inform that these have been already
> merged.
>
> > Is it ok for me to unify the patches (in the future) and send 1 unified
> > changelog ? Or is it preferred that the patches(and thei changelogs) are
> > seperate ?
>
> Depends.  I prefer seperate patches as long as they belong to the same
> logical change.  The number of patches usually doesn't matter.
>
>
> BTW, it'd be appreciated if you add me to Cc so that I can pick up the
> patch immediately.
>
Noted, and will do this from now on.

Thanks again.
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
