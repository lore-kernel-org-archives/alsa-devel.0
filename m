From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Plugging in headphones doesn't mute speakers,
	internal microphone 	does not work
Date: Sat, 28 Feb 2009 14:38:10 -0200
Message-ID: <d54969c50902280838i4f48aa43w6630bfc87105890c@mail.gmail.com>
References: <d54969c50902280727i58fc689dib97a1fe9658b88ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C86C24362
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 17:38:11 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1183729yxh.2
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 08:38:10 -0800 (PST)
In-Reply-To: <d54969c50902280727i58fc689dib97a1fe9658b88ab@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hello,

This is my first mail to the list, I hope you can help me. I have been
talking with people on #alsa, but they couldn't help me, so that's why
I'm writing to you.

Well, as lspci says, my Acer Aspire 6930 laptop has an "Intel
Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)". With
this card, and without adding any mode=... to
/etc/modprobe.d/alsa-base, playback works perfectly, but when I plug
in headphones, the integrated speakers do not mute. I can mute the
speakers muting "front" and "side" and use the headphones, but it
should be automatic.

Setting mode=auto makes the headphones, when plugged, mute the
speakers. But the problem with this is, that when using the speakers,
I only get sound from the speaker that was "front" in the other mode.
The microphone does not work in this mode either.

I also tried other modes, including (but not limited to) acer,
acer-aspire. I ran alsa-info.sh, here is the URL:
http://www.alsa-project.org/db/?f=7910da439e8e190a8c2a6f18167d4879c74881c9

And before I forget, regarding the microphone, if I plug an external
one on the microphone plug, I can record. And I tried the internal one
on windows, and it works, so I believe it's an alsa problem.

Looking forward to hearing from you!

Emilio
