From: ian <deviant@custard.org>
Subject: Re: delta-66 bug?
Date: Tue, 11 Mar 2003 00:11:43 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303110002030.11468-100000@rhubarb.custard.org>
References: <1047336591.21225.1.camel@eviltwin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1047336591.21225.1.camel@eviltwin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ah, thank you!
i updated to the latest non-cvs packages. things have got a bit better!
now if i set the clock to spdif, it stays locked to spdif. so the delta-66
driver is doing it's job. but now if i use xmms to play a stream through
pcm, the playback is too fast. (spdif sets the card to 48kHz, and xmms is
trying to open the pcm device at 44.1kHz). so it would seem there is a
problem with the oss layer - namely that it is not resampling the stream
from 44.1kHz to 48kHz.
or am i not reading the info on this page right?
http://www.alsa-project.org/~iwai/OSS-Emulation.html
thanks again!
ian


On 10 Mar 2003, Jan "Evil Twin" Depner wrote:

> Ian,
>
> 	I won't even attempt to figure out what you're doing but I wanted to
> point out that ALSA 0.9rc6 had major problems setting master clock for
> the envy24 chipset.  Try moving up to rc7 or rc8 and see if it gets
> better.
>
> Jan
>
> On Mon, 2003-03-10 at 16:42, ian wrote:
> > hi all,
> > i've been having sample rate problems with my m-audio delta 66. using
> > envy24control, i have it set up so that the master clock comes from spdif
> > (which is always 48K). the spdif is routed to hardware out 3 and 4. using
> > xmms with the oss output plugin, i'm playing a cd through pcm channels
> > 1&2, which are routed to hardware outs 1&2.
> > playing audio through spdif is fine, until i try to play using xmms too.
> > when i do that, the hardware outs 3&4 (where spdif is routed to) get
> > distorted.
> > xmms is requesting a sample rate of 44.1K when opening the device, and is
> > getting it, even though the master clock shuold be locked to spdif (rate
> > state has the locked option on). isn't the oss layer supposed to be
> > resampling the pcm input to 48K?
> > i'm using redhat 7.3, with alsa rc6, and a low latency & rtc patched
> > 2.4.19 kernel.
> > thanks,
> > ian
> >
> >
> >
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
