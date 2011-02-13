From: Angel D Genchev <i_liketowin@mail.bg>
Subject: Re:
	=?utf-8?q?=5BPATCH_-_snd-usb-audio_1/1=5D_Support_fo?=
	=?utf-8?q?r_Power/Status=09LED_on_Creative_USB_X-Fi_S51?=
Date: Sun, 13 Feb 2011 20:23:53 +0000 (UTC)
Message-ID: <loom.20110213T205636-668@post.gmane.org>
References: <4ccfae79.091fe70a.391a.0e23@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id EA73D24152
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 21:40:10 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Poijk-0002fo-KS
	for alsa-devel@alsa-project.org; Sun, 13 Feb 2011 21:40:04 +0100
Received: from 210-55.skknet.net ([210-55.skknet.net])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 21:40:04 +0100
Received: from i_liketowin by 210-55.skknet.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 21:40:04 +0100
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

I guess "S51" stands for "surround 5.1" ( Creative SB1090 ). Having vol. knob
working is wonderful (though software volume reduces dynamic range by cutting
from the resolution), but I have bigger problem with this card.
In my configuration the card shuts down ( dies ) in 40..90 min. of playback.
Doing so it "kills" the port in the kernel. So neither it nor other device can
work there until next reboot. The whole usb subsystem fails - if I plug it to
another port - the port dies without powering the card on. Under WinXP it works
o.k. but as usb hi-speed device. On linux it`s fullspeed device. I`m 90% sure
it`s linux kernel/alsa bug.
