From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] ALSA not using updated lseek locking
Date: Mon, 18 Feb 2002 21:12:31 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202182108080.509-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08099
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 21:13:40 +0100
In-Reply-To: <1014060111.935.2766.camel@phantasy>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Love <rml@tech9.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "torvalds@transmeta.com" <torvalds@transmeta.com>, "manfred@colorfullife.com" <manfred@colorfullife.com>
List-Id: alsa-devel@alsa-project.org

On 18 Feb 2002, Robert Love wrote:

> Manfred Spraul just pointed out to me that ALSA contains three lseek
> implementations, none of which use the new lseek locking rules.  While
> it is possible the ALSA people intended for there to be no locking (as
> in it not being needed), I suspect the recent change was overlooked.
>
> The lseek implementations are:
>
> 	sound/core/hwdep.c :: snd_hwdep_llseek
> 	sound/core/info.c :: snd_info_entry_llseek
> 	sound/isa/gus/gus_mem_proc.c :: snd_gf1_mem_proc_llseek
>
> snd_hwdep_llseek in hwdep.c clearly does not need locking.  I suspect
> the other two functions do.  The BKL seems the only available option.
>
> Please apply.

Sorry to reply too late, but I've not received this email before. It seems
that LKML has some trouble. Only the part of patch for sound/core/info.c
is valid, because llseek in gus_mem_proc.c is called from snd_info_entry_llseek(),
thus the function is already protected.

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
