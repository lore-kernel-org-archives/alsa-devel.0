From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: CVS changes, rc4 release in H-9
Date: Tue, 22 Oct 2002 13:14:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210221313250.521-100000@pnote.perex-int.cz>
References: <s5hlm4q3fpr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA32422
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 13:15:10 +0200
In-Reply-To: <s5hlm4q3fpr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Oct 2002, Takashi Iwai wrote:

> At Tue, 22 Oct 2002 12:46:19 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Tue, 22 Oct 2002, Takashi Iwai wrote:
> > 
> > > At Tue, 22 Oct 2002 11:14:39 +0200 (CEST),
> > > Jaroslav wrote:
> > > > 
> > > > Hi all,
> > > > 
> > > > 	I've applied a patch from Chris Rankin to fix module options for
> > > > core directory. Everything seems working on my side. I've added
> > > > explanation for module options to INSTALL file and added
> > > > alsa-driver/utils/module-options script for easy conversion to new names.
> > > > I'll release 0.9.0beta4 after 9 hours (if a critical bug doesn't appear).
> > > 
> > > I added a check to make install whether snd_ prefix is defined in the
> > > current module configuration.  Hopefully this works enough for tests.
> > > 
> > > Also, i've updated my alsaconf script, which now supports both with
> > > and without snd_ prefix.
> > > 
> > > 	ftp://ftp.suse.com/pub/projects/alsa/misc/alsaconf
> > > 
> > > It might take a couple of hours to be exported.
> > > If you need this script urgently, please let me know.
> > > 
> > > Or, this script can go into alsa-driver package, if many of you
> > > want...
> > 
> > Yep, please, commit it for more wide use...
> 
> ok, it's now on alsa-driver/utils.
> should it be installed to the public directory via "make install" ?

I don't think so. Perhaps, we might add a note for users to the INSTALL 
file.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576301;v?
http://www.sun.com/javavote
