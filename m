From: Scott Doty <scott@ponzo.net>
Subject: SPDIF trouble with multiple usb devices
Date: Tue, 12 Apr 2016 15:28:06 -0700
Message-ID: <570D7676.1060004@ponzo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE8B2650CC
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 00:28:11 +0200 (CEST)
Received: from eva.ponzo.net (bastion.ponzo.net [69.12.218.213])
 (authenticated bits=0)
 by c.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id u3CMS6r9027110
 (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:28:07 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So I'm having the worst luck with optical SPDIF devices.

  
http://www.alsa-project.org/db/?f=d0d48e597f0cdbd1b377aea6f8d73b000301ae8a

Recently I hooked up my synthesizer in the configuration that used to
work fine, and it didn't work:  The Sound Blaster HD usb audio device
doesn't seem to be working on modern kernels, nor does the spandy-new
SIIG HD Digital 7.1 USB Audio Box.

I'll go down the list of devices:

_[/proc/asound]_(root@eva)_
# cat cards
 0 [Pro            ]: USB-Audio - SB X-Fi Surround 5.1 Pro
                      Creative Technology Ltd SB X-Fi Surround 5.1 Pro
at usb-0000:00:14.0-4.7.5, ful

This device works fine.  Unfortunately, it only has optical SPDIF out,
no SPDIF input.

 1 [Audio          ]: USB-Audio - USB2.0 High-Speed True HD Audio
                      CMEDIA USB2.0 High-Speed True HD Audio at
usb-0000:00:14.0-1.4, high speed

Just got this from Amazon, it is a "SIIG HD Digital 7.1 USB Audio Box". 
I was hoping the optical SPDIF input would work to replace the Sound
Blaster HD below -- but alas, it doesn't.

 2 [M8             ]: USB-Audio - MOTIF ES 8
                      Yamaha MOTIF ES 8 at usb-0000:00:14.0-1.3, full speed

This is actually a MIDI-over-USB device, my synth.  The output of the
synthesizer is optical SPDIF, which _used_ to work with the following
device:

 3 [HD             ]: USB-Audio - USB Sound Blaster HD
                      Creative Technology USB Sound Blaster HD at
usb-0000:00:14.0-4.7.6, full speed

I used to be able to use the optical SPDIF input for this device from my
synth, but that seems to have stopped working.  Further, I can't play
audio out of the Sound Blaster HD's optical SPDIF output, either.  It
works in Windows 10, which is where I had to spend my latest music
session -- yuck.

Never mind the rest of the devices.

Naturally, I'd love for this to be a quick fix, but I'm even willing to
buy more hardware, if I know the SPDIF optical input works.  (Buying the
SIIG device was my way of "punting" by getting Creative out of the mix.)

I'm also willing to ship the non-working devices to anyone who can make
them work, for the good of Linux.

I use Rosegarden on Linux, and for various reasons, the port to Windows
just doesn't cut the mustard.

Any help you can provide would be greatly appreciated. :)

 -Scott
