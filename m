From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/30 v3] ALSA: Enhancement for existed
	FireWire drivers
Date: Sat, 29 Nov 2014 00:59:09 +0900
Message-ID: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 337932604B1
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patchset is to enable ALSA Dice driver to handle more models, to
improve ALSA firewire-speakers driver as OXFW driver. This patchset is
for linux-next branch.

== Updates from my previous post:

[alsa-devel] [PATCH 00/29 v2] ALSA: Enhancement for existed FireWire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082844.html

 - Add a patch to fix some minor bugs (dice)
 - Improve handling config-rom strings for loud models (oxfw) 
 - Fix a bug of mutual exclusive lock for AMDTP streams (oxfw)
 - Obsolete atomic_t for reference counters (dice/oxfw)

Takashi Sakamoto (30):
  ALSA: dice: suppress checkpatch.pl warnings
  ALSA: dice: Rename structure and its members
  ALSA: dice: Move file to its own directory
  ALSA: dice: Split transaction functionality into a file
  ALSA: dice: Split stream functionality into a file
  ALSA: dice: Split PCM functionality into a file
  ALSA: dice: Split hwdep functionality into a file
  ALSA: dice: Split proc interface into a file
  ALSA: dice: Add new functions for constraints of PCM parameters
  ALSA: dice: Change the way to start stream
  ALSA: dice: Add support for duplex streams with synchronization
  ALSA: dice: Support for non SYT-Match sampling clock source mode
  ALSA: dice: Add support for capturing PCM samples
  ALSA: dice: Add support for MIDI capture/playback
  ALSA: dice: remove experimental state
  ALSA: speakers: Rename to oxfw and rename some members
  ALSA: oxfw: Move to its own directory
  ALSA: oxfw: Split stream functionality to a new file and add a header
    file
  ALSA: oxfw: Split PCM functionality to a new file
  ALSA: oxfw: Split control functionality to a new file
  ALSA: oxfw: Change the way to name card
  ALSA: oxfw: Add support for AV/C stream format command to get/set
    supported stream formation
  ALSA: oxfw: Change the way to make PCM rules/constraints
  ALSA: oxfw: Add proc interface for debugging purpose
  ALSA: oxfw: Change the way to start stream
  ALSA: oxfw: Add support for Behringer/Mackie devices
  ALSA: oxfw: Add support AMDTP in-stream
  ALSA: oxfw: add support for capturing PCM samples
  ALSA: oxfw: Add support for capture/playback MIDI messages
  ALSA: oxfw: Add hwdep interface

 include/uapi/sound/asound.h                |    3 +-
 include/uapi/sound/firewire.h              |    3 +-
 sound/firewire/Kconfig                     |   26 +-
 sound/firewire/Makefile                    |    7 +-
 sound/firewire/dice.c                      | 1511 ----------------------------
 sound/firewire/dice/Makefile               |    3 +
 sound/firewire/dice/dice-hwdep.c           |  190 ++++
 sound/firewire/{ => dice}/dice-interface.h |    0
 sound/firewire/dice/dice-midi.c            |  194 ++++
 sound/firewire/dice/dice-pcm.c             |  424 ++++++++
 sound/firewire/dice/dice-proc.c            |  252 +++++
 sound/firewire/dice/dice-stream.c          |  407 ++++++++
 sound/firewire/dice/dice-transaction.c     |  382 +++++++
 sound/firewire/dice/dice.c                 |  361 +++++++
 sound/firewire/dice/dice.h                 |  189 ++++
 sound/firewire/oxfw/Makefile               |    3 +
 sound/firewire/oxfw/oxfw-command.c         |  153 +++
 sound/firewire/oxfw/oxfw-control.c         |  283 ++++++
 sound/firewire/oxfw/oxfw-hwdep.c           |  190 ++++
 sound/firewire/oxfw/oxfw-midi.c            |  207 ++++
 sound/firewire/oxfw/oxfw-pcm.c             |  425 ++++++++
 sound/firewire/oxfw/oxfw-proc.c            |  113 +++
 sound/firewire/oxfw/oxfw-stream.c          |  685 +++++++++++++
 sound/firewire/oxfw/oxfw.c                 |  315 ++++++
 sound/firewire/oxfw/oxfw.h                 |  145 +++
 sound/firewire/speakers.c                  |  792 ---------------
 26 files changed, 4944 insertions(+), 2319 deletions(-)
 delete mode 100644 sound/firewire/dice.c
 create mode 100644 sound/firewire/dice/Makefile
 create mode 100644 sound/firewire/dice/dice-hwdep.c
 rename sound/firewire/{ => dice}/dice-interface.h (100%)
 create mode 100644 sound/firewire/dice/dice-midi.c
 create mode 100644 sound/firewire/dice/dice-pcm.c
 create mode 100644 sound/firewire/dice/dice-proc.c
 create mode 100644 sound/firewire/dice/dice-stream.c
 create mode 100644 sound/firewire/dice/dice-transaction.c
 create mode 100644 sound/firewire/dice/dice.c
 create mode 100644 sound/firewire/dice/dice.h
 create mode 100644 sound/firewire/oxfw/Makefile
 create mode 100644 sound/firewire/oxfw/oxfw-command.c
 create mode 100644 sound/firewire/oxfw/oxfw-control.c
 create mode 100644 sound/firewire/oxfw/oxfw-hwdep.c
 create mode 100644 sound/firewire/oxfw/oxfw-midi.c
 create mode 100644 sound/firewire/oxfw/oxfw-pcm.c
 create mode 100644 sound/firewire/oxfw/oxfw-proc.c
 create mode 100644 sound/firewire/oxfw/oxfw-stream.c
 create mode 100644 sound/firewire/oxfw/oxfw.c
 create mode 100644 sound/firewire/oxfw/oxfw.h
 delete mode 100644 sound/firewire/speakers.c

-- 
2.1.0
