From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1848 ac loop
Date: Wed, 19 Sep 2007 11:24:13 +0200
Message-ID: <20070919112413.70051500.krzysztof.h1@gmail.com>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 15305245A1
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 11:16:44 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so100205nfd
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 02:16:43 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Sep 2007 22:22:42 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:


> I'm not an expert on this chip by any means, but from looking at the code I
> think there are few things that could be fixed.
> 
> The reg_lock spinlock isn't acquired from the irq handler, as the handler
> doesn't use any of the indirect registers.  I think this means that is isn't
> necessary to use the irq disabling versions of the spin_lock functions with
> reg_lock.
> 

Normally, this is not true as at least counter registers are reloaded. This is not
a case for the ad1848. However, quick test showed that playback is stopped
 from the irq handler if there is no more data (indirect register 9 write).

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

I would not do this in the driver code. This should be handled in the alsa pcm layer
and probably it is. At least the snd_pcm_period_elapsed() does locking and irq
disabling. Could any alsa guru enlighten us on pcm open/close locking
and interrupt disabling?

If it is handled in the pcm layer it is fixed for all drivers in one place.

> 
> I think there might also be problem with setting mixers controls during
> auto-calibration .  While waiting for auto-calibration to finish, the chip
> isn't locked.  If another thread tries to set the volume via the mixer
> interface, it won't be blocked and will try to talk to the chip during AC.
> The datasheet just says to wait for auto-calibration to finish, it doesn't say
> what happens if you don't.  So maybe there isn't any problem here.

I would not do this until someone experience the problem. Otherwise,
we will created the code to fix bugs which may not exist. Later, someone
would try to simplify the code and nobody will remember why it was done.

The ad1848 calibrates only DAC/ADC so no mixer values are set. In the worst case,
I expect some noise during auto-calibration, but I experience "pops" always during
auto-calibration on the ad1848 (sc-6000 board). The only solution is to do
the calibration only once during initialization than switch it off. Muting outputs
does not help.

Regards,
Krzysztof
