From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Tue, 20 Sep 2005 16:21:33 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509201455140.23957-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.61.0509201430480.13414@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0509201430480.13414@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 19 Sep 2005, Takashi Iwai wrote:
> > > I would vote to keep the kernel space as simple as possible and give the
> > > whole contents to apps. They can implement reading/caching/filtering
> > > themselves.
> >
> > Agreed.

Too.

> Ok, good ideas. I would propose this final API:
>
> 1) one key with specific delimiters like:
>
> list		# list everything (all keys)
> list/master	# list only master keys (mixer, pcm etc.)
> list/mixer	# list only mixer keys
> list/pcm

This is _not_ a simple API.  AFAICS the idea was to have just one big
string/blob containing all descriptions, and to let the lib or
applications do the listing/searching/etc.

Accessing specific keys (elements) would be needed only if something
wasn't read only.

> 2) textual representation of values
>
> So, we need to describe the keys and value meaning and then implement it
> in the driver code.

The driver wouldn't need to implement much, except in cases like the
USB driver that has to derive this information from the USB
descriptors.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
