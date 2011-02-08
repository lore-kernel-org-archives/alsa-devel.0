From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: ALSA: Reasonable buffer size / where should it be implemented?
Date: Tue, 08 Feb 2011 17:08:37 +0100
Message-ID: <4D516A85.5070604@t-online.de>
References: <4D511552.7030409@t-online.de> <alpine.LNX.2.00.1102081109170.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1102081109170.6272@eeebox2.perex-int.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> It's probably the right way to go. I would only copy data in a tasklet
> not directly in the interrupt routine. New hardware (like HDA) have
> scatter-gather DMA buffers with almost unlimited size, so users can
> just tune the system up.
>
Well, obviously recording to /dev/null has a better chance not to
hit xrun problems ;-)

So I'll clean up my q&d rme96.c code and submit it.

I have not had a look at the sources ... is arecord "right behaving"
or which command line recording tool could be used if it is not?

cu,
 Knut
