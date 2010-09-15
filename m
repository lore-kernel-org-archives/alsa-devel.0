From: Thomas Corner <tom.c.corner@gmail.com>
Subject: cmipci  CMI8738-MC6 - left channel no sound
Date: Wed, 15 Sep 2010 16:42:20 +0200
Message-ID: <4C90DB4C.2040603@gmail.com>
References: <4C89D660.4020705@gmail.com> <4C89D9E2.1070008@ladisch.de>
	<4C89DCD5.6040806@gmail.com> <4C89DF45.5090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F376F103805
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 16:43:13 +0200 (CEST)
Received: by bwz4 with SMTP id 4so639310bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2010 07:43:13 -0700 (PDT)
In-Reply-To: <4C89DF45.5090100@ladisch.de>
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
Cc: pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org

  I've been going around and around on this.  The surround sound 5.1 is
playing fine except channel 0 (front-left) is playing on the woofer. The 
card is a Terratec Aureon fun - CMI8738-MC6. I have
gotten desperate and have tested this card in Windows and was able to
get it working right there. I have been using speaker-test to
to test the setup. I am using pulseaudio.

This is the summary of my results with speaker-test:

speaker-test -c 6 -D surround51 -t wav
speaker          output
  ----------------------
  front L         silence
  front R         front R
  center          center
  bass            mix of front L + bass
  surround L      surround L
  surround R      surround R


speaker-test -c 4 -D surround40  -t wav
----------------------------------------------------
front L       silence
front R       front R
center        silence
bass          mix of front L + bass
rear L        rear L       rear R        rear R


speaker-test -c 4   -t wav
speaker-test -c 6   -t wav
speaker -test -c 2 -t  wav
---------------------------------
front L       silence
front R       front R
center        silence
bass          mix of front L + bass
rear L        silence
rear R        silence

I have removed pulseaudio again (recompiled all software with optional
pulseaudio support without pulseaudio support)  I should be outputting
directly to alsa and the driver now.

Under pulseaudio speaker-test gives error messages when surround40 and
surround51 is specified.

Thanks
Tom
