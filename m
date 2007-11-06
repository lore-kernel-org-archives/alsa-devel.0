From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Tue, 06 Nov 2007 19:10:28 +0300
Message-ID: <473091F4.80105@aknet.ru>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 2658F247F7
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 17:09:09 +0100 (CET)
In-Reply-To: <s5hy7dbvcgf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

Takashi Iwai wrote:
> In principle, using rate plugin with two periods doesn't work well in
> case that the sample rates aren't aligned.  It's a design issue.  You
> shouldn't use two periods except for hw.  Period.
I understand that and I even tried
a hack to increase the buffer_size
and stop_threshold by the period_size
in a rate plugin, although without
a success.
However, there is one exception: it
will work provided the app is allowed
to fill both fragments entirely.
Without that patch, it simply can't.
With the patch - the write returns
earlier, the app writes again, the
rate plugin gets the period filled,
and commits it, before the first one
expired.
Isn't it exactly the right and
reliable fix then?

> Here, note that 940 != 1024 * 44.1 / 48.0 exactly.  This rounding
> causes the drift of wake-up time at each period and the delay is
> accumulated.
I understand, but the app can start writing
_third_ period if write returns earlier.
And that write will fill up the reminder
of the second one, no matter how it accumulated.

> So, even applying your patch, the XRUN problem may occur at some time
> as long as you use two periods.  It can't be fixed without the
> fundamental change of the irq / poll handling routines in the ALSA
> driver.
I am more inclinced to think there is
a race - except for the underruns, I've
also seen a lockups in poll().
Do you think the race I described in the
previous posting doesn't exist?

> Whether that hack really does any good thing is questionable, indeed.
Actually, I've found out that it plaques
many other bugs. For example, mpg123 sets
avail_min=1, which is silly but should
work. With the hack, the avail_min just
gets increased. Without the hack -
snd_pcm_write_areas() spins in a loop
trying to commit the samples one-by-one
(because the poll returns immediately),
eating 100% of CPU. But that's an unrelated
bug, which was just hidden, and I think
there are more...

> First, it skips the avail_min adjustment if the app fills the period
> size.  Thus only for apps that fills arbitrary amount of data via
> snd_pcm_writei() triggers this hack.
I don't think so. Because of the rounding
errors in a rate plugin, when the app
thinks it writes the entire fragment,
it actually does not. Any app is affected!

> Second, avail_min is checked usually in irq handler and thus its
> resolution is also in period size.  It means avail_min + 1 is
> equivalent with avail_min + period_size.
Yes, so don't increase it then. :)

> So what we can do better?  As a temporary solution, we can get rid of
> the problematic part, or, at least, add the check whether avail_min
> comes over stop_threshold.  I'm not sure whether any big impact by
> removing the hack there.  Maybe not.  But, I feel it's a barren
> discussion.  It's really a design problem.  Sigh.
I think allowing an app to start writing
the third fragment, filling actually the
second one, is a very good fix.
What problems can you see with it?
