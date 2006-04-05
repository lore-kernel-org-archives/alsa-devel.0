From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa cvs broken
Date: Wed, 5 Apr 2006 13:05:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604051257130.27263@tm8103.perex-int.cz>
References: <44310468.6080303@superbug.co.uk> <s5hr74ec174.wl%tiwai@suse.de>
 <44311356.1000108@superbug.co.uk> <Pine.LNX.4.61.0604031438430.9509@tm8103.perex-int.cz>
 <s5hlkumbz1t.wl%tiwai@suse.de> <Pine.LNX.4.61.0604031458460.9509@tm8103.perex-int.cz>
 <443147CC.40905@keyaccess.nl> <s5hpsjyab57.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsjyab57.wl%tiwai@suse.de>
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
Cc: Rene Herman <rene.herman@keyaccess.nl>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Apr 2006, Takashi Iwai wrote:

> > GIT is also still picking up speed. Keith Packard was even converting X 
> > CVS for example. Mercurial might be good I guess, but it's also very 
> > likely going to be one of those "oh no, not yet another" ones, maybe 
> > even keeping potential developers away.
> 
> We can anyway provide a nightly tarball for lazy developers :)
> Let's evaluate both first.

Note that most of other developers are sending us standard unified diffs 
(and this way will remain). If you use internally for development GIT
or HG is another thing. We will maintain the ALSA GIT tree as well for the 
kernel development, but our code is not only kernel code.

After one day experience with HG I must say that I'm quite happy and the 
commands are far more intuitive and simple than git. The big plus is 
ability to use the mercurial python module directly for advanced 
scripting (like ALSA HG -> ALSA GIT conversion).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
