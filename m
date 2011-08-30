From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: refine delay information with
 USB	frame counter
Date: Tue, 30 Aug 2011 09:59:34 +0200
Message-ID: <4E5C9866.9060901@ladisch.de>
References: <1314642732-8909-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EDF0B24533
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 09:59:30 +0200 (CEST)
In-Reply-To: <1314642732-8909-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: sarah.a.sharp@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> Existing code only updates the audio delay when URBs were
> submitted/retired. This can introduce an uncertainty of 8ms
> on the number of samples played out with the default settings,
> and a lot more when URBs convey more packets to reduce the
> interrupt rate and power consumption.
> 
> This patch relies on the USB frame counter to reduce the
> uncertainty to less than 2ms worst-case. The delay information
> essentially becomes independent of the URB size and number of
> packets. This should improve audio/video sync and help
> applications like PulseAudio which require accurate audio
> timing.

I haven't yet found the time to test this, but there are a few
theoretical nitpicks ...

> +	/* HCD implementations use different widths, use lower 8 bits.
> +	 * The delay will be managed up to 256ms, which is more than
> +	 * enough
> +	 */

/*
 * Multi-line comments are supposed to use this formatting style.
 */

> +	current_frame_number &= 0xFF;
> +	frame_diff = current_frame_number-subs->last_frame_number;
> +	if (frame_diff < 0)
> +		frame_diff += 256; /* handle 8-bit wrap-around */

This could be replaced with just:
	frame_diff = (current_frame_number - subs->last_frame_number) & 0xff;

> +	/* Report when delay estimate is off by more than 2ms.
> +	 * The error should be lower than 2ms since the estimate relies
> +	 * on two reads of a counter updated every ms */
> +	if (abs(est_delay-subs->last_delay) > (runtime->rate*2/1000L))
> +		snd_printk(KERN_DEBUG "ALSA usb.c: Delay %d actual delay %d\n",
> +			est_delay, subs->last_delay);

Do you know how large the difference actually becomes?

I'm not sure if it might be possible to construct a scenario where
rounding errors could accumulate ...


Regards,
Clemens
