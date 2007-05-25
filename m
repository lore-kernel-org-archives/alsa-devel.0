From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving	unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 13:39:40 +0100
Message-ID: <1180096780.13652.57.camel@localhost.localdomain>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
	<8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id EE53824467
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 14:39:41 +0200 (CEST)
In-Reply-To: <8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-05-25 at 17:34 +0530, Nobin Mathew wrote:
> Every ALSA driver is calling these for suspend
> 
> snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> snd_pcm_suspend_all(pcm[i]);
> 
> And for resume
> snd_power_change_state(card, SNDRV_CTL_POWER_D0)
> 
> 
> In ALSA ASoC no driver is calling any of this, even not in soc-core.c
> 
> My driver is an ASoC driver and I am also not calling these functions
> 
> Will this cause any Issue?
> 

These should probably be called to inform the upper layers of the PM
state. Can you log a bug for this in ALSA bugzilla.

Fwiw, this _shouldn't_ effect your resume. You should still see calls to
trigger for your DMA / AC97 to re-start transmission of PCM data.

PM was well tested on pxa2xx, although we did find a few applications
were not too happy resuming audio. e.g. mplayer in alsa mode, although
this was about 1 year ago and afaik it's been fixed.

It may be best to debug this using aplay and placing some debug in your
trigger functions to make sure PCM transmission is restarted correctly.

Liam
