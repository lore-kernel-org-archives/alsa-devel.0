From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: struct _snd_pcm_hardware
Date: Fri, 30 Aug 2002 17:53:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208301751380.749-100000@pnote.perex-int.cz>
References: <20020829205716.2839.qmail@web11502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA11360
	for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2002 17:53:39 +0200
In-Reply-To: <20020829205716.2839.qmail@web11502.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Aug 2002, Guilhem Tardy wrote:

> Hi,
> 
> I have a problem with supporting multiple audio formats in that my hardware
> defines its buffers in a number of frames rather than bytes.
> 
> I evaluated the changes required to support description of a hardware's
> period contraints in frame AND bytes. Essentially, this would mean
> adding 'size_t period_size_min' and 'size_t period_size_max' to the
> stucture _snd_pcm_hardware in pcm.h, and then add a constraint in
> snd_pcm_hw_constraints_complete() in pcm_native.c such that the period
> size is within those min and max values. Other drivers wouldn't be
> affected if the period_size_min/max default values are properly chosen
> (i.e. 0 and MAX_UINT, respectively).
> 
> Would you consider such a change in the ALSA code base?

Wouldn't be better to add such constraint to your code in open() 
callback? This constraint is not used frequently.

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
