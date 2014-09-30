From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Tue, 30 Sep 2014 15:22:40 -0500
Message-ID: <CAPMSj_FznSHmnamRBPEHJ4xCq38+=TaZ2Bh8kbUEMa6b+=2zdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9BA26047A
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 22:22:41 +0200 (CEST)
Received: by mail-yk0-f172.google.com with SMTP id 19so914694ykq.17
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 13:22:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:

>It affect your measurent if you are using the mic on your usb audio if the
>automatic gain control is switch on

Automatic gain control is now switched off.


>Background noise affect the result if you are not using line in and line
>out with a loopback cable

I am using loopback, noise should not be an issue.


>How many steps need to reduce amplitude of the recorded sine wave by
>half when you play a sine wav through your usb audio and record it back
>using audacity?

Using recorded sine wav provided by 'speaker-test -t sin'
amplitude of recorded sine wave reduced by half at step 77

output of 'amixer -c 2 set Headphone 77':
 Simple mixer control 'Headphone',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 151
   Mono:
   Front Left: Playback 77 [51%] [-13.94dB] [on]
   Front Right: Playback 77 [51%] [-13.94dB] [on]


>You many need to change the name of the volume control to headphone
>playback volume in alsamixertest

Done. alsamixertest output: http://ix.io/ezd
