From: Albert Jongkit Wong <awong@cs.washington.edu>
Subject: Re: ppc usb-audio problems
Date: Sat, 12 Oct 2002 02:55:38 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021012025021.H21894-100000@fiji.cs.washington.edu>
References: <s5hk7kpchz3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7kpchz3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

> ah, perhaps xmms alsa plugin doesn't care the endianess.
> if so, it's a bug of alsa output plugin.

I started hacking at the code.  It looks like the xmms alsa plugin is fine 
(if a bit messy).  However, it looks like their mpg123 input plugin is 
always output big-endian data even when it says it is outputing the native 
format data...hrm...  I'm not sure if that was intentional or not.  In 
either case, it's their bug so I'm bugging them about it now.
 
> hmm, most likely the same reason.
> esd requests big-endian formats (as native machine format), which are
> not supported on usb devices.
> try to use the pcm 'plughw:0,0' instead of 'hw:0,0'.
> (well, iirc, there is a bug in esound alsa output.  the command-line
>  option is never passed as the device...)

I tried esd -d plughw:0,0 and it worked over here.  Is it more proper to
communicate to alsa through plughw rather than hw?  It sounds like this
interface is the smarter way to go...  I'm hesitating before suggesting 
this to esound or mplayer since I'd rather not suggest something wrong.

Thanks for helping me with this problem.  My system's working great now. 
:)

-Albert



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
