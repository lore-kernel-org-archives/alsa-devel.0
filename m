From: Daniel Martin <consume.noise@gmail.com>
Subject: [hsw dp audio] Muting S/PDIF turns off DP
Date: Sun, 23 Mar 2014 17:31:17 +0100
Message-ID: <20140323163117.GA28667@core.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F3EB26089A
 for <alsa-devel@alsa-project.org>; Sun, 23 Mar 2014 17:33:05 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id mx12so317223bkb.35
 for <alsa-devel@alsa-project.org>; Sun, 23 Mar 2014 09:33:05 -0700 (PDT)
Received: from localhost (p4FC8DE17.dip0.t-ipconnect.de. [79.200.222.23])
 by mx.google.com with ESMTPSA id xj2sm11110666bkb.15.2014.03.23.09.33.03
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Mar 2014 09:33:04 -0700 (PDT)
Content-Disposition: inline
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

I've a bug here: when playing audio via the speakers of a monitor
attached to a DisplayPort and I mute the corresponding S/PDIF (i.e. with
alsamixer) then the monitor switches off into standby, unmuting the
S/PDIF turns the monitor back on.
When muting the S/PDIF while no audio is playing everything is fine.

There's no audio daemon running and my ~/.asoundrc contains only:

    pcm.!default {
        type hw
        card 0
        device 3
    }

I've already filed a fdo bug report (drm/intel) for this as I thought it
might be related to it:
    Bug 75729 - [hsw dp audio] Muting S/PDIF turns off DP
    https://bugs.freedesktop.org/show_bug.cgi?id=75729
Attached to this bug is a `alsa-info.log` too.

As stated in the bug report it's not a showstopper for me, but obviously
something seems to go wrong and maybe someone has an idea.

Thanks,
    Daniel Martin
