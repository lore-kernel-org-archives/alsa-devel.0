From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Sun, 06 Oct 2013 10:29:23 +0200
Message-ID: <1381048163.1974.5.camel@yoda.heavyware>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f178.google.com (mail-ea0-f178.google.com
 [209.85.215.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A20B2619F4
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 10:29:26 +0200 (CEST)
Received: by mail-ea0-f178.google.com with SMTP id a15so2597904eae.9
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 01:29:26 -0700 (PDT)
In-Reply-To: <1380728990-8443-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, nicholas.bailey@glasgow.ac.uk
List-Id: alsa-devel@alsa-project.org

> Next time, when detecting such problems, please consider sending a
patch
> to alsa-devel, so fixes make it to the users eventually :)

You are right, but I thought it was a problem with a broken/weird usb
controller, because it worked with my old laptop.
When I saw another user with the same problem, I sent the patch to LAU
(the only mailing list I've subscribed to).

Now I remember why I did that patch: if you see my dmesg output without
that patch, you can see that the driver is comparing 1024 to 0. If you
check the history of the driver, you can see that this check has already
been narrowed with the bit AND operation; I tried to narrow the check a
little more, so I chose 0x3ff because 1024 & 0x3ff = 0.
But I forgot about my Tascam (because I bought a RME Raydat) and never
tested that patch, but I was quite confident that it should work.

[  669.312765] ALSA sound/usb/usx2y/usbusx2yaudio.c:141 should not be
here with counts=42
[  669.329821] ALSA sound/usb/usx2y/usbusx2yaudio.c:141 should not be
here with counts=42
[  669.345854] ALSA sound/usb/usx2y/usbusx2yaudio.c:141 should not be
here with counts=42
[  669.471627] ALSA sound/usb/usx2y/usbusx2yaudio.c:311 Sequence
Error!(hcd_frame=3 ep=10out;wait=1024,frame=0).
Most probably some urb of usb-frame 1024 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.
[ 1203.531392] ALSA sound/usb/usx2y/usbusx2yaudio.c:311 Sequence
Error!(hcd_frame=4 ep=8in;wait=1025,frame=1).
Most probably some urb of usb-frame 1025 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.
[ 1218.908160] ALSA sound/usb/usx2y/usbusx2yaudio.c:311 Sequence
Error!(hcd_frame=5 ep=8in;wait=1026,frame=2).
Most probably some urb of usb-frame 1026 is still missing.

Ciao a tutti
Guido
