From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Is there a function I can call from my ISR to tell
 ALSA to abort playback?
Date: Thu, 15 Nov 2007 09:34:05 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711150932310.19062@tm8103.perex-int.cz>
References: <473B5D83.2020408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B764D103821
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 09:34:05 +0100 (CET)
In-Reply-To: <473B5D83.2020408@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Nov 2007, Timur Tabi wrote:

> In my ISR, I call snd_pcm_period_elapsed() to tell it that a period has 
> elapsed.
>   I can also detect if playback has aborted for some reason (e.g. DMA 
> controller has died).  Is there a function I can call in my ISR to tell 
> ALSA to abort playback or capture?

Yes, call snd_pcm_stop() function. The call must be protected with 
snd_pcm_stream_lock... See to i2c/other/ak4117.c for an example.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
