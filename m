From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/14] ALSA: Dice enhancement
Date: Sat,  4 Oct 2014 20:27:10 +0900
Message-ID: <1412422044-15133-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 16363260555
 for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2014 13:27:35 +0200 (CEST)
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

This 14 patchset is to enable ALSA Dice driver to handle more models with
some functionalities:
 - up to 192.0 kHz
 - PCM capture
 - MIDI playback/capture
 - Duplex streams with synchronization (with snd-firewire-lib)

This driver doesn't support:
 - Synchronization between multiple devices on the same bus
   For this purpose, please join in user-space driver project (FFADO)
 - Any control functionality for internal DSP
   For this purpose, please use ffado-dbus-server/ffado-mixer,
   or write your own application

Remarks:
 - When this driver is loaded, user-space driver fails to register
   notification address, thus cannot handle device for streaming. See:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081731.html

Newly supported models (as long as I know):
Supported devices:
TC Electronic
	Desktop Konnekt 6
	Impact Twin
	Konnekt 8/24D/Live
	Studio Konnekt 48
PreSonus
	FireStudio 26x26/Mobile/Project/Tube/LightPipe
	StudioLive 1602/1642/2442
	FireStation
Mackie
	Onyx Blackbird
	Onyx i-series (latter models)
Focusrite
	Saffire Pro 14/24/24 DSP/26/40/56
M-Audio
	Profire 610/2626
Alessis
	IO 24/26
	MultiMix 12/16
Weiss
	ADC2
	Vesta
	Mineva
	AFI 1
	TAG DAC 1
	INT 202
	DAC 202
	Flex 5000
DnR
	Axus FireWire I/O card 16x16
Lexicon
	I-ONIX FW 810S
Allen and Heath
	Zed R16
Midas
	Venice F32

Updates from my previous RFC:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081673.html
 - Improve bus reset handling, especially for registering notification address
   At bus reset, Dice devices initialize a register for notification address,
   then drivers need to register the address again.
   Just after powering on, devices generates any bus reset, then drivers often
   fail to detect stream formation because this operation requires to change
   sampling rate.
   My improvement is retries to register notification address when notification
   wait is timed out.
 - Remove experimental state
 - Fix minor bugs

Takashi Sakamoto (14):
  ALSA: dice: Rename structure and its members
  ALSA: dice: Move file to its own directory
  ALSA: dice: Split transaction functionality into a file
  ALSA: dice: Split stream functionality into a file
  ALSA: dice: Split PCM functionality into a file
  ALSA: dice: Split hwdep functionality into a file
  ALSA: dice: Split proc functionality into a file
  ALSA: dice: Add new functions for restriction of PCM parameters
  ALSA: dice: Change the way to start stream
  ALSA: dice: Add support for duplex streams with synchronization
  ALSA: dice: Support for non SYT-Match sampling clock source mode
  ALSA: dice: Add support for PCM capture
  ALSA: dice: Add support for MIDI capture/playback
  ALSA: dice: remove experimental state

 sound/firewire/Kconfig                     |    7 +-
 sound/firewire/Makefile                    |    3 +-
 sound/firewire/dice.c                      | 1511 ----------------------------
 sound/firewire/dice/Makefile               |    3 +
 sound/firewire/dice/dice-hwdep.c           |  190 ++++
 sound/firewire/{ => dice}/dice-interface.h |    0
 sound/firewire/dice/dice-midi.c            |  176 ++++
 sound/firewire/dice/dice-pcm.c             |  404 ++++++++
 sound/firewire/dice/dice-proc.c            |  252 +++++
 sound/firewire/dice/dice-stream.c          |  424 ++++++++
 sound/firewire/dice/dice-transaction.c     |  380 +++++++
 sound/firewire/dice/dice.c                 |  359 +++++++
 sound/firewire/dice/dice.h                 |  189 ++++
 13 files changed, 2380 insertions(+), 1518 deletions(-)
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

-- 
1.9.1
