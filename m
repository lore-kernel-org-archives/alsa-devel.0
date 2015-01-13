From: Dheeraj CVR <cvr.dheeraj@gmail.com>
Subject: Configuring slave output for ALC889
Date: Tue, 13 Jan 2015 15:36:26 +0400
Message-ID: <CAH-=PyTK9pp7uSA5vErWiD-oYKgDBv89eQ3qwk8VWxw+owMZig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B14A260420
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 12:36:27 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id 10so2083213lbg.1
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 03:36:27 -0800 (PST)
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

I am using an Intel Desktop Board DX58SO. I am using S/PDIF for HDMI Audio
and there is no sound output via HDMI. I have checked with alsamixer and
the volumes for the S/PDIF are stuck at 0 and I can't increase them. By
looking at the commit history, I have found this commit which enables 0x10
as a slave output for 0x6 on ALC889 for the exact same board that I am
using.

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April/015901.html

However, it appears that with the commit "ALSA: hda/realtek - Drop ALC882
desktop model quirks", the older workaround has been removed, which caused
a regression.

I have checked the output of alsainfo and it seems that 0x06 is still being
used instead of 0x010.

Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Control: name="SPDIF Phantom Jack", index=1, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x99430130: [Fixed] SPDIF Out at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06

I was planning to edit the "patch_alc882" function to configure the
"spec->gen.slave_dig_outs" and set the values to "{0x10, 0, 0}". However, I
was not sure if this was the right way of doing.

Please advice.

I am running Arch-Linux with 3.17 kernel.

-- 
Regards,
Dheeraj CVR.
