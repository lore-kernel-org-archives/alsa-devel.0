From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Tue, 18 Feb 2003 14:19:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302181418580.1186-100000@pnote.perex-int.cz>
References: <1045573835.3e5230cbefb7d@webmail.namezero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045573835.3e5230cbefb7d@webmail.namezero.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslaw Sobierski <fycio@gucio.com>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Feb 2003, Jaroslaw Sobierski wrote:

> Quoting Jaroslav Kysela:
> [...]
> > > 
> > > 	v = *src;
> > > 	if (cmpxchg(hw, 0, 1) == 0)
> > > 		v -= *sw;
> > >         xadd(sw, v);
> > >         do {
> > >                 v = *sw;
> > >                 if (v > 0x7fff)
> > >                         s = 0x7fff;
> > >                 else if (v < -0x8000)
> > >                         s = -0x8000;
> > >                 else
> > >                         s = v;
> > 
> > A bit correction (we have to avoid zero results in hw buffer):
> > 
> > 		  else if (v == 0)
> > 			s = 1;
> > 		  else
> > 			s = v;
> > 
> 
> Why?! It's like I've written yesterday : even if the outcoming sample
> is zero, we can still treat the hw buffer as cleared. It makes no
> difference whether it was reset by the driver or the samples just
> added up to zero. If we have zero in the hw not because of a reset
> we must also have 0 in sw, so the clearing code will have no effect.

Thanks for correction.. Some things are not visible at first glance.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
