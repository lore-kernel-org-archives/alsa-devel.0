From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: why do elements disappear?
Date: Wed, 16 Feb 2005 13:31:23 +0100
Message-ID: <m2650sptyc.fsf@vador.mandrakesoft.com>
References: <1108501973.2845.87.camel@tux.lan> <s5hll9obxar.wl@alsa2.suse.de>
	<m2r7jgpvw9.fsf@vador.mandrakesoft.com> <s5hd5v0bu2d.wl@alsa2.suse.de>
	<m2ekfgpur7.fsf@vador.mandrakesoft.com> <s5h8y5obt52.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5h8y5obt52.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 16 Feb 2005 13:12:41 +0100")
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > > They are slightly different problems.  I guess it's indeed a bug
> > > of alsa-lib, which was fixed recently on CVS.
> > 
> > could you point to the relevant fix?
> > 
> 
> alsa-lib/src/mixer/mixer.c:
> 
> 	revision 1.70
> 	date: 2005/02/04 19:18:49;  author: tiwai;  state: Exp;  lines: +2 -2
> 	Summary: Use bag_for_each_safe() for event handling loop
> 
> 	Use bag_for_each_safe() for event handling loop.
> 	Event callbacks may be destructive.

thanks



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
