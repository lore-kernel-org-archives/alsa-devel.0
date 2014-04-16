From: Ronald <ronald645@gmail.com>
Subject: v3.15-rc1: CORB reset timeout#1, CORBRP = 0
Date: Wed, 16 Apr 2014 10:30:13 +0200
Message-ID: <CAF1_xX2uRcHHeRd1Zpxa30KveP94Ot7WQk5ut0kopARZVBRVjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D29C3261A66
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 10:30:13 +0200 (CEST)
Received: by mail-qa0-f52.google.com with SMTP id s7so8470075qap.11
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 01:30:13 -0700 (PDT)
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

Just rebuild v3.15. The message in the subject appears to be at the
error level. Sound plays fine. Everything seems to work as intended.

[    6.779741] snd_hda_intel 0000:00:10.1: Disabling MSI
[    6.781978] ALSA device list:
[    6.781980]   No soundcards found.
[    6.785907] snd_hda_intel 0000:00:10.1: CORB reset timeout#1, CORBRP = 0
[    7.670040] sound hdaudioC0D0: autoconfig: line_outs=1
(0x10/0x0/0x0/0x0/0x0) type:speaker
[    7.670046] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.670049] sound hdaudioC0D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
[    7.670052] sound hdaudioC0D0:    mono: mono_out=0x0
[    7.670055] sound hdaudioC0D0:    dig-out=0x13/0x0
[    7.670057] sound hdaudioC0D0:    inputs:
[    7.670060] sound hdaudioC0D0:      Mic=0x14
[    8.730734] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:10.1/sound/card0/hdaudioC0D0/input10
[    8.731256] input: HDA NVidia Front Headphone as
/devices/pci0000:00/0000:00:10.1/sound/card0/input11

Is this reason for concern?
