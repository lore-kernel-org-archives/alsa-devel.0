From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib linking problem
Date: Tue, 11 Mar 2003 19:21:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111917390.1352-100000@pnote.perex-int.cz>
References: <s5hbs0i2dga.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs0i2dga.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrei Boros <andrei@srr.ro>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Mar 2003, Takashi Iwai wrote:

> At Tue, 11 Mar 2003 15:58:44 +0200,
> Andrei Boros wrote:
> > 
> > Jaroslav Kysela wrote:
> > > 
> > > It looks like libtool problem. The 1.4.2 version is ok.
> > > 
> > 
> > I see configure doing this:
> > checking for versioned symbols... broken libtool - use libtool v1.4+; no
> > versions
> > 
> > Is this so critical? If not, linking should work fine given this
> > warning, or else configure should halt.
> 
> not too critical but i recommend you to update it than using too old
> version if the update is not difficult.
> 
> a workaroud is to pass --with-versioned=no to configure script, btw.

This workaround doesn't work. I'm working on this problem.

						Jaroslav

P.S. Problems in my list before 0.9.0final:

1) OSS seq emulator segfaults (seems some memory leak)
   - try alsa-driver/test/seq2 test utility to run several times
   - if you'll work on this problem ASAP, please drop an e-mail, otherwise
     I'm working on it
2) vxpocket drivers don't work with the dmix plugin (machine hangup)
   - I'll disable the dmix plugin for this card and solve problem later
3) alsa-lib - symbol versions
4) vmalloc_to_page() problem again

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
