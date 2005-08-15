From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-utils ChangeLog,1.3,1.4
 Makefile.am,1.33,1.34 configure.in,1.107,1.108
Date: Mon, 15 Aug 2005 14:43:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508151442560.9682@tm8103.perex-int.cz>
References: <E1E3yrb-0001Ke-Jk@sc8-pr-cvs1.sourceforge.net>
 <42FE22E8.4040406@superbug.co.uk> <s5hr7cv1igk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7cv1igk.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, James Courtier-Dutton <jcdutton@users.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Aug 2005, Takashi Iwai wrote:

> At Sat, 13 Aug 2005 17:42:16 +0100,
> James Courtier-Dutton wrote:
> > 
> > Hum. This seems wrong. Even after checking this in, ./cvscompile changes 
> > them all again!
> > I must have broken build tools.
> 
> Better not to touch these fiels on CVS tree.  Or, we may put them in
> .cvsignore.  Every cvscompile replaces anyway with its own system
> files.

Do we need to have these files in CVS at all? If they're auto-generated, 
they should be removed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
