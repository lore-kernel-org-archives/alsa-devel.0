From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/37] ALSA: firewire: support AMDTP
	variants
Date: Sat, 11 Jul 2015 23:12:11 +0900
Message-ID: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8398C260557
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:02 +0200 (CEST)
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
Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>, alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is for three new drivers and related modification to
firewire-lib module.

Overview:
 * Patch 01-02: for firewire-lib, to split AMDTP layer to two parts
 * Patch 03-07: for firewire-lib, to add MIDI asynchronous transaction
 * Patch 08-16: for firewire-digi00x, a new driver for Digi 002/003 family
 * Patch 17-26: for firewire-tascam, a new driver for TASCAM FireWire series
 * Patch 27-28: for firewire-lib, to add SPH field in CIP header support
 * Patch 29-37: for firewire-motu, a new driver for MOTU FireWire series

Status:
 * firewire-digi00x:
  * well-prepared, except for final testing with Digi 003 series
 * firewire-tascam:
  * well-prepared, except for conversion of controll messages to MIDI
 * firewire-motu:
  * experimental, for preview to developers

As the other my RFCs, I prepare for a branch in my backport repository,
to make it easy to test this patchset.
https://github.com/takaswie/snd-firewire-improve/tree/amdtp-variants

I'm happy if receiving your comments, reviews, tests and your patches.
I have a plan to posting patches again to merging these well-prepared
drivers till next merge window for Linux 4.3.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>

Regards

Takashi Sakamoto (37):
  ALSA: firewire-lib: rename 'amdtp' to 'amdtp-stream' for functional
    separation
  ALSA: firewire-lib: functional separation between packet stream and
    data block format
  ALSA: firewire-lib: add helper functions for asynchronous MIDI port
  ALSA: firewire-lib: serialize request transaction and response
    transaction
  ALSA: firewire-lib: schedule tasklet again when MIDI substream has
    rest of MIDI messages
  ALSA: firewire-lib: add throttle for MIDI data rate
  ALSA: firewire-lib: avoid endless loop to transfer MIDI messages at
    fatal error
  ALSA: firewire-digi00x: add skelton for Digi 002/003 family
  ALSA: firewire-digi00x: add protocol layer
  ALSA: firewire-digi00x: add stream functionality
  ALSA: firewire-digi00x: add proc node to show clock status
  ALSA: firewire-digi00x: add PCM functionality
  ALSA: firewire-digi00x: add MIDI functionality
  ALSA: firewire-digi00x: add hwdep interface
  ALSA: firewire-digi00x: add support for asynchronous messaging
  ALSA: firewire-digi00x: add support for MIDI ports for machine control
  ALSA: firewire-tascam: add skeleton for TASCAM FireWire series
  ALSA: firewire-tascam: add a structure for model-dependent parameters.
  ALSA: firewire-tascam: add proc node to show firmware information
  ALSA: firewire-tascam: add specific protocol layer
  ALSA: firewire-tascam: add streaming functionality
  ALSA: firewire-tascam: add PCM functionality
  ALSA: firewire-tascam: add transaction functionality
  ALSA: firewire-tascam: add MIDI functionality
  ALSA: firewire-tascam: add hwdep interface
  ALSA: firewire-tascam: add MMAP support to show status and control
    message
  ALSA: firewire-lib: add support for source packet header field in CIP
    header
  ALSA: firewire-lib: enable protocol layer to handle current cycle
    count
  ALSA: firewire-motu: add skeleton for Mark of the unicorn (MOTU)
    FireWire series
  ALSA: firewire-motu: add a structure for model-dependent parameters.
  ALSA: firewire-motu: add MOTU specific protocol layer
  ALSA: firewire-motu: add stream functionality
  ALSA: firewire-motu: add transaction functionality
  ALSA: firewire-motu: add proc node to show the status of internal
    clock
  ALSA: firewire-motu: add PCM functionality
  ALSA: firewire-motu: add MIDI functionality
  ALSA: firewire-motu: add hwdep interface

 include/uapi/sound/asound.h                  |    5 +-
 include/uapi/sound/firewire.h                |   16 +-
 sound/firewire/Kconfig                       |   38 +
 sound/firewire/Makefile                      |    5 +-
 sound/firewire/amdtp-am824.c                 |  432 ++++++++++
 sound/firewire/amdtp-am824.h                 |   45 ++
 sound/firewire/amdtp-stream.c                |  882 ++++++++++++++++++++
 sound/firewire/amdtp-stream.h                |  253 ++++++
 sound/firewire/amdtp.c                       | 1107 --------------------------
 sound/firewire/amdtp.h                       |  296 -------
 sound/firewire/bebob/bebob.h                 |    2 +-
 sound/firewire/bebob/bebob_midi.c            |   16 +-
 sound/firewire/bebob/bebob_pcm.c             |   10 +-
 sound/firewire/bebob/bebob_stream.c          |   34 +-
 sound/firewire/dice/dice-midi.c              |   16 +-
 sound/firewire/dice/dice-pcm.c               |   10 +-
 sound/firewire/dice/dice-stream.c            |   41 +-
 sound/firewire/dice/dice.h                   |    2 +-
 sound/firewire/digi00x/Makefile              |    4 +
 sound/firewire/digi00x/amdtp-dot.c           |  425 ++++++++++
 sound/firewire/digi00x/digi00x-hwdep.c       |  200 +++++
 sound/firewire/digi00x/digi00x-midi.c        |  198 +++++
 sound/firewire/digi00x/digi00x-pcm.c         |  355 +++++++++
 sound/firewire/digi00x/digi00x-proc.c        |   99 +++
 sound/firewire/digi00x/digi00x-stream.c      |  422 ++++++++++
 sound/firewire/digi00x/digi00x-transaction.c |  137 ++++
 sound/firewire/digi00x/digi00x.c             |  174 ++++
 sound/firewire/digi00x/digi00x.h             |  155 ++++
 sound/firewire/fcp.c                         |    2 +-
 sound/firewire/fireworks/fireworks.c         |   12 +-
 sound/firewire/fireworks/fireworks.h         |    2 +-
 sound/firewire/fireworks/fireworks_midi.c    |   16 +-
 sound/firewire/fireworks/fireworks_pcm.c     |    8 +-
 sound/firewire/fireworks/fireworks_stream.c  |    8 +-
 sound/firewire/lib.c                         |  127 +++
 sound/firewire/lib.h                         |   52 ++
 sound/firewire/motu/Makefile                 |    3 +
 sound/firewire/motu/amdtp-motu.c             |  442 ++++++++++
 sound/firewire/motu/motu-hwdep.c             |  210 +++++
 sound/firewire/motu/motu-midi.c              |  151 ++++
 sound/firewire/motu/motu-pcm.c               |  397 +++++++++
 sound/firewire/motu/motu-proc.c              |   73 ++
 sound/firewire/motu/motu-stream.c            |  670 ++++++++++++++++
 sound/firewire/motu/motu-transaction.c       |   97 +++
 sound/firewire/motu/motu.c                   |  311 ++++++++
 sound/firewire/motu/motu.h                   |  127 +++
 sound/firewire/oxfw/oxfw-midi.c              |   16 +-
 sound/firewire/oxfw/oxfw-pcm.c               |    8 +-
 sound/firewire/oxfw/oxfw-stream.c            |   11 +-
 sound/firewire/oxfw/oxfw.h                   |    2 +-
 sound/firewire/tascam/Makefile               |    4 +
 sound/firewire/tascam/amdtp-tascam.c         |  236 ++++++
 sound/firewire/tascam/tascam-hwdep.c         |  232 ++++++
 sound/firewire/tascam/tascam-midi.c          |  158 ++++
 sound/firewire/tascam/tascam-pcm.c           |  306 +++++++
 sound/firewire/tascam/tascam-proc.c          |   88 ++
 sound/firewire/tascam/tascam-stream.c        |  512 ++++++++++++
 sound/firewire/tascam/tascam-transaction.c   |  234 ++++++
 sound/firewire/tascam/tascam.c               |  232 ++++++
 sound/firewire/tascam/tascam.h               |  141 ++++
 60 files changed, 8760 insertions(+), 1507 deletions(-)
 create mode 100644 sound/firewire/amdtp-am824.c
 create mode 100644 sound/firewire/amdtp-am824.h
 create mode 100644 sound/firewire/amdtp-stream.c
 create mode 100644 sound/firewire/amdtp-stream.h
 delete mode 100644 sound/firewire/amdtp.c
 delete mode 100644 sound/firewire/amdtp.h
 create mode 100644 sound/firewire/digi00x/Makefile
 create mode 100644 sound/firewire/digi00x/amdtp-dot.c
 create mode 100644 sound/firewire/digi00x/digi00x-hwdep.c
 create mode 100644 sound/firewire/digi00x/digi00x-midi.c
 create mode 100644 sound/firewire/digi00x/digi00x-pcm.c
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c
 create mode 100644 sound/firewire/digi00x/digi00x-stream.c
 create mode 100644 sound/firewire/digi00x/digi00x-transaction.c
 create mode 100644 sound/firewire/digi00x/digi00x.c
 create mode 100644 sound/firewire/digi00x/digi00x.h
 create mode 100644 sound/firewire/motu/Makefile
 create mode 100644 sound/firewire/motu/amdtp-motu.c
 create mode 100644 sound/firewire/motu/motu-hwdep.c
 create mode 100644 sound/firewire/motu/motu-midi.c
 create mode 100644 sound/firewire/motu/motu-pcm.c
 create mode 100644 sound/firewire/motu/motu-proc.c
 create mode 100644 sound/firewire/motu/motu-stream.c
 create mode 100644 sound/firewire/motu/motu-transaction.c
 create mode 100644 sound/firewire/motu/motu.c
 create mode 100644 sound/firewire/motu/motu.h
 create mode 100644 sound/firewire/tascam/Makefile
 create mode 100644 sound/firewire/tascam/amdtp-tascam.c
 create mode 100644 sound/firewire/tascam/tascam-hwdep.c
 create mode 100644 sound/firewire/tascam/tascam-midi.c
 create mode 100644 sound/firewire/tascam/tascam-pcm.c
 create mode 100644 sound/firewire/tascam/tascam-proc.c
 create mode 100644 sound/firewire/tascam/tascam-stream.c
 create mode 100644 sound/firewire/tascam/tascam-transaction.c
 create mode 100644 sound/firewire/tascam/tascam.c
 create mode 100644 sound/firewire/tascam/tascam.h

-- 
2.1.4
