From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 09:20:24 +0900
Message-ID: <CAJ0eYfXCX_0C-v0cGOwieDDCOn6q4Mt9JvBG7CxA51yOrALSpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f45.google.com (mail-vn0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 16E6926041F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 02:20:26 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so2831328vnb.3
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 17:20:25 -0700 (PDT)
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

Clemens wrote:
>> You should replace "hw" with "plughw" in the device name.

So you were referring to:

% aplay -L
plughw:CARD=Orpheus,DEV=0
    Orpheus, Orpheus PCM
    Hardware device with all software conversions

> Any error message in the system log?

% tail dmesg?.txt

==> dmesg1.txt <== this is just after booting.

[   21.439026] r8169 0000:02:00.0 eth0: link down
[   23.809013] r8169 0000:02:00.0 eth0: link up

==> dmesg2.txt <== this is just after connecting Orpheus.

[   21.439026] r8169 0000:02:00.0 eth0: link down
[   23.809013] r8169 0000:02:00.0 eth0: link up
[  110.079264] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5
[  110.343319] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5
[  110.580310] firewire_core 0000:08:00.0: created device fw1: GUID
00119800010001f9, S400
[  113.660273] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08

==> dmesg3.txt <== this is just after % aplay -D plughw:2,0 test.wav

[   21.439026] r8169 0000:02:00.0 eth0: link down
[   23.809013] r8169 0000:02:00.0 eth0: link up
[  110.079264] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5
[  110.343319] firewire_core 0000:08:00.0: phy config: new root=ffc1,
gap_count=5
[  110.580310] firewire_core 0000:08:00.0: created device fw1: GUID
00119800010001f9, S400
[  113.660273] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[  128.010593] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[  133.416998] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
[  136.275142] snd-bebob fw1.0: Detect discontinuity of CIP: 50 70
[  137.654178] snd-bebob fw1.0: Detect discontinuity of CIP: 70 90

% ls -l dmesg?.txt
-rw-rw-r-- 1 user1 user1 72728 Apr 24 08:42 dmesg1.txt
-rw-rw-r-- 1 user1 user1 73050 Apr 24 08:42 dmesg2.txt
-rw-rw-r-- 1 user1 user1 73318 Apr 24 08:43 dmesg3.txt

% egrep 'Apr 24 08:42|Apr 24 08:43' /var/log/syslog

Apr 24 08:42:24 host gnome-session[1466]: WARN  2015-04-24 08:42:24
unity.dash.gsettingsscopereader GSettingsScopes.cpp:108 Error fetching
protocol metadata for scope: social.scope : Valid key file could not be
found in search dirs
Apr 24 08:42:44 host kernel: [  110.079264] firewire_core 0000:08:00.0: phy
config: new root=ffc1, gap_count=5
Apr 24 08:42:45 host kernel: [  110.343319] firewire_core 0000:08:00.0: phy
config: new root=ffc1, gap_count=5
Apr 24 08:42:45 host kernel: [  110.580310] firewire_core 0000:08:00.0:
created device fw1: GUID 00119800010001f9, S400
Apr 24 08:42:48 host kernel: [  113.660273] snd-bebob fw1.0: Detect
discontinuity of CIP: 00 08
Apr 24 08:43:02 host kernel: [  128.010593] snd-bebob fw1.0: Detect
discontinuity of CIP: 00 08
Apr 24 08:43:08 host kernel: [  133.416998] snd-bebob fw1.0: Detect
discontinuity of CIP: 00 08
Apr 24 08:43:11 host rtkit-daemon[1163]: Supervising 4 threads of 1
processes of 1 users.
Apr 24 08:43:11 host rtkit-daemon[1163]: Successfully made thread 1900 of
process 1540 (n/a) owned by '1000' RT at priority 5.
Apr 24 08:43:11 host rtkit-daemon[1163]: Supervising 5 threads of 1
processes of 1 users.
Apr 24 08:43:11 host kernel: [  136.275142] snd-bebob fw1.0: Detect
discontinuity of CIP: 50 70
Apr 24 08:43:12 host kernel: [  137.654178] snd-bebob fw1.0: Detect
discontinuity of CIP: 70 90
Apr 24 08:43:14 host pulseaudio[1540]: [alsa-source-BeBoB] alsa-util.c:
Could not recover from POLLERR|POLLNVAL|POLLHUP and XRUN: Connection timed
out
Apr 24 08:43:17 host systemd[1]: Stopping User Manager for UID 112...

***

Any clues?

Mike Ood
--
% uname -a
Linux host 3.19.0-15-generic #15-Ubuntu SMP Thu Apr 16 23:32:37 UTC 2015
x86_64 x86_64 x86_64 GNU/Linux
--
