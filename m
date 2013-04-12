From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Apply codec delay to
	wallclock.
Date: Thu, 11 Apr 2013 19:17:10 -0600
Message-ID: <51676096.9000003@linux.intel.com>
References: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
 <5164E2CF.2050207@linux.intel.com>
 <CAEUnVG4g--gJo5XjUub3do8acAjqDXeu_GSrDPY=tZ0QfwLPoA@mail.gmail.com>
 <5165774C.2000507@linux.intel.com> <s5hvc7uh0we.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D2B86260319
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 03:17:13 +0200 (CEST)
In-Reply-To: <s5hvc7uh0we.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> For playback audio_timestamp = wallclk - codec_delay_in_nsec
>> for capture audio_timestamp = wallclk + codec_delay_in_nsec
>
> Hmm...  I'm confused, too.  From a pretty generic view,
>
> - hwptr = the samples (frames) transferred on the (memory) buffer
> - hwptr + PCM delay = the point being currently captured
>
> Which position does the wall clock correspond?

you now have 3 positions:

For capture:
hwptr = sample in memory
hwptr+ delay = sample recorded on link (tracked by LPIB and wallclock)
hwptr+ delay + codec_delay = sample recorded by A/D

For playback
hwptr = next sample in memory to be DMA'ed
hwptr - delay = sample pushed on link (tracked by LPIB and wallclock)
hwptr - delay - codec_delay = sample played in A/D

the wallclock is only at the soc/chipset level, it doesn't know anything 
about the peripheral.
Makes sense?
-Pierre
