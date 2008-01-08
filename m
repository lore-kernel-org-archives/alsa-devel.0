From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver - PCM MMAP mode timestamps
Date: Tue, 8 Jan 2008 12:24:31 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081215400.22730@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0801081031240.22730@tm8103.perex-int.cz>
	<s5hprwc7f7v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EBEEF24AB0
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 12:24:31 +0100 (CET)
In-Reply-To: <s5hprwc7f7v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Jan 2008, Takashi Iwai wrote:

> At Tue, 8 Jan 2008 10:45:34 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	it seems that we have another inconsistency with PCM MMAP mode
> > timestamps. If I read code correctly, snd_pcm_status() returns timestamp 
> > from last interrupt BUT updates hw_ptr to current (calling 
> > snd_pcm_update_hw_ptr() again).
> > 	It means, that application will get unrelated timestamp to 
> > hw position returned in snd_pcm_status() in case of mmap mode. I don't see 
> > any way to use this timestamp now.
> > 	To fix this issue, I would like to create a next status ioctl 
> > which will return only mmap timestamp plus last related interrupt ring 
> > buffer position and remove 'if (runtime->tstamp_mode == 
> > SNDRV_PCM_TSTAMP_MMAP)' condition from snd_pcm_status() in driver 
> > completely.
> > 	Any opinion? Other idea?
> 
> It'd be OK to remove the tstamp_mode check there.  It was newly added
> after discussions.  We are still in the development phase about this,
> and removing is no regression.
> 
> However, I'm against adding new ioctls.  The same thing can be simply
> done by reading the mmapped status struct, as snd_pcm_hw_fast_tstamp()
> in alsa-lib pcm_hw.c.  If the mmaped status isn't available, it can
> fallback to the normal snd_pcm_status().

You're right. I forgot on mmaped status and PCM_IOCTL_SYNC_PTR for 
non-mmap architectures.

> The real problem is that the behavior of TSTAMP_MMAP isn't strictly
> defined.  It's just a TSTAMP_NORMAL in the end unless the new if check
> there.  I think we may get rid of this mode if the tstamp via mmap is
> available.

Actually, after condition removal, TSTAMP_MMAP will just enable 
timestamping in interrupt update. No other tests are in the driver.
I commited change to HG.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
