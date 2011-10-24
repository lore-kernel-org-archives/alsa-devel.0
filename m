From: Nikolay Nikolov <nickysn@gmail.com>
Subject: Re: ALSA PulseAudio plugin: snd_pcm_rewindable()
 returns >0, but snd_pcm_rewind() is broken
Date: Mon, 24 Oct 2011 19:55:34 +0300
Message-ID: <4EA59886.7000205@gmail.com>
References: <4EA567EA.1020603@gmail.com>
	<4ea5858a.4a2acc0a.3bb5.5b58SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E5164103821
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 18:55:39 +0200 (CEST)
Received: by eyz10 with SMTP id 10so5725363eyz.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 09:55:37 -0700 (PDT)
In-Reply-To: <4ea5858a.4a2acc0a.3bb5.5b58SMTPIN_ADDED@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/24/2011 06:34 PM, Pierre-Louis Bossart wrote:
> You want to avoid rewinding completely. Your audio hardware might have
> prefetched data with the DMA subsystem. Rewinding completely might result in
> an inconsistent configuration and possibly underflows. If you look at the
> PulseAudio code, we've introduced some thresholds beyond which we don't
> rewind (128 bytes or 1ms off the top of my head).
> You might argue that snd_pcm_rewindable is broken, but it's somewhat
> difficult to fix as the amount of prefetched data isn't modeled in the
> driver and it's very much hardware-specific. Using a less aggressive
> approach works fine on most hardware.
> -Pierre
Yes, I figured this out while experimenting with real hw alsa devices 
and that's why I actually rewind snd_pcm_rewindable() minus some 
threshold, that can be configured. However with the alsa pulseaudio 
plugin, rewinding seems to be broken completely, even with a very large 
threshold.
