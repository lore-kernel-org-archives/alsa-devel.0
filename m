From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Another alsa newbie seeks help
Date: Mon, 15 Sep 2003 19:37:51 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309151936090.24294-100000@studcom.urz.uni-halle.de>
References: <1063591377.3330.29.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1063591377.3330.29.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sol <science@foxinternet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sol wrote:
> I have been using the example "pcm.c" in the alsa-lib/test directory to
> learn about alsa and my soundcard(audiophile 2496 ice1712).
>
> I have found something strange that I do not understand.
> async_direct(mmap) method will produce no sound for my card.  However,
> if I change the format to S32_LE in pcm.c and first specify 10 channels
> using async method- then I get sound when I use the async_direct method
> afterwards.
>
> If I haven't confused myself writing this, it looks like this:
>
> ./pcm -c 10 -m async_direct
> Playback device is plughw:0,0

This uses the plug plugin, which does all kinds of intelligent or
"intelligent" conversions. Please try to use hw:0,0 directly.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
