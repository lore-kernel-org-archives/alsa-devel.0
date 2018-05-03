From: Xristos Boul <sirmihawk@gmail.com>
Subject: [BUG - REPORT] ALC892 not working
Date: Thu, 3 May 2018 12:42:40 +0300
Message-ID: <CAKuPMuRk3HYQhxkONN5duQotHUQen2VF8riSeA90NSmj_8HXcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CC9B266F46
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 11:42:41 +0200 (CEST)
Received: by mail-oi0-f50.google.com with SMTP id k5-v6so8709818oiw.0
 for <alsa-devel@alsa-project.org>; Thu, 03 May 2018 02:42:41 -0700 (PDT)
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

Hi everyone,

I'm having a problem with my line-out port not being working properly.
Specifically it can't play audio when the 'alsamixer' auto-mute mode is
enabled, so sound is coming only from the headphones.However, when
auto-mute is disabled the sound is coming from both ports simultaneously.

I'm using the Asus Z170-A mobo with ALC892 codec, OS: Arch

I ran alsa-info.sh on both cases and i saw that the Pin-Complex 0x14 had
'Pin-ctls: OUT' when  auto-mute was disabled whereas when auto-mute was
enabled it was 'Pin-ctls: 0x00' (as it currenly is).

So i ran HDA-analyzer tool and changed that widget setting to 'OUT' and
obviously i produced the same behaviour like when i disabled 'auto-mute'
(again sound coming from both ports) and also in all cases PulseAudio lists
the 'Line-out' port as 'unplugged'.

Also 2 more things:

1st: In BIOS when i changed the driver for the Front panel from 'HD-Audio'
to 'AC97' and the ports worked correctly, however no 'auto-mute' mode was
available so i had to mute the ports manually when i plugged/unplugged the
headphones for e.x

I tried uninstalling PulseAudio to see if it was the case but the problem
persisted so i think it really is some codec problem since i also have a
similar problem in Windows OS.

2nd: When i unplugged the Front-panel connection from the mobo the port
played correctly. So is it maybe a mixer problem or something related?

Finally i tried every 'model' parameter from HD-Audio-Models.txt for ALC892
but got nothing.

In any case i'm attaching the current alsa-info.sh. If you would like i
could also send alsa-info.sh for all those cases above.

I don't think i'm alone in this issue but i would greatly appreciate the
help!

Thanks in advance.

Link to alsa-info.txt ->
http://www.alsa-project.org/db/?f=1020241a74addd837a3625d3f1c6be374996aa71
