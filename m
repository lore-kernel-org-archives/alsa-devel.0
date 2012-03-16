From: "Christian Esken (KDE)" <esken@kde.org>
Subject: Re: amixer shows capability "penum" on every Simple
 mixer	control
Date: Fri, 16 Mar 2012 21:18:22 +0100
Message-ID: <1331929102.4795.18.camel@linux-lfdh>
References: <2e03711055eba5b923f1983b3e7d6f1a@barbarenland.de>
	<s5h1uown7ze.wl%tiwai@suse.de> <s5h1uow39ul.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net
	[151.189.21.58]) by alsa0.perex.cz (Postfix) with ESMTP id 373D5243B3
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 21:18:18 +0100 (CET)
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net
	[151.189.8.29]) by mx.arcor.de (Postfix) with ESMTP id C5B5B3DC485
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 21:18:17 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id B64641DF1AA
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 21:18:17 +0100 (CET)
Received: from [192.168.2.111] (dslb-092-072-202-042.pools.arcor-ip.net
	[92.72.202.42])
	by mail-in-10.arcor-online.net (Postfix) with ESMTPS id 8CEA22D6D35
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 21:18:17 +0100 (CET)
In-Reply-To: <s5h1uow39ul.wl%tiwai@suse.de>
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

Am Dienstag, den 13.03.2012, 14:32 +0100 schrieb Takashi Iwai:
> At Tue, 13 Mar 2012 10:52:21 +0100,
> Takashi Iwai wrote:
> > 
> > At Mon, 12 Mar 2012 22:09:35 +0100,
> > Christian Esken (KDE) wrote:
> > > 
> > >  Hello,
> > > 
> > >  when I run amixer it shows the capability "penum" on nearly every 
> > >  Simple mixer control.
> > >  I posted the bug report 
> > >  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 , but 
> > >  Raymond asked me to report it on this mailing list ("as it is related to 
> > >  this patch 6d511eefa05878abee9f8b9145697230de605200 Implements support 
> > >  for capture/playback enums.").
> > > 
> > >  I posted  details for the following two examples in 
> > >  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 :
> > > 
> > >  1) "Creative X-Fi" does not have any Enum's. alsamixer does not show 
> > >  Enums's. amixer lists "penum" for ALL Simple mixer controls.
> > > 
> > >  2) "HDA ATI SB" has no penum's, only 3 cenum's. alsamixer shows it 
> > >  correctly, but amixer disagrees and shows penum for NEARLY ALL Simple 
> > >  mixer controls (except for those with cpability "cenum").
> > > 
> > > 
> > >  I found this as I received several bug reports for KMix with "absurd" 
> > >  amixer output. I could perceive from those bug report that the bug is 
> > >  affecting a lot (or all?) sound cards.
> > 
> > Looks like a bug in alsa mixer abstraction, indeed.
> > Will take a look at it later.
> 
> I committed the fix to git tree now.  The fix patch is below.
> 

I compiled and installed the alsa-lib from git, and the existing old
executable (1.0.24.2 from openSUSE 12.1) now shows the correct values. I
also tested with amixer from git, and it also works for me.

Thanks for the quick fix.

   Christian
