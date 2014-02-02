From: Mark Hills <mark@xwax.org>
Subject: Audio artefacts but no xruns
Date: Sun, 2 Feb 2014 12:04:00 +0000 (GMT)
Message-ID: <1402021138000.29544@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA5F4265026
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2014 13:04:01 +0100 (CET)
Received: from cpc8-hari13-2-0-cust400.20-2.cable.virginm.net ([82.45.197.145]
 helo=localhost) by wes.ijneb.com with esmtpa (Exim 4.77)
 (envelope-from <mark@xwax.org>) id 1W9vmK-0005ph-MN
 for alsa-devel@alsa-project.org; Sun, 02 Feb 2014 12:04:00 +0000
Received: from mark (helo=localhost) by localhost with local-esmtp (Exim 4.69)
 (envelope-from <mark@xwax.org>) id 1W9vmK-0007s3-GI
 for alsa-devel@alsa-project.org; Sun, 02 Feb 2014 12:04:00 +0000
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

Hi,

I have several applications for realtime processing of audio in/out, using 
small buffer sizes.

I often find that I can get audible time-based distoritions, yet no xrun 
is reported, and the application is unaware.

This problem is something I have, for a long time, taken for granted with 
ALSA. But it doesn't seem right and I would like to understand what's 
going on here.

I am testing using different USB audio devices; snd-usb-audio and 
snd-usb-caiaq. Often using plughw or hw.

Is this some fundamental limitation of USB, that it is unaware of problems 
nearer to the hardware?

Or is this some bug where it's worth me narrowing down a specific test 
case and trying to fix it?

Or some limitation of the use of intermediate processing like plughw?

The effects range from occasional subtle clicks through ringing or 
noticable gaps in the audio, on record or playback.

At very least I would like to guarantee a notification in userland that 
the integrity of the recording or playback is affected.

This is particularly prevalent on, eg. Raspberry Pi. My other tests are on 
x86 platforms.

Thanks

-- 
Mark
