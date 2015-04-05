From: Stanislav Sergiienko <pythonpowerd@gmail.com>
Subject: BugReport: Dice works partially [Broken]
Date: Sun, 5 Apr 2015 15:15:24 +0300
Message-ID: <CAPv3Zfxaw9ZEBd_JjCoHjHC=xxJyEpG+dLHpB-vrmNCms=0uRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f45.google.com (mail-vn0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 660FE261481
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2015 14:15:25 +0200 (CEST)
Received: by vnbg62 with SMTP id g62so1070531vnb.7
 for <alsa-devel@alsa-project.org>; Sun, 05 Apr 2015 05:15:24 -0700 (PDT)
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

Hi, I am a user of TC Electronic DesktopKonnekt6 and latest kernel
update 3.19.2 add partial support for my device and thus broke my
usual sound workflow. So i want to make good bug report to make device
usable on latest kernels.

With 3.19.2 kernel device is successfully recognized by system and
even sometimes can play sound(!). But always, after some time sound is
breaks (usually after 30-90 seconds) and to restore it i must restart
pulseaudio(v6.0) and application. So device becomes unusable on
latests kernels.
Earlier i use my sound card through ffado + jackdbus + pulseaudio. Now
it's impossible, so i have to downgrade kernel.

Please request any additional info that you need to fix problem and i
will post it here soon. Also i can test any "bleeding edge" changes
thru dkms as described here:
https://github.com/takaswie/snd-firewire-improve

Related bug(not mine):
https://bugs.archlinux.org/task/44258

Some useful info:

cat /proc/asound/cards
 0 [DesktopKonnekt6]: DICE - DesktopKonnekt6
                      TC Electronic DesktopKonnekt6 (serial 12941) at
fw1.0, S400

cat /proc/asound/card0/dice
sections:
  global: offset 10, size 90
  tx: offset 100, size 142
  rx: offset 242, size 282
  ext_sync: offset 524, size 4
  unused2: offset 0, size 0
global:
  owner: ffc1:000100000000
  notification: 00000040
  nick name: DesktopKonnekt6
  clock select: internal 44100
  enable: 1
  status: locked 44100
  ext status: 00000000
  sample rate: 44100
  version: 1.0.4.0
  clock caps: 44100 48000 88200 96000 176400 192000 arx1 arx2 internal
  clock source names:
Unused\Unused\Unused\Unused\Unused\Unused\Unused\Unused\Unused\Unused\Unused\Unused\INTERNAL\\
tx 0:
  iso channel: 0
  audio channels: 6
  midi ports: 0
  speed: S400
  names: ch 1\ch 2\ - \ - \ - \ - \\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: 1
  sequence start: 0
  audio channels: 6
  midi ports: 0
  names: main out 1\main out 2\phones out 1\phones out 2\ - \ - \\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 44100
  adat user data: 0
