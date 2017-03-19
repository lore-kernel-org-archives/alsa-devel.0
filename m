From: Matthias Andree <matthias.andree@gmx.de>
Subject: USB Focusrite Scarlett 6i6 2nd Gen - Mixer not working
 (new VID, quirks and probably matrix needed)
Date: Sun, 19 Mar 2017 20:21:14 +0100
Message-ID: <f8a736b9-4e38-6d66-1b3f-87d35f5fe378@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B886426690C
 for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2017 20:21:17 +0100 (CET)
Received: from mandree.no-ip.org ([77.182.114.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5q45-1c18An1gc5-00xuUT for
 <alsa-devel@alsa-project.org>; Sun, 19 Mar 2017 20:21:16 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by apollo.emma.line.org (Postfix) with ESMTP id 42CD123D340
 for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2017 20:21:15 +0100 (CET)
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

Greetings,

I recently acquired a Focusrite Scarlett 6i6 *2nd Gen*.

It appears to work for sound output (haven't tested much else yet), but
mixing/routing won't work, and to add insult to injury, Pulseaudio
misrepresents it as a multi-channel sound card, defaults to 5.1 and
deprives it of the bass. Selecting 5.0 improves the situation as a
workaround for stereo output.

Hardware differences between 1st and 2nd Gen aside (where pad and
inst/line switches moved into software), the interface does not create
useful mixer entries.

Digging around I figured we didn't have new stuff in the current kernel
Git tree, so I chose to continue with what I had and found:
in Ubuntu 16.04's 4.8.0 HWE kernel "Advanced Linux Sound Architecture
Driver Version k4.8.0-42-generic.",
I figured that the USB IDs (VID 0x1235 as usual, PID 0x8203 for the 6i6
2nd Gen) aren't recognized.

I added them to the quirks section, and to the mixer_scarlett.c, to no
avail.
I get this on load, and the second message identically for each attempt
to access the card through alsamixer, which alsamixer terminates with
SIGPIPE.

[10834.242351] usbcore: registered new interface driver snd-usb-audio
[10834.329623] usb 2-6: cannot get ctl value: req = 0x81, wValue =
0x901, wIndex = 0x100, type = 4

With the patched module, sound stops after a few notes but I assume
that's pulseaudio f*cking up, while it works with the unpatched module.


So it appears we need to dig up and implement a bit of its innards and
teach mixer_scarlett about it.

How do we best go about getting this 2nd Gen Scarlett 6i6 fully
supported? Do I need to sniff the USB communications on Windows while
poking at the interface with its mixer control tool, or do we have other
options? How did the 1st gen driver come to pass, and who did it and
might be available for assistance?

Is there any user-space poking we can do to dig up the needed information?

Thanks.

Cheers,
Matthias
