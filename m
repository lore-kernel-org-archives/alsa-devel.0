From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Mon, 08 Apr 2013 11:31:12 -0500
Message-ID: <5162F0D0.7050402@linux.intel.com>
References: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A0111265B63
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 18:31:41 +0200 (CEST)
In-Reply-To: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> +	if (hinfo->ops.get_delay) {
> +		codec_nsec =
> +			hinfo->ops.get_delay(hinfo, codec, substream) * 1000000;
> +		if (stream == SNDRV_PCM_STREAM_CAPTURE)
> +			nsec = (nsec > codec_nsec) ? nsec - codec_nsec : 0;
> +		else if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			nsec += codec_nsec;

Can the .get_delay be modified to provide a better resolution than a ms? 
If you already convert to time, microseconds would seem like a better 
fit? Your codec seems to report frames (ie 20.83 us).
-Pierre
