From: "Jan \"Evil Twin\" Depner" <eviltwin69@cableone.net>
Subject: Re: delta-66 bug?
Date: 10 Mar 2003 16:49:50 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047336591.21225.1.camel@eviltwin>
References: <Pine.LNX.4.44.0303072137400.11402-100000@rhubarb.custard.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303072137400.11402-100000@rhubarb.custard.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ian <deviant@custard.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ian,

	I won't even attempt to figure out what you're doing but I wanted to
point out that ALSA 0.9rc6 had major problems setting master clock for
the envy24 chipset.  Try moving up to rc7 or rc8 and see if it gets
better.

Jan

On Mon, 2003-03-10 at 16:42, ian wrote:
> hi all,
> i've been having sample rate problems with my m-audio delta 66. using
> envy24control, i have it set up so that the master clock comes from spdif
> (which is always 48K). the spdif is routed to hardware out 3 and 4. using
> xmms with the oss output plugin, i'm playing a cd through pcm channels
> 1&2, which are routed to hardware outs 1&2.
> playing audio through spdif is fine, until i try to play using xmms too.
> when i do that, the hardware outs 3&4 (where spdif is routed to) get
> distorted.
> xmms is requesting a sample rate of 44.1K when opening the device, and is
> getting it, even though the master clock shuold be locked to spdif (rate
> state has the locked option on). isn't the oss layer supposed to be
> resampling the pcm input to 48K?
> i'm using redhat 7.3, with alsa rc6, and a low latency & rtc patched
> 2.4.19 kernel.
> thanks,
> ian
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
