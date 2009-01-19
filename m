From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Turtle Beach Multisound Pinnacle alsa driver
Date: Mon, 19 Jan 2009 14:07:48 +0100
Message-ID: <20090119140748.2557cced.krzysztof.h1@poczta.fm>
References: <20081122164829.39c90558.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 765B41037EA
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 14:04:51 +0100 (CET)
In-Reply-To: <20081122164829.39c90558.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have posted the second version of this driver on 6 December
but it has still been waiting for moderator approval as it was 
to big (about 90KB).

Is there any chances to replace an old experimental driver
in the alsa-driver package to this new one?
A long term target is to remove old OSS driver for the card
and use the new one for ALSA.

The summary of major changes are:
1. New driver uses PnP framework
2. It uses MPU401 framework instead of raw midi (so less code)
3. It has fixed handling of 8-bit audio formats (bug in the old driver)
4. It has fixed audio capture formats (bug in the old driver)
5. It has fixed requesting shared memory region (bug in the old driver)
6. ioremap memory region once instead before each access (improvement)
7. Removed common module as it is very small (improvement)
8. Code conforms to the Linux kernel CS.
9. It is shorter by at list 10KB of source and few KB of binary.
10. Few smaller bugs fixed (e.g. digital output option in mixer).

I tested this driver on a borrowed card. It has digital output add-on card. 
If anybody can tell me how to test a digital input/output (e.g. by using
another sound card) I can do this as well.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
