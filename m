From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: "plug" PCM device has odd default behaviour
Date: Thu, 14 Mar 2002 08:13:06 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203140811570.532-100000@pnote.perex-int.cz>
References: <200203132144.g2DLiaP01978@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA22822
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2002 08:14:58 +0100
In-Reply-To: <200203132144.g2DLiaP01978@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Mar 2002, Paul Davis wrote:

> so, you all know jack, i'm sure.
> 
> when jack is used with a "plug" PCM device, we end up with duplicated
> channel data even on a 2 channel device. using mmap access, everything
> we write to the channel area for channel 0 shows up on both channel 0
> and channel 1. i don't understand how this could happen. any clues on
> what i should start looking for? my first guess is that the channel
> addresses supplied for mmap access are wrong/duplicated (i haven't
> tried debugging yet).

Please, could you call 'snd_pcm_dump()' after initialization of 
parameters and show me result? I need to know plugin details to help you.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
