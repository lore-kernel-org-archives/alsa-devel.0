From: Sebastian Konopka <sebastian.konopka@ph.tum.de>
Subject: HD-Audio Codec ALC888: Realtek Defined Registers and
	Digital Microphone
Date: Thu, 15 Oct 2009 11:57:14 +0200
Message-ID: <871vl5vv2d.fsf@sebasti-laptop.kaktus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de
	[129.187.254.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E753C10380C
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 11:57:35 +0200 (CEST)
Received: from mailout.ph.tum.de ([10.156.6.55] [10.156.6.55]) by
	mailrelay2.lrz-muenchen.de with ESMTP for
	alsa-devel@alsa-project.org; Thu, 15 Oct 2009 11:57:34 +0200
Received: from sebasti-laptop.kaktus ([91.46.191.47] [91.46.191.47]) by
	mailout.ph.tum.de with ESMTPSA for alsa-devel@alsa-project.org;
	Thu, 15 Oct 2009 11:57:33 +0200
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

Hello everybody on alsa-devel,

I'm adding a new model to the patch_realtek.c file that supports all
features my alc888-codec together with the laptop hardware
offers. Everything works fine and can be used through alsa, except two
things, because I did not find any usable information on them:

1. My laptop has an built-in digital microphone, that is connected to
   this codec according to the information I can get when using
   windows. The ALC888 datasheet shows that there are pins for digital
   microphone support. Thus I assume that they are used for the
   microphone. Those pins are share their functionality with GPIO pins:
   GPIO0/DMIC-CLK and GPIO1/DMIC-DATA.
   Unfortunally the datasheet does not provide further information on
   how to switch between GPIO and DMIC mode of those pins. Furthermore
   there is no information where the digital data can be found and how
   to transfer them over the HDA-Bus to the application.

   Does anybody have additional information on how to use digital
   microphones on realtek codecs?

2. Perhaps enabling the digital microphone is related to the so-called
   "Realtek Defined Registers" that can be found on NID=0x20 as
   processing coefficients. Furthermore the alc888 supports additional
   features like equalizer or echo-cancellation, etc. that can be
   controlled by these registers, as I suppose.

   Does anybody have information how what these registers and their
   contents mean? The datasheet does not provide any information.

I hope you can help me.

Sebsatian Konopka
