From: Paul Davis <pbd@op.net>
Subject: Re: under-runs and prepare()
Date: Tue, 10 Sep 2002 12:20:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209101617.SAA29132@alsa.alsa-project.org>
References: <20020910160514.63169.qmail@web11507.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA29132
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 18:17:55 +0200
In-reply-to: Your message of "Tue, 10 Sep 2002 09:05:14 PDT."
             <20020910160514.63169.qmail@web11507.mail.yahoo.com>
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

>I understand that prepare() is used to restart playout or capture from a known
>state in the driver, and wonder if it is OK to have it block until buffers
>being currently played out have completed?

are you asking if a low level driver should do this? if so, then the
answer is no. the semantics of snd_pcm_prepare() assume that it takes
effect immediately. the app should use snd_pcm_drain() if they want to
wait for existing data to be played.

>This came up because our app is experiencing -EPIPE quite often, most likely
>because real-time audio is being played out immediately without the least
>buffering by the app. Any advice is most welcome regarding this issue.

EPIPE means an xrun happened. it means your app wasn't keeping up with
the hardware.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
