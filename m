From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: autoheader and autoconf issues
Date: Mon, 7 Oct 2002 12:31:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021007103130.GE21898@tuba.home>
References: <200210051334.JAA23819@bromo.msbb.uc.edu> <s5h7kgu4leq.wl@alsa2.suse.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7kgu4leq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, howarth@bromo.msbb.uc.edu
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 07, 2002 at 12:02:05PM +0200, Takashi Iwai wrote:
> At Sat, 5 Oct 2002 09:34:00 -0400 (EDT),
> Jack Howarth wrote:
> > 
> > howarth@bogus:~/alsacvs/alsa-lib$ ./cvscompile
> > /usr/bin/autoheader2.13: Symbol `VERSION' is not covered by /usr/share/autoconf2.13/acconfig.h
> > automake: configure.in: installing `./install-sh'
> > automake: configure.in: installing `./mkinstalldirs'
> > automake: configure.in: installing `./missing'
> > configure.in: 85: required file `include/config.h.in' not found
> > 
> > If I edit both of the cvscompile scripts in alsa-lib and alsa-utils so
> > that they explicitly call autoheader2.50 and autoconf2.50, then this
> > works fine...
> > 
> > autoheader2.50: `include/config.h.in' is created
> > 
> 
> i get acconfig.h back to the tree so that the old autoheader should
> work.  please give a try.
> 

Thanks, Takashi.

I've had the same problem. Now it compiles fine again.


martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
