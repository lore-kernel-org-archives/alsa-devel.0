From: Jack Bates <muyyxo@nottheoilrig.com>
Subject: USB dB data
Date: Wed, 30 Aug 2017 12:48:58 -0700
Message-ID: <2cc03127-af37-613a-a3df-a1d6e6915d05@nottheoilrig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nottheoilrig.com (mail.nottheoilrig.com [52.27.13.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF602665D5
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 21:49:01 +0200 (CEST)
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
 by mail.nottheoilrig.com (Postfix) with ESMTP id C9F2B204A2
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 19:48:59 +0000 (UTC)
Received: from [192.168.1.102] (198-48-156-162.cpe.pppoe.ca [198.48.156.162])
 by mail.nottheoilrig.com (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 19:48:59 +0000 (UTC)
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

I confirmed with Wireshark that my USB sound card responds to GET_MIN 
with 0x0000 and GET_MAX with 0x6300 .. The audio device class definition 
[1] says the units are 1/256 dB (section 5.2.2.2.3: Mixer Control) ... 
So by my calculation, the min and max are 0 and 99 dB (0x6300 / 256 == 
99) ... Why then does alsactl print:

 > range '0 - 99'
 > dbmin 0
 > dbmax 38

(/usr/sbin/aslactl -f - store)

I originally asked about this on the pulseaudio-discuss list [2] because 
it uses "dB data" [3].

The "0 - 99" makes sense -- it lines up with my calculation ... Where 
does the 38 come from? (I expect it's obvious, I just haven't found the 
explanation?)

Background: I just got a Bose SoundLink Revolve ... When I connect it 
with USB, the volume is silent from 0 to 99% and deafening at 100% 
(using PulseAudio). Directly adjusting the volume with alsamixer works 
properly: It increases smoothly from 0 to 100% -- changes that are 
reflected in the PulseAudio volume as fine adjustments in between 99 and 
100% (64587 to 65536 PulseAudio volume).

 From what I've read there's a common problem where especially USB 
devices report the wrong dB data (don't follow the spec [4]) -- this has 
previously been handled by patching the USB audio driver [5] ... However 
I haven't figured out how my device deviates from the spec (0x0000 to 
0x6300 or 0 to 99 dB seem plausible) -- my understanding is incomplete: 
I haven't figured out where the value 38 comes from ...

[1] http://www.usb.org/developers/docs/devclass_docs/audio10.pdf
[2] 
https://lists.freedesktop.org/archives/pulseaudio-discuss/2017-August/028600.html
[3] http://0pointer.de/blog/projects/decibel-data
[4] https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/637066
[5] https://bugs.freedesktop.org/show_bug.cgi?id=93193#c14
