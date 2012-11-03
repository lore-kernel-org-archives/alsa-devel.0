From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Sat, 3 Nov 2012 08:37:44 +0800
Message-ID: <CAN8ccia86GNJrXkDQM9zxrcBD6+5oqTYn6wk-ZVamW0VV1iQOA@mail.gmail.com>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
 <k70n1l$65a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D1963265100
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 01:37:47 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so2676239qcs.38
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2012 17:37:45 -0700 (PDT)
In-Reply-To: <k70n1l$65a$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

https://launchpadlibrarian.net/121871263/alsainfo.txt

>>
>> do widge 0x3e has amp-out for subwoofer volume control ?
>
>
> Nope. The sound path I got finally are :
> 08/34/14/24/00
> 08/21/14/24/00
> 09/3c/1c/33/00
> 08/35/15/25/00
> 08/21/15/25/00
>
> So, front on 0x08, shared with HP, and subwoofer on 0x09. Volumes are on
0x08 and 0x09 controls,
> afaik there are no more volume controls there.

how about the channel map ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=be84bbcccc757b86449daaf924e72f95c95dc00e;hp=2d3391ec0ecca37efb6bc995906292f47522b471

do your patched driver really work with pulseaudio 2.0 if there is no
headphone playback volume controls ?

Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'OFF' 'ON'
  Item0: 'OFF'

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 42
  Mono:
  Front Left: Playback 42 [100%] [0.00dB] [on]
  Front Right: Playback 42 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 42
  Mono:
  Front Left: Playback 42 [100%] [0.00dB] [on]
  Front Right: Playback 42 [100%] [0.00dB] [on]

if independent headphone is ON, two different audio stereo streams can play
using device 0 (speaker) and device 2 (headphone)

dac 0x08 cannot be shared beween headphone 0x25 and speaker 0x24

do a notebook really need independent headphone ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=a2a870c82797e47884b2736e95e9d9c89a51c219;hp=5c9a5615dedec19196b1217e864616a2ce9e392a

0: PCH [HDA Intel PCH], device 0: VT1802 Analog [VT1802 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: VT1802 Digital [VT1802 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: VT1802 HP [VT1802 HP]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
