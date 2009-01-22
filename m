From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: CS4232 Playback bug on Tecra 500
Date: Thu, 22 Jan 2009 17:28:56 +0100
Message-ID: <20090122172856.e39ae951.krzysztof.h1@poczta.fm>
References: <405205790901212040s79ce94a4if4ff742a9c18bc67@mail.gmail.com>
	<20090122134150.f6d0e192.krzysztof.h1@poczta.fm>
	<405205790901220743k32d76edeh733b2dacfbf0497e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F5BF10380A
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 17:25:51 +0100 (CET)
In-Reply-To: <405205790901220743k32d76edeh733b2dacfbf0497e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stanley Pinchak <stanley.pinchak@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Stanley,

In short words, you need to upgrade the kernel. Also,
blacklist or delete the snd-cs4236.ko module.

A longer description. The ALSA page about Tecra 
laptop you mentioned is wrong. Your CS4232 card
is a PNP BIOS device and does not need any 
parameters. However, your kernel is dated 20080623
and there was a fix for a cs4232 driver crash commited
on 20080727 to the kernel. The crash is visible in
your dmesg file:

[   91.243845] BUG: unable to handle kernel NULL pointer dereference at 00000158
[   91.244314] IP: [<c02088ad>] pnp_activate_dev+0x3/0x3a
[   91.244714] *pde = 00000000 
[   91.244977] Oops: 0000 [#1] 

Next thing is that your have a second driver loaded: 
the snd-cs4236. Do not load this driver. AFAIR, the 
snd-cs4236 driver should be blacklisted or removed
on laptop with the cs4232 chip and PNP BIOS. The 
cs4236 and cs4232 have the same PNP BIOS id-s.
The snd-cs4236 was incorrectly loaded instead of 
the snd-cs4232 at least on my laptop (old Dell).

I hope this helps you,
Krzysztof

----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
