From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Tue, 18 Feb 2003 17:51:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302181751010.1636-100000@pnote.perex-int.cz>
References: <E18l95Q-0007Hv-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18l95Q-0007Hv-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Feb 2003, Paul Davis wrote:

> >> 	v = *src;
> >> 	if (cmpxchg(hw, 0, 1) == 0)
> >> 		v -= *sw;
> >>         xadd(sw, v);
> >>         do {
> >>                 v = *sw;
> >>                 if (v > 0x7fff)
> >>                         s = 0x7fff;
> >>                 else if (v < -0x8000)
> >>                         s = -0x8000;
> >>                 else
> >>                         s = v;
> >
> >A bit correction (we have to avoid zero results in hw buffer):
> >
> >		  else if (v == 0)
> >			s = 1;
> >		  else
> >			s = v;
> >
> >>                 *hw = s;
> >>         } while (unlikely(v != *sw));
> 
> help me out here. is this the code path that has be followed to write
> a single sample to the buffer?

Yes, this code updates one sample in the hardware buffer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
