From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Suggestion for improving alsa-lib sample rate
 converters.
Date: Wed, 15 Sep 2004 18:02:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409151730390.5341-100000@studcom.urz.uni-halle.de>
References: <414853EC.3050103@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE2722FE
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 18:02:38 +0200 (MEST)
In-reply-to: <414853EC.3050103@superbug.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Currently, we are limited in that the user application's period size has
> to be the same size for all periods.
>
> The hardware normally has all equal size periods per buffer.
> Depending on the state of the sample rate converters, this "all periods
> the same size" at the hardware level will result in varying period sizes
> at the application level after the sample rate converters have acted.

Some hardware (ymfpci, USB, Firewire) actually has varying period
sizes, too; it would be nice to allow application to know this.

AFAICS in all these cases, the period _time_ is not an integer
multiple of the sample time, but it's constant.

> If the application wishes to write whole periods at a time(e.g. Mem
> mapped, or callback based apps), there will have to be a way to tell the
> application about the size of the next period.

IIRC the ymfpci driver doesn't know the exact period size because the
hardware SRC chooses when to interrupt.  (ymfpci chips always use a
fixed period time of 256/48000 seconds.)

> Conclusion:
> So, the alsa application would now do:
> x = snd_pcm_get_next_period_size();   /* This would be a new api call */
> snd_pcm_write(x samples);

And an equivalent _get_last_period_size() for recording.

> With this extra bit of information fed back to the application, we could
> implement proper polyphase interpolators in alsa-lib.

This doesn't look backwards compatible.  I guess we have to emulate
constant periods (like the drivers above do) for applications that
don't have enabled this.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
