From: Shane Hathaway <shane.list.alsa-devel@hathawaymix.org>
Subject: Phoenix Audio Duet
Date: Wed, 19 Sep 2007 23:26:18 -0600
Message-ID: <46F2047A.2090605@hathawaymix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.afconnect.com (mail.afconnect.com [216.83.140.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AB2F246B0
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 07:26:26 +0200 (CEST)
Received: from [192.168.1.10] (tiger.hathawaymix.org [192.168.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pigeon.hathawaymix.org (Postfix) with ESMTP id E04257A4137
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 23:26:20 -0600 (MDT)
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

I just bought a set of Phoenix Audio Duets for VOIP conferencing.  They
are USB speakerphones with good echo cancellation.  They work fine with
the snd_usb_audio module, with one exception: I can't control the
microphone and speaker levels.  ALSA exposes some controls, but they
have no effect, so I have to shout to be heard.

Rather than get a hoarse voice, I want to help enhance the snd_usb_audio
module to correctly support the mixer controls within the Duet.  I know
the device actually has working mixer controls because Phoenix Audio
provides a Windows-only utility for controlling the levels, and when I
use that utility turn up the mic, I can be heard quite well.
Unfortunately, the levels are reset when I move the device back to a
Linux box.

I used SnoopyPro to capture USB packets as I adjusted the levels in
Windows and I think I know what to transmit to the device in order to
read and change the levels.  Now I just need to figure out how to
translate that knowledge into kernel code.  I am a capable C coder
(though rusty), I don't know much about USB, and I've dabbled in kernel
code before.

lsusb lists the Duet (Executive) as:

Bus 001 Device 011: ID 0556:0004 Asahi Kasei Microsystems Co., Ltd

Both kmix and Ekiga see it as an AK4571.  There is a data sheet for that
chip here:

http://www.datasheetcatalog.com/asahikaseimicrosystems/3/

I would guess that the AK4571 has mixer controls built in, but that
Phoenix Audio (phnxaudio.com) chose not to use those controls and
instead enhanced the USB interface with nonstandard mixer controls.

So, where should I begin?  I don't see evidence that anyone has worked
on this yet.

Shane
