From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [linux-audio-dev] Re: Forcing an absolute timestamp
 for every midi event.
Date: Mon, 19 Aug 2002 09:52:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208190951430.521-100000@pnote.perex-int.cz>
References: <002b01c2474b$ec3c0170$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA16827
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 09:53:58 +0200
In-Reply-To: <002b01c2474b$ec3c0170$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Frank van de Pol <fvdpol@home.nl>, "linux-audio-dev@music.columbia.edu" <linux-audio-dev@music.columbia.edu>, Juan Linietsky <coding@reduz.com.ar>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Aug 2002, Martijn Sipkema wrote:

> [...]
> > Is there already a commonly available UST on linux? To my knowledge the
> only
> > thing that comes close is the (cpu specific) cycle counter.
> 
> No, not yet. I think we should try to get hard- or firm-timers and POSIX
> CLOCK_MONOTONIC into the Linux kernel.

I agree. I'm willing to help with implementation when time permits.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
