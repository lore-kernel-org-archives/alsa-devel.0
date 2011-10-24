From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: ALSA PulseAudio plugin: snd_pcm_rewindable()
	returns >0, but snd_pcm_rewind() is broken
Date: Mon, 24 Oct 2011 10:34:17 -0500
Message-ID: <8592.63156676224$1319470480@news.gmane.org>
References: <4EA567EA.1020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AFCB1037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 17:34:23 +0200 (CEST)
In-Reply-To: <4EA567EA.1020603@gmail.com>
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
To: 'Nikolay Nikolov' <nickysn@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I'm using the max buffer size, which is 1048576 frames (4MB buffer,
> 16-bit stereo). The buffer is almost full when I try to rewind. I first
> call snd_pcm_rewindable() and it returns a greater than zero value.
> Then
> I call snd_pcm_rewind() with this value and it returns success, i.e. a
> positive value of frames actually rewound. I then call snd_pcm_writei
> with the number of frames rewound and I get a weird pause (several
> seconds) in the audio on the next poll. Audio then continues from the
> middle; the beginning of the audio that was rewritten immediately after
> rewind() has been dropped. 

You want to avoid rewinding completely. Your audio hardware might have
prefetched data with the DMA subsystem. Rewinding completely might result in
an inconsistent configuration and possibly underflows. If you look at the
PulseAudio code, we've introduced some thresholds beyond which we don't
rewind (128 bytes or 1ms off the top of my head).
You might argue that snd_pcm_rewindable is broken, but it's somewhat
difficult to fix as the amount of prefetched data isn't modeled in the
driver and it's very much hardware-specific. Using a less aggressive
approach works fine on most hardware.
-Pierre
