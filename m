From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Thu, 19 Sep 2002 17:16:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209191716350.6991-100000@pnote.perex-int.cz>
References: <s5h3cs6qag7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cs6qag7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Sep 2002, Takashi Iwai wrote:

> At Thu, 19 Sep 2002 17:06:08 +0200 (CEST),
> Tim Goetze wrote:
> > 
> > much simpler. you did a c++ style auto variable allocation, declare
> > 'ak' at the start of snd_ice1712_ews_init and it compiles cleanly.
> 
> oops, never noticed that.  i relied too much upon the compiler.
> well, this means that gcc-3.2 accepts this style as normal C...?
> 
> will be fixed once when cvs server is repaired.

CVS works now.

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
