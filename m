From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hdmi: expose ELD control
Date: Tue, 27 Sep 2011 15:01:53 -0500
Message-ID: <1317153714.2197.28.camel@pbossart-Dell-N7010>
References: <1317077323-3600-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hhb3ye801.wl%tiwai@suse.de>
	<000301cc7d2c$ee224c80$ca66e580$@bossart@linux.intel.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1739555477@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB9510388B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 22:02:51 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1739555477@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> If the user unplugs an HDMI monitor and plugs a different one in, and
> hence the X server turns off the output and re-enables it to cater for
> any required new display mode, would that force the audio client to
> close/re-open the audio device? I don't /think/ so. As such, I guess
> the ELD can change dynamically, so notification would be a good idea.
> 

Hmm, if the user plugs/unplugs the cable, my understanding is that David
Henningson's patches for jack detection would trap these events, and
that would trigger reconfigurations of the audio server.
If notifications are needed, that's fine with me, we can add them at a
later stage. I don't have multiple monitors and would not be able to
contribute anything on this anyway...I wanted to start small and make
use the existing information is used properly by PulseAudio/others
first.
-Pierre
