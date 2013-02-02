From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Sat, 02 Feb 2013 02:22:04 +0100
Message-ID: <510C6A3C.1000501@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
 <510A485F.9060100@ivitera.com> <510AEF46.1080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
 [209.85.215.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 80A68265B5F
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2013 02:22:06 +0100 (CET)
Received: by mail-ea0-f170.google.com with SMTP id a11so1907875eaa.1
 for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2013 17:22:06 -0800 (PST)
In-Reply-To: <510AEF46.1080608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

:-)

I've got some progress here. The AK4114_ADDR was wrong. I changed it 
from 0x02 to 0x00 (according to datasheet).

Now I had some meat in the ak4114 file, but no signal was coming in. 
Then I found that the wrong spdif receiver channel was selected (the 
AK4114 has 4). After selecting the right one (0 instead of 1) I got the 
signal!

Its at the right level (-12dB) and the L/R channels match. But it's 
somehow capturing twice the rate. The 1 kHz come in as 2 kHz. There must 
still be something wrong.

Here is some content of the ak4114:

/proc/asound/Audiophile192/ak4114

0x00 = 0x0f
0x01 = 0x70
0x02 = 0x80
0x03 = 0x49
0x04 = 0x00
0x05 = 0x00
0x06 = 0x10
0x07 = 0x10
0x08 = 0x45
0x09 = 0x02
0x0a = 0x2c
0x0b = 0x00
0x0c = 0x00
0x0d = 0x41
0x0e = 0x02
0x0f = 0x2c
0x10 = 0x00
0x11 = 0x00
0x12 = 0x00
0x13 = 0x00
0x14 = 0x00
0x15 = 0x00
0x16 = 0x00
0x17 = 0x00
0x18 = 0x00
0x19 = 0x00
0x1a = 0x00
0x1b = 0x00
0x1c = 0x00
0x1d = 0x00
0x1e = 0x00
0x1f = 0x00

Regarding the sample rate detection. It seems it's the channel status 
bits that get interpreted by the windows driver. The fs bits from the 
AK4114 seem to be unused. But the channel status definitely changes some 
bits on sample rate changes.

The Clock Source seems to be PLL (CM1-0 = 0,0).

I'll keep on debugging.

- Jonas
