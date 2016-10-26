From: Olivier Schmitt <sc.olivier@gmail.com>
Subject: EMU0202 sample rate from line in ADC driver
Date: Wed, 26 Oct 2016 17:39:04 +0200
Message-ID: <CALzsnJQzC+XixBDxHzp+_Y60-MyRQoLQFLW3JPT-zby2eR9TDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 288172670FF
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 17:39:25 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id d128so91359557wmf.1
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 08:39:25 -0700 (PDT)
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

Hello,

I am SCHMITT Olivier and I am IT manager for a Radio Ham Club.

Let me explain quickly, I search to use ADC (line in) from an Creative
Creative EMU 0202 in 192K but it was detected on 48k sample rate only.


I have a machine that I need to update. It runs on 32-bit version 17
LinuxMint (it seems to be the version of ubuntu 14).
The card works in EMU0202 192k on this machine before.

I test all 32 and 64 bit version of Ubuntu Ubuntu 12.04 to Ubuntu 16.04 and
LinuxMint 13 to 18.

This card was only detected on 48k max and not 192k... USB2.0 for sure!


Here is the extract from alsa Repport:

Current new PC with fresh installation:

http://www.alsa-project.org/db/?f=d2aa1 ... 8485f89e30

old PC under linuxmint 17:

http://www.alsa-project.org/db/?f=5b1b5 ... 28e0eb2353

Can you tell me if it concerns your patch:

https://lab.nexedi.cn/kirr/linux/commit/89e1e66d6be8a520cdcd26043cda2c
c870a34015

OR can you say me how to get this 192khz for this input card?

Thanks in advance.
