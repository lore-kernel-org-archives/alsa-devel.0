From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [BUG] Bad decibel data on C-Media USB sound card
Date: Wed, 1 Oct 2014 17:51:57 +0800
Message-ID: <CAN8cciYtUa+XLVWcO-7NT0WO=_q1rLEyLjkyixqeWs-2a9Wo6g@mail.gmail.com>
References: <CAPMSj_FznSHmnamRBPEHJ4xCq38+=TaZ2Bh8kbUEMa6b+=2zdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A0442604A4
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 11:51:58 +0200 (CEST)
Received: by mail-qg0-f53.google.com with SMTP id a108so277368qge.12
 for <alsa-devel@alsa-project.org>; Wed, 01 Oct 2014 02:51:57 -0700 (PDT)
In-Reply-To: <CAPMSj_FznSHmnamRBPEHJ4xCq38+=TaZ2Bh8kbUEMa6b+=2zdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Allen M." <ase1592@gmail.com>, david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> >It affect your measurent if you are using the mic on your usb audio if
the
> >automatic gain control is switch on
>
> Automatic gain control is now switched off.
>
>
> >Background noise affect the result if you are not using line in and line
> >out with a loopback cable
>
> I am using loopback, noise should not be an issue.
>
>
> >How many steps need to reduce amplitude of the recorded sine wave by
> >half when you play a sine wav through your usb audio and record it back
> >using audacity?
>
> Using recorded sine wav provided by 'speaker-test -t sin'
> amplitude of recorded sine wave reduced by half at step 77
>
> output of 'amixer -c 2 set Headphone 77':
>  Simple mixer control 'Headphone',0
>    Capabilities: pvolume pswitch pswitch-joined
>    Playback channels: Front Left - Front Right
>    Limits: Playback 0 - 151
>    Mono:
>    Front Left: Playback 77 [51%] [-13.94dB] [on]
>    Front Right: Playback 77 [51%] [-13.94dB] [on]
>
>

Does this number of steps remain the same when your starting volume are not
at 151?

Your value 77 seem quite different from  alsamixertest

> >You many need to change the name of the volume control to headphone
> >playback volume in alsamixertest
>
> Done. alsamixertest output:http://ix.io/ezd

You may need David to analyse the result

Do those measured value match with those in datasheet?

Seem the measured dB range is larger than 27 dB

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/usb?qt=grep&q=cm106
