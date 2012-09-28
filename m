From: David Henningsson <david.henningsson@canonical.com>
Subject: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 13:00:30 +0200
Message-ID: <5065834E.4010707@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC3E2616BC
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 13:00:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

While researching some crackling audio problem, I noticed that I got 
these messages in my dmesg:

delay: estimated 0, actual 384
delay: estimated 384, actual 768

They come at every start of playback. I want to understand this stuff, 
so I tried to dig a little. It looks like the endpoint is started in the 
prepare stage, so between prepare and trigger, silence data will be sent.

First question: Isn't this messing up the delay calculations? If you 
fill some "urb buffer" [1] with silence, depending on the urb buffer 
size, delay calculation should take this into account for proper 
lipsync. I mean, the USB audio device would first have to play all the 
silence data before it could start the audio data, right?
(And how big is this buffer anyway?)

Second question: This also means that some of the silence packets will 
go through retire_playback_urb, right? Isn't this also messing with the 
delay calculation?

(Oh, and btw, if you have an idea of the crackling/distorted USB audio, 
let me know. I'm using a standard Logitech USB Headset, using
speaker-test -c 2 -D plughw:Headset -t sine -r 48000
I can make the problem go away using any of these options:
  * Booting a 3.2 kernel - I've tried 3.5, 3.6-rc7 and 3.2
  * Choosing the 44100 sample rate instead of the default of 48000
  * Selecting the outer USB port instead of the inner one. Yes, there 
are two USB ports next to each other, and this only happens on one of 
them. (!))

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] maybe there's a better name for it?
