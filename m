From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: snd-aloop: make
	preallocated	buffer	size	configurable
Date: Wed, 21 Sep 2011 10:02:27 -0500
Message-ID: <34270.8042510369$1316617369@news.gmane.org>
References: <1316545332-2229-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<s5hzkhygkpe.wl%tiwai@suse.de>
	<s5hpqiugdu2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3155E2415C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 17:02:29 +0200 (CEST)
In-Reply-To: <s5hpqiugdu2.wl%tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I meant to have a kconfig option to limit the upper-bound of pre-alloc
> buffer sizes for all drivers.  That is, a patch like below (untested)

That's a good idea, but the two patches aren't necessarily exclusive. In an
embedded solution you may want a 2s PCM buffer for low-power playback and a
64k buffer for snd-aloop as it is only used with small periods. Also one
would need to check the buffer/period sizes in each driver, and make sure
they are smaller than this global max.
-Pierre
