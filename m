From: Ivica Bukvic <ico@fuse.net>
Subject: Re: What is the current status of the alsa sound
	server (signal polling)?
Date: 19 Apr 2002 11:52:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1019231568.20499.5.camel@meowing.memh.uc.edu>
References: <Pine.LNX.4.43.0204191600020.775-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from meowing.ccm.uc.edu (meowing.memh.uc.edu [129.137.2.219])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA06597
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 17:46:40 +0200
In-Reply-To: <Pine.LNX.4.43.0204191600020.775-100000@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: joy ping <joy@pingfm.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for your reply. However, a while ago Paul Davis mentioned
there was a "share" device that could potentially be used for this
purpose (see:
http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg02201.html
), but I am not sure as to how to use it (and whether it is useful at
all for this purpose). I also know that there is a framework for a
sound-server burried somewhere deep in the Alsa code, but do not know as
to how complete it is. But, I would appreciate any info I can get from
you (or anyone else regarding asoundrc file), as well as additional info
regrading polling abilities with the soundcards that have lousy drivers
due to lack of documentation and/or questionable hardware and are
therefore unable to provide me with the hardware mixing.

Thank you!

Ico



On Fri, 2002-04-19 at 10:03, joy ping wrote:
> hi,
> 
> im working on a kind of asoundrc-mini-howto, if you are interested in i
> can send you a pre-version. as i know, polling is not supported with alsa,
> and its not configurable at runtime.
> 
> ____
> joy
> 
> On Fri, 19 Apr 2002, Ivica Bukvic wrote:
> 
> > Hi all! A while ago I was inquiring about the current status of the
> > .asoundrc documentation, as well as the feasibility of creating "mock"
> > devices that would allow polling of the audio i/o resources of the
> > soundcard whose driver's limitations and/or hardware limitations
> > currently do not support hardware polling.
> >
> > I am just wondering if anyone had any luck in figuring out how to do
> > that using .asoundrc and whether that is even possible at this point.
> >
> > Also, what is the current status of gstreamer in this department and
> > jack? (I tried artsd and that one simply doesn't cut it)
> >
> > Any info on this issue would be utmostly appreciated!
> >
> > Ico
> >
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >
> 
