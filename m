From: Andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Sat, 12 Apr 2014 23:38:22 +0000 (UTC)
Message-ID: <loom.20140413T005909-442@post.gmane.org>
References: <loom.20140410T210136-313@post.gmane.org>
 <CAN8cciazgm+X37KuTBWspC0q=DPPjr47kgkXFgSKJiXfGAr+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C582610D6
 for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2014 01:38:34 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WZ7VJ-0005so-Mi
 for alsa-devel@alsa-project.org; Sun, 13 Apr 2014 01:38:33 +0200
Received: from cl-86-125-134-10.cablelink.mures.rdsnet.ro ([86.125.134.10])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2014 01:38:33 +0200
Received: from andoru.blah by cl-86-125-134-10.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2014 01:38:33 +0200
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

Okay, nevermind, the OS froze as I've tried to change the level on the PCM
channel, so I rebooted and tried to look for anything that might have left a
trace for what has happened, and I think I found what you were looking for:
http://pastebin.com/YfP61KBk

It was under /var/log/messages.0 (same things also under /var/log/syslog for
some weird reason)
I haven't been able to see what caused the freezing.

Also found this, not sure if it's useful:
_______________________________________________________________________
Apr 12 23:30:50 flying-topsoil kernel: [18087.771787]  [<c12b3777>] ?
dump_stack+0xa/0x13
Apr 12 23:30:50 flying-topsoil kernel: [18087.771813]  [<f819d839>] ?
xrun+0x9a/0xb2 [snd_pcm]
Apr 12 23:30:50 flying-topsoil kernel: [18087.771824]  [<c104e65d>] ?
ktime_get_ts+0x30/0x77
Apr 12 23:30:50 flying-topsoil kernel: [18087.771838]  [<f819e43c>] ?
snd_pcm_update_hw_ptr0+0x91/0x744 [snd_pcm]
Apr 12 23:30:50 flying-topsoil kernel: [18087.771847]  [<c103bca3>] ?
hrtimer_start_range_ns+0x20/0x25
Apr 12 23:30:50 flying-topsoil kernel: [18087.771853]  [<c103b9c2>] ?
hrtimer_try_to_cancel+0x4a/0x51
Apr 12 23:30:50 flying-topsoil kernel: [18087.771864]  [<f8198cbb>] ?
snd_pcm_hwsync+0x30/0x46 [snd_pcm]
Apr 12 23:30:50 flying-topsoil kernel: [18087.771874]  [<f819ab7b>] ?
snd_pcm_common_ioctl1+0x5c/0xa0f [snd_pcm]
_______________________________________________________________________
