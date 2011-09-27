From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v2] ALSA: hdmi: expose ELD control
Date: Tue, 27 Sep 2011 09:23:49 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1739555477@HQMAIL01.nvidia.com>
References: <1317077323-3600-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hhb3ye801.wl%tiwai@suse.de>
	<000301cc7d2c$ee224c80$ca66e580$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id DFADD24496
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 18:23:56 +0200 (CEST)
In-Reply-To: <000301cc7d2c$ee224c80$ca66e580$@bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote at Tuesday, September 27, 2011 9:49 AM:
...
> > Set the access field to SNDRV_CTL_ELEM_ACCESS_READ.
> > Also, unless we implement a notification, better to set
> > SNDRV_CTL_ELEM_ACCESS_VOLATILE flag, too.
> 
> The intent was to read the ELD after the device is opened, I don't think the
> ELD can change during playback, the updates can only happen on a pin-sensing
> event. I can't think of a good reason why a notification would be needed?

If the user unplugs an HDMI monitor and plugs a different one in, and
hence the X server turns off the output and re-enables it to cater for
any required new display mode, would that force the audio client to
close/re-open the audio device? I don't /think/ so. As such, I guess
the ELD can change dynamically, so notification would be a good idea.

-- 
nvpublic
