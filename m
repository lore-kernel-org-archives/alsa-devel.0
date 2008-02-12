From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: No recording on hda-intel (AD1981HD)
Date: Tue, 12 Feb 2008 17:41:12 +0100
Message-ID: <200802121741.12799.grzegorz.chwesewicz@chilan.com>
References: <200802032017.38614.grzegorz.chwesewicz@chilan.com>
	<200802081951.40111.grzegorz.chwesewicz@chilan.com>
	<s5h8x1qv49k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CB74244A2
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 17:41:30 +0100 (CET)
In-Reply-To: <s5h8x1qv49k.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

> The patch will change only the behavior of Master control.  PCM should
> be as same as before.

That's correct, PCM behaves always the same way (with or without patch).

> What "value" are you referring in the above context?  Is it a raw
> mixer value, percent or dB, or the codec amp value?

I mean value which is under Master control bar in alsamixer program.

> Maybe we need to make clear how the master volume control behaves.
> According to the original bug reporter, the master volume behaves like
> below:

> - from 0% to 49% sounds are still audible, and the volume doesn't change at 
> all
> - from 50% to 100% sounds get louder normally
>
> How about yours?

I have exactly the same behavior of volume control as you described, but after 
applying ad1981-hp-master-amp-fix master behaves as described in previous 
letter and below (as reminder).

"I can only decrement it (master) to value (I've described what do I mean 
saying "value" in the begining of the letter) 3, and when I press 
down key (in alsamixer) to step to lower level of loudness, it's switching to 
value 103. When Master has 103 value I can hear very quiet output from 
internal speakers and HP (if plugged)."

-- 
Greetings
Grzegorz Chwesewicz, Chilan 
mailto:grzegorz.chwesewicz@chilan.com
