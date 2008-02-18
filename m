From: Travis Place <wishie@wishie.net>
Subject: Re: Problem with DELL XPS M1530
Date: Tue, 19 Feb 2008 04:02:20 +1000
Message-ID: <200802190402.20973.wishie@wishie.net>
References: <200802190242.07423.wishie@wishie.net>
	<s5hpruuus61.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id F234B24420
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 19:02:47 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id ACC635AB1D
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:23:44 +1000 (EST)
In-Reply-To: <s5hpruuus61.wl%tiwai@suse.de>
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

On Tue, 19 Feb 2008 2:48:38 am Takashi Iwai wrote:
> At Tue, 19 Feb 2008 02:42:07 +1000,
>
> Travis Place wrote:
> > Hi all,
> >
> > Been helping a user on #alsa for a day or two now, with issues regarding
> > recording from Mic on his Dell XPS M1530 laptop. He originally had
> > alsa-driver 1.0.14, so i had him upgrade to 1.0.16. Now, his Mic works
> > for recording, but he has lost playback on one of his HP jacks (the right
> > one), and Internal laptop speakers. I had a brief look at the code in
> > patch_sigmatel.c, to see what was going on.. But since im no code guru, i
> > wasnt much help..
> >
> > The output of alsa-info.sh is located at http://pastebin.ca/908579
> >
> > I did notice some comments in the code about correcting HP and Mic jacks
> > for certain models (atleast thats what I read it as).
> >
> > Any ideas would be appreciated.
>
> First of all, how about the latest HG version?  For lazy people who
> don't want to install mercurial, try the daily snapshot tarball.
>
> Let's start debugging after confirming that the bug still exists with
> the very latest code.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

User has installed the HG daily snapshot from the 17th, still has the same 
issues.

Just incase, their new alsa-info.sh output is at http://pastebin.ca/908695

Thanks in advance.


-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
