From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Apply codec delay to
	wallclock.
Date: Wed, 10 Apr 2013 07:29:32 -0700
Message-ID: <5165774C.2000507@linux.intel.com>
References: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
 <5164E2CF.2050207@linux.intel.com>
 <CAEUnVG4g--gJo5XjUub3do8acAjqDXeu_GSrDPY=tZ0QfwLPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F81265F82
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 16:29:57 +0200 (CEST)
In-Reply-To: <CAEUnVG4g--gJo5XjUub3do8acAjqDXeu_GSrDPY=tZ0QfwLPoA@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>
>>> +       return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
>>
>>
>> Is this correct? I would think for capture you need to add the delay, and
>> subtract it for playback?
>
> Should the capture timestamp represents the wall time when the sample
> is converted by the A-to-D?  If so, would be the correct time be the
> codec delay nsec before what is reported here?

For playback audio_timestamp = wallclk - codec_delay_in_nsec
for capture audio_timestamp = wallclk + codec_delay_in_nsec
