From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: new pcm format(s)
Date: Thu, 22 Aug 2002 07:37:42 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020822143742.83136.qmail@web11505.mail.yahoo.com>
References: <s5hfzx7t5ga.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11505.mail.yahoo.com (web11505.mail.yahoo.com [216.136.172.37])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA18474
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 16:37:50 +0200
In-Reply-To: <s5hfzx7t5ga.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > Anyway, I found out that there's not so much space left for more formats.
> 
> the space must be enough.  at the last change of hw_params struct, we
> extended the space for the sample format.

Indeed, I managed to build RC3 at last (I'll port all my stuff to RC3 over the
WE) and found out that the SNDRV_PCM_FMTBIT_ are now defined as 64-bit unsigned
integers. But I think it would be worthwhile in the long run to use subformats.

> > Therefore, I added one for G726 and started adding subformats (a field that
> > was unused until now). This also means that I need to update the function
> > snd_pcm_format_width() in order to deal with subformats.
> 
> yes.
> if you finished, please send the patch.
> the patch is always welcome.

I built the ALSA framework (RC2) with those changes, but then all drivers must
be updated (e.g. dummy.c at line 207) to call snd_pcm_format_width() with 2
parameters: the format AND the subformat. Is this something you think would be
possible?

Guilhem.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
