From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 19:37:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111915350.25064@eeebox2.perex-int.cz>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfcaru3.wl%tiwai@suse.de>
	<9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
	<alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
	<9e4733910905110811k643d899bjf7bd37ea029ac5cc@mail.gmail.com>
	<s5hfxfbzlz6.wl%tiwai@suse.de>
	<9e4733910905110850g2b1620a3q47ad2e5a9421a69c@mail.gmail.com>
	<s5hd4afzl5r.wl%tiwai@suse.de>
	<9e4733910905110928g618475bj2a4f47d62e4c5e14@mail.gmail.com>
	<s5h8wl3zj2j.wl%tiwai@suse.de>
	<9e4733910905111009w10017c21kdcf31e1d26ec231d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B1B0248D2
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 19:37:06 +0200 (CEST)
In-Reply-To: <9e4733910905111009w10017c21kdcf31e1d26ec231d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 May 2009, Jon Smirl wrote:

> Checking for over/under run in software is not reliable since the DMA
> hardware runs asynchronously with the CPU. There will always be
> variable latencies between when the CPU detects the condition and when
> it can control the DMA hardware.  The only reliable way to do this is
> to program the DMA hardware to do itself. AFAIK all DMA modern
> hardware can be programed to do this if the right information is made
> available. Programming the DMA hardware to do this is a 100% reliable
> solution and not subject to random latency problems.

I comment playback for simplicity.

The key point is when you fill DMA engine. Nothing forces you to queue 
whole ring buffer in the scatter-gather list. You may queue just one 
period and then next one (including partial). The available samples can be 
determined using snd_pcm_playback_hw_avail() function at any time. If you 
have large FIFO and you receive interrupt before FIFO goes empty, you can 
fill partial period. The elapsed notifier does not require any change.

The underruns should be avoided as first step, because it's really 
unwanted system behaviour. All methods to fix underruns fails in some 
respects.

Also note that we have also mode when appl_ptr is not updated at all (when 
stop_threshold == boundary).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
