From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding a new architecture to alsa-driver
Date: Sun, 09 Apr 2006 13:26:06 +0100
Message-ID: <1144585566.9248.5.camel@localhost.localdomain>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
	 <1144544652.22490.181.camel@mindpipe>
	 <1144579821.9248.0.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0604091315410.22163@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0604091315410.22163@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-09 at 13:24 +0200, Jaroslav Kysela wrote:
> On Sun, 9 Apr 2006, Adrian McMenamin wrote:
> 
> > On Sat, 2006-04-08 at 21:04 -0400, Lee Revell wrote:
> > > On Sun, 2006-04-09 at 01:23 +0100, Adrian McMenamin wrote:
> > > > The changes you suggest simply are inadequate. There is no makefile
> > > > without configure and even though I have managed to patch the
> > > > configure
> > > > file so it will create a Makefile, a make simply builds the alsa core
> > > > and doesn't touch the sh sub directory despite having this in the
> > > > makefile:
> > > > 
> > > 
> > > Did you patch alsa-driver/configure.in?
> > > 
> > > $ grep CONFIG_PARISC configure.in 
> > > #elif defined(CONFIG_PARISC)
> > > AC_SUBST(CONFIG_PARISC)
> > > 
> > > I don't know autoconf well enough to know exactly what this is doing but
> > > it seems like you could just copy/paste and s/PARISC/SUPERH/...
> > > 
> > 
> > I had to patch it in about 6 or 7 places and that was one of them
> 
> Do you have a valid Kconfig file with your driver? The dependencies are 
> parsed from Kconfig files.
> 
Yes, though I have put it in alsa-kernel for the build as Lee suggested
(the writing a driver document doesn't say that though)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
