From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Tue, 20 Jan 2004 14:21:17 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074637277.6579.16.camel@moria.arnor.net>
References: <1074633766.6579.2.camel@moria.arnor.net>
	 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA31050
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 23:25:12 +0100
In-Reply-To: <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-01-20 at 14:09, Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Torrey Hoffman wrote:
> 
> > You may already know this, but the ice1712 driver doesn't work in Andrew
> > Morton's 2.6.1-mm? kernels which include the latest ALSA updates.
> >
> > 
> > Tested with an M-Audio Audiophile 24/96. 
> 
> What exactly does not work? I tested EWX 24/96 with mm3 and it works 
> pretty well.

In 2.6.1-mm5, which I'm running at the moment, I just get no sound
output.  No error messages.  The envy24control level meters don't show
any sound output.

2.6.1 vanilla works fine.  So does the 2.4 kernel that comes with Fedora
Core 1, using the latest ALSA driver sets from FreshRPMs.

I'm not the only one having problems with this driver in the latest ALSA
versions... on the ALSA development mailing list, Klaus-Peter Schrage
<kpschrage@gmx.de> told me today that he and others on the alsa-user
list have reported problems as well.

I'm very motivated to get this working, and am happy to apply patches,
recompile my kernel, or do anything else that would help debug the
problem.  


-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
