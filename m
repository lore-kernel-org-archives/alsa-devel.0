From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Fri, 21 Mar 2003 18:11:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303211810350.2699-100000@pnote.perex-int.cz>
References: <s5hbs04ri0w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs04ri0w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Mar 2003, Takashi Iwai wrote:

> At Fri, 21 Mar 2003 13:56:50 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Fri, 21 Mar 2003, Patrick Shirkey wrote:
> > 
> > > Fernando Pablo Lopez-Lezcano wrote:
> > > > 
> > > > It would be nice that the user not need to type magic numbers into a
> > > > configuration file, unique or not. I don't know what it involves, but it
> > > > would make using the configuration file much easier. 
> > > > 
> > > 
> > > Even nicer is if this could be embedded like the dmix was eventually so 
> > > that it is unnecessary to use the .asoundrc :)
> > 
> > It's a little problematic to add dshare to the global configuration file. 
> 
> it would be cool if we have the dynamic voice-assignment function in
> dshare...  just a thought.

Can you elaborate more? How we can predict if user want the first two 
(analog) or last two (s/pdif) channels from 10 in the ice1712 case?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
