From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Wed, 21 Sep 2005 10:02:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509210954590.12389@tm8103.perex-int.cz>
References: <Pine.HPX.4.33n.0509201455140.23957-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509201455140.23957-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Sep 2005, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
> > On Mon, 19 Sep 2005, Takashi Iwai wrote:
> > > > I would vote to keep the kernel space as simple as possible and give the
> > > > whole contents to apps. They can implement reading/caching/filtering
> > > > themselves.
> > >
> > > Agreed.
> 
> Too.
> 
> > Ok, good ideas. I would propose this final API:
> >
> > 1) one key with specific delimiters like:
> >
> > list		# list everything (all keys)
> > list/master	# list only master keys (mixer, pcm etc.)
> > list/mixer	# list only mixer keys
> > list/pcm
> 
> This is _not_ a simple API.  AFAICS the idea was to have just one big
> string/blob containing all descriptions, and to let the lib or
> applications do the listing/searching/etc.
> 
> Accessing specific keys (elements) would be needed only if something
> wasn't read only.

You need also take in account that keys might be added/removed at runtime.
The question is still to have:

1) manager code in the midlevel to register keys from drivers and do 
   lookups; in this case the drivers will register the keys
2) leave things simple for midlevel and the ioctl will be directly mapped 
   to the driver code (the blob version of ioctl); in this case the driver 
   must handle all things like memory allocation, key changes etc.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
