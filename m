From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: do apps need to care for xfer_align ???
Date: Mon, 9 Sep 2002 16:14:39 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209091613540.10104-100000@gate.perex.cz>
References: <20020906194926.38406.qmail@web11501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07032
	for <alsa-devel@alsa-project.org>; Mon, 9 Sep 2002 16:14:49 +0200
In-Reply-To: <20020906194926.38406.qmail@web11501.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Sep 2002, Guilhem Tardy wrote:

> Hi all,
> 
> While trying to understand snd_pcm_lib_write1(), I found that
> runtime->xfer_align is set to period_size in pcm_native.c, but wonder if it is
> just a default?
> 
> Paul Davis' example (at http://www.op.net/~pbd/alsa-audio.html#playex) doesn't
> check for a particular transfer size, and my card supports playout of less than
> 160 samples (i.e. the period size). Thus, I set to try playing out 512 bytes at
> a time (i.e. 2048 samples of 2-bit ADPCM), which does NOT come to a multiple of
> period size. The result is that only 1920 samples are played, and my app thinks
> an error has occured.
> 
> Is it a general requirement for apps to send only audio in multiple of the
> period size?

Nope, applications might modify xfer_align to satisfy their requirements.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA project  http://www.alsa-project.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
