From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/13 v1] Enhancement for Dice driver
Date: Sun, 18 May 2014 22:36:25 +0900
Message-ID: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 53D60264F19
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 15:36:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patchset is for enhancement of Dice driver.

This patchset is based on this series. (This series is under reviewing.)
[alsa-devel] [PATCH 00/49 v4] Enhancement for support of Firewire devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075841.html

If you try this patchset, please apply the series in advance then apply this patchset.

Or just use backport codes in my github repository:
https://github.com/takaswie/snd-firewire-improve

Or if you use Ubuntu 14.04, DKMS package is available from David's PPA.
(Special thanks to David Henningsson.)
https://launchpad.net/~diwic/+archive/snd-firewire-improve

If you have any Dice based devices, please test this patchset because I can't test this driver with actual devices.


== Background

Dice is 'Digital Interface Communications Engine', produced by TC Applied Technologies.
Several vendors produced devices with Dice chipsets.

Currently, ALSA driver for Dice chipset has some restrictions:
 - Support playback of PCM samples only
 - Support SYT-Match mode for sampling clock source only

This patchset adds more functionality into the driver:
 - Support both of capture/playback
 - Support both of PCM/MIDI
 - Support both of SYT-Match or non SYT-Match mode


== Call for testing
I don't have any Dice based devices.

So I work for this patchset with my experiences for the other drivers and some stub codes. So it may not work fine, perhaps. If you have some Dice based devices, I hope you to test these patches and report the result. If it works badly, please get transaction logs and send it to me.

The way to get transaction logs is:
1. Set debug parameter of 'firewire-ohci' driver. With root privillege:
 $ echo 1 > /sys/module/firewire_ohci/parameters/debug
2. Then transaction logs are output to /var/log/syslog
 $ tail -n 10 /var/log/syslog
  kernel: [ 2376.107790] snd_dice fw1.0: transaction failed: address error
  kernel: [ 2376.108015] firewire_core 0000:02:00.0: created device fw1: GUID 00a0de000002e247, S400
  kernel: [ 2382.044469] firewire_ohci 0000:02:00.0: AR evt_bus_reset, generation 25
  kernel: [ 2384.095868] snd_dice fw1.0: transaction failed: bus reset
  kernel: [ 2384.143898] snd_dice fw1.0: transaction failed: bus reset
  kernel: [ 2389.517686] firewire_ohci 0000:02:00.0: AR evt_bus_reset, generation 26
  kernel: [ 2390.015821] firewire_ohci 0000:02:00.0: AT spd 0 tl 1f, ffc0 -> ffc1, evt_missing_ack, QR req, fffff0000400
  kernel: [ 2392.885455] firewire_ohci 0000:02:00.0: AR evt_bus_reset, generation 27
  kernel: [ 2392.885504] firewire_core 0000:02:00.0: phy config: new root=ffc1, gap_count=5
  kernel: [ 2392.885534] firewire_ohci 0000:02:00.0: AT ack_complete, PHY 01c50000 fe3affff
  kernel: [ 2392.885556] firewire_ohci 0000:02:00.0: AR evt_bus_reset, generation 28
  kernel: [ 2393.025757] firewire_ohci 0000:02:00.0: AT spd 0 tl 2a, ffc1 -> ffc0, ack_pending , QR req, fffff0000400
  kernel: [ 2393.026007] firewire_ohci 0000:02:00.0: AR spd 2 tl 2a, ffc0 -> ffc1, ack_complete, QR resp = 041fa8cb
  kernel: [ 2393.026076] firewire_ohci 0000:02:00.0: AT spd 0 tl 2b, ffc1 -> ffc0, ack_pending , QR req, fffff0000404
  kernel: [ 2393.026172] firewire_ohci 0000:02:00.0: AR spd 2 tl 2b, ffc0 -> ffc1, ack_complete, QR resp = 31333934
  kernel: [ 2393.026251] firewire_ohci 0000:02:00.0: AT spd 0 tl 2c, ffc1 -> ffc0, ack_pending , QR req, fffff0000408
  kernel: [ 2393.030558] firewire_ohci 0000:02:00.0: AR spd 2 tl 2c, ffc0 -> ffc1, ack_complete, QR resp = f0646122
3. Please send me the output since you plug-in your device (not whole)
4. And please tell me how you test, which devices you test with and what result you got


== All patches

My work for ALSA firewire drivers are available in my remote repository:
https://github.com/takaswie/sound

It includes 77 patches. I'm always welcome to receive some comments about them.

Takashi Sakamoto (13):
  dice: Rename structure and its members
  dice: Move file to its own directory
  dice: Split transaction functionality into a file
  dice: Split stream functionality into a file
  dice: Split PCM functionality into a file
  dice: Split hwdep functionality into a file
  dice: Split proc functionality into a file
  dice: Add new functions for limitation of PCM parameters
  dice: Change the way to start stream
  dice: Add support for duplex streams with synchronization
  dice: Support for non SYT-Match sampling clock source mode
  dice: Add support for PCM capture
  dice: Add support for MIDI capture/playback

 sound/firewire/Kconfig                 |    4 +-
 sound/firewire/Makefile                |    3 +-
 sound/firewire/dice-interface.h        |  371 --------
 sound/firewire/dice.c                  | 1500 --------------------------------
 sound/firewire/dice/Makefile           |    3 +
 sound/firewire/dice/dice-interface.h   |  371 ++++++++
 sound/firewire/dice/dice.c             |  374 ++++++++
 sound/firewire/dice/dice.h             |  189 ++++
 sound/firewire/dice/dice_hwdep.c       |  190 ++++
 sound/firewire/dice/dice_midi.c        |  173 ++++
 sound/firewire/dice/dice_pcm.c         |  389 +++++++++
 sound/firewire/dice/dice_proc.c        |  252 ++++++
 sound/firewire/dice/dice_stream.c      |  410 +++++++++
 sound/firewire/dice/dice_transaction.c |  359 ++++++++
 14 files changed, 2712 insertions(+), 1876 deletions(-)
 delete mode 100644 sound/firewire/dice-interface.h
 delete mode 100644 sound/firewire/dice.c
 create mode 100644 sound/firewire/dice/Makefile
 create mode 100644 sound/firewire/dice/dice-interface.h
 create mode 100644 sound/firewire/dice/dice.c
 create mode 100644 sound/firewire/dice/dice.h
 create mode 100644 sound/firewire/dice/dice_hwdep.c
 create mode 100644 sound/firewire/dice/dice_midi.c
 create mode 100644 sound/firewire/dice/dice_pcm.c
 create mode 100644 sound/firewire/dice/dice_proc.c
 create mode 100644 sound/firewire/dice/dice_stream.c
 create mode 100644 sound/firewire/dice/dice_transaction.c

-- 
1.8.3.2
