From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 09:08:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
References: <1074633766.6579.2.camel@moria.arnor.net>
 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
 <1074637277.6579.16.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA08149
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 09:10:33 +0100
In-Reply-To: <1074637277.6579.16.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2004, Torrey Hoffman wrote:

> On Tue, 2004-01-20 at 14:09, Jaroslav Kysela wrote:
> > On Tue, 20 Jan 2004, Torrey Hoffman wrote:
> > 
> > > You may already know this, but the ice1712 driver doesn't work in Andrew
> > > Morton's 2.6.1-mm? kernels which include the latest ALSA updates.
> > >
> > > 
> > > Tested with an M-Audio Audiophile 24/96. 
> > 
> > What exactly does not work? I tested EWX 24/96 with mm3 and it works 
> > pretty well.
> 
> In 2.6.1-mm5, which I'm running at the moment, I just get no sound
> output.  No error messages.  The envy24control level meters don't show
> any sound output.
> 
> 2.6.1 vanilla works fine.  So does the 2.4 kernel that comes with Fedora
> Core 1, using the latest ALSA driver sets from FreshRPMs.

Can you try 2.6.1-rc1 with alsa-bk-2004-01-20.patch.gz available at our 
ftp site (/pub/kernel-patches)? It should fix your problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
