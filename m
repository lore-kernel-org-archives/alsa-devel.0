From: Timur Tabi <timur@freescale.com>
Subject: Re: Requiring the same sample rate for playback and
 record?
Date: Mon, 14 Jul 2008 16:25:04 -0500
Message-ID: <487BC430.8040109@freescale.com>
References: <485C0042.4050008@freescale.com> <s5h7icg4dsd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6617024474
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 23:25:11 +0200 (CEST)
In-Reply-To: <s5h7icg4dsd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Right now there is no "elegant" way for this, unfortunately.
> A common way many drivers use is to remember the rate of the first
> stream, then add it to hw_constraint of the secondary streams.

Can you give me an example of a driver that does this?  I can't seem to find one.

> But, this could be also a bit racy (unavoidable due to its design)
> although practically it seems working.

I've been trying to implement this, but I'm not sure how.  I have a couple
questions:

1) Which snd_pcm_hw_constraint_xxx function should I use to specify a sample
rate or sample size constraint of a single number?  I'm thinking
snd_pcm_hw_constraint_list().

2) Where should I be calling this function?  In my _hw_params() function?  What
I would like to do is require the constraint to be enforced only when a stream
is already playing.  That is, if playback is paused, then the capture stream can
set any sample rate it wants.  Is this doable, or just too complicated?


-- 
Timur Tabi
Linux kernel developer at Freescale
