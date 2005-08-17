From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: proper suspend / resume for PCM streams
Date: Wed, 17 Aug 2005 11:48:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508171147190.9282@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
 <s5h8xz2xiiz.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161254410.9566@tm8103.perex-int.cz>
 <s5h64u6xhpc.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161315320.9566@tm8103.perex-int.cz>
 <s5h4q9qxgw4.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161328050.9566@tm8103.perex-int.cz>
 <1124204415.25596.1.camel@mindpipe> <s5hiry5wzv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 702BA210
	for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2005 11:48:06 +0200 (MEST)
In-Reply-To: <s5hiry5wzv6.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Aug 2005, Takashi Iwai wrote:

> Whether we should change the default behavior of snd_pcm_resume() at
> this stage -- I don't know.  Just providing a function like
> snd_pcm_handle_error(pcm, err) might suffice, though.

Yes, the function should be like xrun_recovery() in alsa-lib/test/pcm.c .

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
