From: Pavel <mr3sge@gmail.com>
Subject: mint 13 mate + ATI IXP SB4x0 High Definition Audio
	Controller (rev 01)
Date: Thu, 20 Jun 2013 21:09:42 +0300
Message-ID: <CABgcorNDv1QOw6yoY+gpFJBya-XFbQSFXeypjwYv7w2oJXL8kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f67.google.com (mail-oa0-f67.google.com
 [209.85.219.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 31891265342
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 20:09:44 +0200 (CEST)
Received: by mail-oa0-f67.google.com with SMTP id l10so3584635oag.6
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 11:09:42 -0700 (PDT)
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

Hello! i have a big problem - no sound after install linux mint 13
mate. well, sometimes if i reboot - i have it, but after nex reboot -
no sound no more, seems like pulseaudio don't see my sound card.

Laptop: Manufacturer: FUJITSU SIEMENS

Product Name: AMILO Pa 1510

Product Version: Not Applicable

Firmware Version: 1.07C

soundcard: 00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI
IXP SB4x0 High Definition Audio Controller (rev 01)

kernel 3.2.0-48-generic

dmesg: http://pastebin.com/KF8ABwnY alsa-info: http://pastebin.com/QYBYNJi9

i read this topic: https://bugzilla.kernel.org/show_bug.cgi?id=18512
and tried to add "options snd-hda-intel model=6stack-dig single_cmd=1"
to alsa-base.conf - it helped, after reboot i has sound, till i reboot
- now no sound no more.. i tried everything i found in the google,
even alsa-update - http://www.stchman.com/alsa_update.html

nothing can help me, but i understand that's the problem is in the driver..

can someone pls help me to fix the problem?

thank you.
