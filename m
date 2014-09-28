From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/13 v2] ALSA: Enhancement for Dice driver
Date: Mon, 29 Sep 2014 00:58:10 +0900
Message-ID: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AB35E26057C
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:43 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patchset is to update my previous series.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076730.html

The previous series includes some bugs, as a result, playback/capture is
not successfull. I've tested with actual device (TC Electronic, Impact
Twin) and fix so as Dice driver drives the device.

Currently this driver supports:
- up to 192kHz
- PCM playback/capture
- MIDI playback/capture
- Duplex streams with synchronization (with snd-firewire-lib)

This driver doesn't support:
- Synchronization between multiple devices on the same bus

The rest of issue:
- Handling bus reset
  Especially, just after powering on. Currently this driver often fails to
  probe device. I require more time to investigate. A workasound is to
  execute modprobe when the device is powered.

Takashi Sakamoto (13):
  ALSA: dice: Rename structure and its members
  ALSA: dice: Move file to its own directory
  ALSA: dice: Split transaction functionality into a file
  ALSA: dice: Split stream functionality into a file
  ALSA: dice: Split PCM functionality into a file
  ALSA: dice: Split hwdep functionality into a file
  ALSA: dice: Split proc functionality into a file
  ALSA: dice: Add new functions for limitation of PCM parameters
  ALSA: dice: Change the way to start stream
  ALSA: dice: Add support for duplex streams with synchronization
  ALSA: dice: Support for non SYT-Match sampling clock source mode
  ALSA: dice: Add support for PCM capture
  ALSA: dice: Add support for MIDI capture/playback

 sound/firewire/Kconfig                 |    3 -
 sound/firewire/Makefile                |    4 +-
 sound/firewire/dice-interface.h        |  371 --------
 sound/firewire/dice.c                  | 1511 --------------------------------
 sound/firewire/dice/Makefile           |    3 +
 sound/firewire/dice/dice-hwdep.c       |  190 ++++
 sound/firewire/dice/dice-interface.h   |  371 ++++++++
 sound/firewire/dice/dice-midi.c        |  173 ++++
 sound/firewire/dice/dice-pcm.c         |  389 ++++++++
 sound/firewire/dice/dice-proc.c        |  252 ++++++
 sound/firewire/dice/dice-stream.c      |  426 +++++++++
 sound/firewire/dice/dice-transaction.c |  370 ++++++++
 sound/firewire/dice/dice.c             |  364 ++++++++
 sound/firewire/dice/dice.h             |  189 ++++
 14 files changed, 2728 insertions(+), 1888 deletions(-)
 delete mode 100644 sound/firewire/dice-interface.h
 delete mode 100644 sound/firewire/dice.c
 create mode 100644 sound/firewire/dice/Makefile
 create mode 100644 sound/firewire/dice/dice-hwdep.c
 create mode 100644 sound/firewire/dice/dice-interface.h
 create mode 100644 sound/firewire/dice/dice-midi.c
 create mode 100644 sound/firewire/dice/dice-pcm.c
 create mode 100644 sound/firewire/dice/dice-proc.c
 create mode 100644 sound/firewire/dice/dice-stream.c
 create mode 100644 sound/firewire/dice/dice-transaction.c
 create mode 100644 sound/firewire/dice/dice.c
 create mode 100644 sound/firewire/dice/dice.h

-- 
1.9.1
