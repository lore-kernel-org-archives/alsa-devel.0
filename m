From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] wss-lib: move AD1845 frequency setting
 into wss-lib
Date: Mon, 12 Jan 2009 17:16:15 +0100
Message-ID: <20090112171615.f53cdae0.krzysztof.h1@poczta.fm>
References: <20090109231052.606a5497.krzysztof.h1@poczta.fm>
	<20090111044812.64596072.krzysztof.h1@poczta.fm>
	<s5hk5922gcf.wl%tiwai@suse.de>
	<36A813B2-427C-449D-8CD5-889024DEE271@hws.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 148051037EF
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 17:13:42 +0100 (CET)
In-Reply-To: <36A813B2-427C-449D-8CD5-889024DEE271@hws.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Theodore J. Allen" <tjallen@hws.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Theodore Allen <allen@hws.edu>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 11 Jan 2009 08:28:13 -0500
"Theodore J. Allen" <tjallen@hws.edu> wrote:

> The Soundscape Elite does work, but after a reboot
> I noticed that there is an oddness in that there's
> a little "pop" before playing sounds with aplay and
> a series of short spike pops before the sound plays
> with xmms, which uses the old oss interface.
> 

I traced this and the "pop" sound is caused by two
things:
1. Codec autocalibration every time a new sound is
started (even when sound is muted it produces
the "pop" on AD1848).
2. Muting sound on and off every autocalibration.

The OSS code from the 2.4 kernel states that
autocalibration produced that "pop" so it got
disabled. This solves two problems at once
as the muting on and off is not required then
(and is not done in the code).

I am not audiofile so I cannot comment how
audible the lack of autocalibration is. Most
codecs require it after they are powered up
(and most of them except the oldest ones
actually force it after powering up). One can
autocalibrate the codec only once
during a card/codec initialization.

I can prepare a patch which disables the
autocalibration. This is the only solution
as I tested others like slow volume muting
but all others still produce some noise.

Regards,
Krzysztof

-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019
