From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA in 2.5.x
Date: Wed, 2 Oct 2002 17:56:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210021756350.653-100000@pnote.perex-int.cz>
References: <200210021628.13742@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210021628.13742@advent.drealm.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter L Jones <peter@drealm.org.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Oct 2002, Peter L Jones wrote:

> On Wednesday 02 Oct 2002 11:44, Jaroslav Kysela wrote:
> [snip]
> >
> > ALSA tree was fully synced with kernel yesterday. Not all changes are in
> > 2.5.40. Please, wait for 2.5.41 or get the kernel sources from BitKeeper
> > repository of 2.5.
> >
> > 						Jaroslav
> >
> 
> Jaroslav,
> 
> I've patched up to 2.5.40bk1 snapshot and I'm about to give ALSA a quick try.
> 
> RTC Timer Support is greyed out for me in xconfig -- it's not marked 
> "EXPERIMENTAL" in the display (I've not got as far as turning experimental on 
> yet) and the help text doesn't say it relies on any other option.  Is this a 
> config problem?

Yes, you need to select RTC timer code in other menu (CONFIG_RTC) at 
first.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
