From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: don't return uninitialized
	snd_compr_tstamp
Date: Mon, 04 Feb 2013 08:23:14 -0600
Message-ID: <510FC452.1070906@linux.intel.com>
References: <1359599832-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BAD202616F1
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 15:23:17 +0100 (CET)
In-Reply-To: <1359599832-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@linux.intel.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> The snd_compr_update_tstamp() can only fill in the snd_compr_tstamp
> if the codec implements the pointer() function. If that happened
> the code was previously returning uninitialized garbage in the
> tstamp because it wasn't initialized anywhere.
>
> This change zero-fills the tstamp in the two places it is used
> before calling snd_compr_update_tstamp(), and also has
> snd_compr_update_tstamp() return an error indication if it
> can't provide a tstamp. For the case of snd_compr_calc_avail()
> it ignores this error because we still need to return info on
> the available buffer space even if we can't provide tstamp
> info - when the tstamp is not valid all fields are now
> guaranteed to be zero.

I think I am missing something here. For compressed data, the DSP really 
needs to return a timestamp or the application will not be able to track 
the audio time, it'll only be able to refill buffers. Since with 
variable-rate compression we cannot translate bytes to time, isn't it a 
requirement that timestamps be supported for this API? If you don't 
support the .pointer, how will you provide this information to 
user-space levels?
Thanks,
-Pierre
