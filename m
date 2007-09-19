From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 ac loop
Date: Wed, 19 Sep 2007 09:15:34 +0200
Message-ID: <46F0CC96.6090307@gmail.com>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 08FFE2444A
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 09:16:37 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/19/2007 07:22 AM, Trent Piepho wrote:

> I'm not an expert on this chip by any means, but from looking at the code
> I think there are few things that could be fixed.

I'd agree, although I'd suggest to at this point keep anything (in ad1848, 
cs4231 wants a similar setup in its mce_down) not completely trivial for 
after 1.0.15.

> The reg_lock spinlock isn't acquired from the irq handler, as the handler
> doesn't use any of the indirect registers.  I think this means that is
> isn't necessary to use the irq disabling versions of the spin_lock
> functions with reg_lock.

This would appear to be the case yes.

> It does look like there is a different SMP race condition wrt the irq handler.
> From snd_ad1848_interrupt():
> 578         if ((chip->mode & AD1848_MODE_PLAY) && chip->playback_substream &&
> 579             (chip->mode & AD1848_MODE_RUNNING))
> 580                 snd_pcm_period_elapsed(chip->playback_substream);
> 
> Another CPU could close the substream between the check and the call to
> snd_pcm_period_elapsed().  snd_pcm_period_elapsed() could be called with
> either NULL or a stale substream pointer depending on how the code compiled.
> I'd think creating an irq spinlock would be an easy way to fix this.  The irq
> handler would grab it, and the same with the open() and close() functions
> around the code that sets the substream pointers.  Alternatively, one could
> disabled the irq handler during open and close.

Also sounds sensible, and the irq spinlock the expected method.

> I think there might also be problem with setting mixers controls during 
> auto-calibration . While waiting for auto-calibration to finish, the chip
> isn't locked. If another thread tries to set the volume via the mixer 
> interface, it won't be blocked and will try to talk to the chip during
> AC. The datasheet just says to wait for auto-calibration to finish, it
> doesn't say what happens if you don't. So maybe there isn't any problem
> here.

Guess we should be testing this, but generallt, "hand-off" would be the best 
policy yes.

Rene.
