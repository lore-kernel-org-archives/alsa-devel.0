From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/29 v2] ALSA: Enhancement for existed
	FireWire drivers
Date: Sun, 26 Oct 2014 22:03:01 +0900
Message-ID: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AAE42606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:03:45 +0100 (CET)
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
for linux-next branch and all of my work for Linux 3.19.

== Features:
Currently, ALSA Dice driver is limited for playback-only devices. The aim
of this patchset is to add supports for:
 - Full-duplex streams with synchronization
 - Both PCM capture and playback
 - Both MIDI capture and playback

Currently, ALSA firewire-speakers driver is only for two playback-only models.
And this driver has a bug for one of them. The aim of this patchset is to fix
the bug and to add supports for more models with:
 - Both PCM capture and playback
 - Both MIDI capture and playback

The renew drivers doesn't support:
 - Synchronization between multiple devices on the same bus
   For this purpose, please join in user-space driver project (FFADO)
 - Any control functionality for internal DSP
   For this purpose, please use ffado-dbus-server/ffado-mixer,
   or write your own application


== Updates from my previous post:
[alsa-devel] [PATCH 00/14] ALSA: Dice enhancement
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/081890.html
 - Fix typo
 - Minor code change

[alsa-devel] [RFC][PATCH 00/15 v4] OXFW driver, a succesor to firewire-speakers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076581.html
 - Support more Mackie (Loud) models by name detection
 - Fix a bug to handle FireWave
 - Use AV/C Stream Format Information command to set sampling rate


== Remarks:
 - When the Dice driver is loaded, user-space driver fails to register
   notification address, thus cannot handle device for streaming. See:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081731.html
 - OXFW chipset seems to transmit wrong values for timestamp, thus the
   driver don't apply full-duplex streams with synchronization


== Supported Dice-based models (as long as I know):
TC Electronic
 - Desktop Konnekt 6
 - Impact Twin
 - Konnekt 8/24D/Live
 - Studio Konnekt 48
PreSonus
 - FireStudio 26x26/Mobile/Project/Tube/LightPipe
 - StudioLive 1602/1642/2442
 - FireStation
Mackie
 - Onyx Blackbird
 - Onyx i-series (latter models)
Focusrite
 - Saffire Pro 14/24/24 DSP/26/40/56
M-Audio
 - Profire 610/2626
Alessis
 - IO 24/26
 - MultiMix 12/16
Weiss
 - ADC2
 - Vesta
 - Mineva
 - AFI 1
 - TAG DAC 1
 - INT 202
 - DAC 202
 - Flex 5000
DnR
 - Axus FireWire I/O card 16x16
Lexicon
 - I-ONIX FW 810S
Allen and Heath
 - Zed R16
Midas
 - Venice F32

== Supported OXFW-based models (as long as I know):
Griffin:
 - FireWave
LaCie:
 - Firewire Speakers
Behringer:
 - F-Control Audio 202
Mackie (Loud):
 - Onyx-i series (former models)
 - Onyx Satellite
 - Tapco Link.Firewire
 - d.2 pro/d.4 pro
 - U.420/U.420d

Takashi Sakamoto (29):
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
 sound/firewire/Makefile                    |    6 +-
 sound/firewire/dice.c                      | 1511 ----------------------------
 sound/firewire/dice/Makefile               |    3 +
 sound/firewire/dice/dice-hwdep.c           |  190 ++++
 sound/firewire/{ => dice}/dice-interface.h |    0
 sound/firewire/dice/dice-midi.c            |  176 ++++
 sound/firewire/dice/dice-pcm.c             |  404 ++++++++
 sound/firewire/dice/dice-proc.c            |  252 +++++
 sound/firewire/dice/dice-stream.c          |  423 ++++++++
 sound/firewire/dice/dice-transaction.c     |  382 +++++++
 sound/firewire/dice/dice.c                 |  359 +++++++
 sound/firewire/dice/dice.h                 |  189 ++++
 sound/firewire/oxfw/Makefile               |    3 +
 sound/firewire/oxfw/oxfw-command.c         |  153 +++
 sound/firewire/oxfw/oxfw-control.c         |  283 ++++++
 sound/firewire/oxfw/oxfw-hwdep.c           |  190 ++++
 sound/firewire/oxfw/oxfw-midi.c            |  189 ++++
 sound/firewire/oxfw/oxfw-pcm.c             |  399 ++++++++
 sound/firewire/oxfw/oxfw-proc.c            |  113 +++
 sound/firewire/oxfw/oxfw-stream.c          |  702 +++++++++++++
 sound/firewire/oxfw/oxfw.c                 |  310 ++++++
 sound/firewire/oxfw/oxfw.h                 |  145 +++
 sound/firewire/speakers.c                  |  792 ---------------
 26 files changed, 4887 insertions(+), 2319 deletions(-)
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
1.9.1
