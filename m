From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 5/9] ALSA: core: selection
 of	audio_tstamp type and accuracy reports
Date: Wed, 10 Dec 2014 15:48:06 -0600
Message-ID: <5488BF96.708@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<1418077426-8309-6-git-send-email-pierre-louis.bossart@linux.intel.com>	<s5hsignmphw.wl-tiwai@suse.de>	<5488827E.4030403@linux.intel.com>	<s5hegs7mmki.wl-tiwai@suse.de>
 <s5hppbr6ze7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A79E26060B
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 22:48:11 +0100 (CET)
In-Reply-To: <s5hppbr6ze7.wl-tiwai@suse.de>
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
Cc: Nick Stoughton <nstoughton@aether.com>, alsa-devel@alsa-project.org, Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org


>
> A few more items that came to my mind later:
>
> - It'd be better to align both input and output; namely, the input
>    struct and output struct must be compatible.
>    Currently, report_delay flag is overwritten in return.  This bit
>    should be kept upon read back.
>
>    This essentially unifies snd_pcm_audio_tstamp_config and
>    snd_pcm_audio_tstamp_report.  We don't have to pass two structs to
>    callbacks.

ok. this is what I had before and I thought it'd be cleaner to clearly 
make the distinction between config and report. no issue changing this.

> - Or, we may avoid packing/unpacking by defining the struct like:
>
>       unsigned char type;
>       unsigned char flags;
>       unsigned char accuracy_mantessa;
>       unsigned char accuracy_exponent;
>
>    where flags field contains the bit flags for report_delay and
>    accuracy_report.
>
>    That said, I'm worrying a bit about the complexity of the new
>    callback function.

I would prefer a single structure if we want to add something later.

> - The biggest concern I have now is whether it's really feasible to
>    change the semantics of snd_pcm_status ioctl, i.e. from the
>    read-only to the write-read.  I guess this would work as the padding
>    field is very likely zero even in the very old alsa-lib version.

The change doesn't affect anyone really, all my defaults are zero.

> - Another concern is the compatibility with the current wallclock
>    implementation.  Judging from your patch, the audio_tstamp won't be
>    obtained from get_time_info callback in the default tstamp mode,
>    right?  This may result in a regression, as currently the driver
>    always gives the h/w audio_tstamp when the driver supports the
>    wallclock.

Is this that big of a deal? To the best of my knowledge this wallclk 
thing was implemented for HDaudio only when we were prototyping the new 
hardware, and I don't think we ended-up contributing the corresponding 
patches for PulseAudio. We've since realized that the wallclock can't be 
available in all cases and that we need this selection capability in a 
variety of cases.

Also even if we kept the .wall_clock callback, the wallclock handling 
could be relative (start at zero) or absolute. I implemented a reset to 
zero on stream startup, since the counter is not maintained when the 
hardware is idle, but there are implementations where the wallclock is 
really absolute and not reset (see below).

> - Last but not least: we're receiving multiple enhancement requests
>    regarding tstamp at the very same time.  This patchset conflicts
>    with Tim and Nick's start_at extention.
>
>    I believe this can be resolved later, but let's discuss the ground
>    line at first: the requirement and influence on both changes.

I am aware of this and it's why I posted my patches earlier than planned 
to avoid merging different concepts later, it's probably best to have 
compatibility from day1.

My proposal was to have a start_at functionality based on the timestamp 
definitions I suggested and keep audio and system timestamps separate 
rather than add mixed typestamps such as 
SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK. the code could be something like:

start_at(typestamp type, timestamp subtype, timespec value ) {

	if (type == SYSTEM) {
		_start_using_hrtimers(subtype, value) // would be CLOCK_REALTIME, 
MONOTONIC, maybe RAW
	} else if (type == AUDIO) {
		if (subtype == ABSOLUTE_WALLCLOCK) // not reset on audio subsystem startup
			_start_using_hardware(value)
		else
			// not sure what to do with regular counters, probably bail.
			error;
	}

That way you can set what sort of system timestamp and what sort of 
audio timestamp you want reported by snd_pcm_status, and you can 
independently select the start timestamp of your choice.
