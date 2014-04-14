From: Richard Storer <rstorer@ntlworld.com>
Subject: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 12:28:18 +0100
Message-ID: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f193.google.com (mail-qc0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB3FB2650D5
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 13:28:19 +0200 (CEST)
Received: by mail-qc0-f193.google.com with SMTP id e16so3014865qcx.0
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 04:28:19 -0700 (PDT)
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

Hi, this is my first time post on the ML so apologies if my message is
not to the required standard.

I am currently using a Raspberry Pi ARM computer it's running a
customised version of Debian called Raspbian:
Linux raspberrypi 3.10.36+ #665 PREEMPT Wed Apr 9 15:01:53 BST 2014
armv6l GNU/Linux
For audio playback and capture I am using a Creative Sound Blaster
Live 24bit external:
ID 041e:3040 Creative Technology, Ltd SoundBlaster Live! 24-bit External SB0490
I am currently experiencing 2 problems with this device which I
believe are related to the snd-usb-audio driver.

My first issue is for some reason booting Linux with my device already
attached to the USB port produces no audio output, however capture is
functioning.
I've tried mute, unmute via alsamixer but it seems like the amplifier
circuit inside hasn't turned itself on properly.
The cure for this (and 100% reproducible) would be to unplug / replug
the USB cable or simply connect to USB after Linux has fully loaded.

I don't understand why this should be the case surely it doesn't
matter at what stage the device is connected??

My next issue I feel is a little bit more serious and from what I
understand affects all versions of Linux even the x86 distros.

I use my Sound Blaster to capture stereo audio via Line-In which I
then stream in realtime via Darkice.
While Line-In capture does function on this device the signal levels
are extremely low.
Unfortunately there is no Line-In mixer control for my device the only
capture control I have is Mic and that doesn't control Line-In.
I have search for many months for a solution to the lack of Line-In
control but I have come to the conclusion that something is broken in
the driver or it got missed out.

Is anyone aware of these issues or could at least offer a solution to
increase the Line-In mixer levels maybe communicate with the USB
device directly without ALSA's assistance??

Richard S.
