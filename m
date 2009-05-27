From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm - Safer
 boundary checks"
Date: Wed, 27 May 2009 09:25:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905270912240.4067@eeebox2.perex-int.cz>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
	<s5hk547el2j.wl%tiwai@suse.de>
	<b24e53350905231434h44fb22e7l8ecd845e0b202f20@mail.gmail.com>
	<s5hprdy536s.wl%tiwai@suse.de> <4A1A2902.1010403@cygnusx-1.org>
	<s5hocthd9kb.wl%tiwai@suse.de>
	<4A1A4128.9050305@cygnusx-1.org> <s5hmy905m01.wl%tiwai@suse.de>
	<b24e53350905260728k1022137av2389e334a5c73d7d@mail.gmail.com>
	<s5hvdnn7ty3.wl%tiwai@suse.de>
	<b24e53350905261016ud14094vbb166e7145b66c6f@mail.gmail.com>
	<s5hzlcz9g3e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B735B2465F
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 09:25:57 +0200 (CEST)
In-Reply-To: <s5hzlcz9g3e.wl%tiwai@suse.de>
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
Cc: Robert Krakora <rob.krakora@messagenetsystems.com>, alsa-devel@alsa-project.org, alsa-devel@cygnusx-1.org, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 May 2009, Takashi Iwai wrote:

> Thanks for testing!
>
> I have an impression that the jiffies check can behave pretty buggy in
> cases the hardware doesn't give a smooth pointer update.  It's
> supposed to filter out spontaneous invalid pointer values.  That'll
> work indeed (although I don't think the check in
> snd_pcm_period_elapsed() is worth).  But what if a hardware returns
> the pointer value that is not always updated smoothly?
>
> Assume a hardware returning only spontaneously updated values, 0 at
> t=0, 1000 at t=100, 2000 at t=200, and so on.  If
> snd_pcm_update_hw_ptr() is called at t=99, it gets still position 0.
> Then when it's called at t=100, it suddenly increases to position 1000
> while jiffies delta is only 1.  The current code would filter out this
> update because it appears as if too much.

That's good point. The hw_ptr_jiffies should be updated only when position 
in the ring buffer moves:

 	if (runtime->status->hw_ptr != new_hw_ptr)
 		runtime->hw_ptr_jiffies = jiffies;

Similar condition might be also used for runtime->status->tstamp variable.

> The problem continues, if snd_pcm_update_hw_ptr() is constantly called
> at each t=100, 101, ...  At each call, jiffies delta is 1, but the
> position delta is still 1000 because it wasn't updated.  That is, as
> long as the app keeps calling snd_pcm_update_hw_ptr(), the position
> won't be updated.  This is pretty possible especially with an app like
> pulseaudio.
>
>
> I have a feeling that we should disable the jiffies check in that
> part, at least for 2.6.30, until a better solution is found.  The
> jiffies check is already done and works pretty well in the driver
> side (hda-intel and intel8x0).  But this check in the PCM core can be
> (not always, though) buggy, and actually gives problems sometimes.

As I already wrote, I have nothing against to make jiffies check 
conditional on xrun_debug() for 2.6.30 for debugging purposes, but I'd 
like to leave this code enabled in our development trees. It reveals some 
buggy drivers which should be checked (a new one is Vortex - au88x0).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
