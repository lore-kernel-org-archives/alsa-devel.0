From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Patch for AOSS
Date: Tue, 5 Apr 2005 13:00:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504051257580.6497@pnote.perex-int.cz>
References: <pan.2005.04.04.16.38.04.98290@navi.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <pan.2005.04.04.16.38.04.98290@navi.cx>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mike Hearn <mike@navi.cx>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Apr 2005, Mike Hearn wrote:

> Hi,
> 
> The following patch makes SOX work with the "aoss" program.

Thanks. Applied to CVS.

> Unfortunately I originally wanted aoss for a game, zap!
> (www.zapthegame.com) so I could listen to music using XMMS at the same
> time as playing, but aoss+dmix introduces far too much latency for that.
> It's on the order of a second or two for some reason. Do you know of any
> fix?

You may try to force some lower values in SNDCTL_DSP_SETFRAGMENT
(alsa-oss/alsa/pcm.c). It seems that the OSS ring buffer is too large.
Perhaps, having an environment variable allowing to force the ring buffer 
size would be nice.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
