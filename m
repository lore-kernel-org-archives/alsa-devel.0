From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [GIT PULL][PATCH 00/39 v2] Enhancement of support for
	Firewire devices
Date: Wed,  5 Mar 2014 19:47:48 +0900
Message-ID: <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C157226507F
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 11:48:46 +0100 (CET)
In-Reply-To: <5316963F.1000206@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This pull-request is an update for my previous pull-request:
[alsa-devel] [GIT PULL][PATCH 00/39] Enhancement of support for Firewire
devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073446.html

Updates since previous pull-request:
firewire-lib:
 - use swap() instead of local macro
 - check NULL at memory allocation for sort table
fireworks:
 - use bitmap.h for card slots
 - add 'firewire' subdirectory to card node in procfs
 - add sanity check of module parameter with clamp()
bebob:
 - use bitmap.h for card slots
 - add 'firewire' subdirectory to card node in procfs
 - simplify codes for metering
 - use swap() instead of local macro
 - change order of last two commits

----------------------------------------------------------------
The following changes since commit 31278997add61ee13b709e274934c7b0085accce:

  ALSA: hda/realtek - Add headset quirk for Dell DT (2014-03-03 10:48:55 +0100)

are available in the git repository at:

  https://github.com/takaswie/sound.git request

for you to fetch changes up to 5b354e20ec3c64fa0a8fa7fbc7355201d881a8cc:

  bebob: Send a cue to load firmware for M-Audio Firewire series (2014-03-05 12:00:32 +0900)

----------------------------------------------------------------
Takashi Sakamoto (39):
      firewire-lib: Rename functions, structure, member for AMDTP
      firewire-lib: Add macros instead of fixed value for AMDTP
      firewire-lib: Add 'direction' member to 'amdtp_stream' structure
      firewire-lib: Split some codes into functions to reuse for both streams
      firewire-lib: Add support for AMDTP in-stream and PCM capture
      firewire-lib: Add support for MIDI capture/playback
      firewire-lib: Give syt value as parameter to handle_out_packet()
      firewire-lib: Add support for duplex streams synchronization in blocking mode
      firewire-lib: Add sort function for transmitted packet
      firewire-lib: Add transfer delay to synchronized duplex streams
      firewire-lib: Add support for channel mapping
      firewire-lib: Rename macros, variables and functions for CMP
      firewire-lib: Add 'direction' member to 'cmp_connection' structure
      firewire-lib: Add handling output connection by CMP
      firewire-lib: Add a new function to check others' connection
      firewire-lib: Add some AV/C general commands
      firewire-lib: Add quirks for Fireworks
      firewire-lib: Add a fallback at RCODE_CANCELLED
      fireworks: Add skelton for Fireworks based devices
      fireworks: Add transaction and some commands
      fireworks: Add connection and stream management
      fireworks: Add proc interface for debugging purpose
      fireworks: Add MIDI interface
      fireworks: Add PCM interface
      fireworks: Add hwdep interface
      fireworks: Add command/response functionality into hwdep interface
      bebob: Add skelton for BeBoB based devices
      bebob: Add commands and connections/streams management
      bebob: Add proc interface for debugging purpose
      bebob: Add MIDI interface
      bebob: Add PCM interface
      bebob: Add hwdep interface
      bebob: Prepare for device specific operations
      bebob: Add support for Terratec PHASE, EWS series and Aureon
      bebob: Add support for Yamaha GO series
      bebob: Add support for Focusrite Saffire/SaffirePro series
      bebob: Add support for M-Audio usual Firewire series
      bebob: Add support for M-Audio special Firewire series
      bebob: Send a cue to load firmware for M-Audio Firewire series

 include/uapi/sound/asound.h                      |   4 +-
 include/uapi/sound/firewire.h                    |  22 +-
 sound/firewire/Kconfig                           |  59 ++
 sound/firewire/Makefile                          |   2 +
 sound/firewire/amdtp.c                           | 891 +++++++++++++++++------
 sound/firewire/amdtp.h                           | 175 ++++-
 sound/firewire/bebob/Makefile                    |   4 +
 sound/firewire/bebob/bebob.c                     | 450 ++++++++++++
 sound/firewire/bebob/bebob.h                     | 260 +++++++
 sound/firewire/bebob/bebob_command.c             | 354 +++++++++
 sound/firewire/bebob/bebob_focusrite.c           | 287 ++++++++
 sound/firewire/bebob/bebob_hwdep.c               | 197 +++++
 sound/firewire/bebob/bebob_maudio.c              | 828 +++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c                | 170 +++++
 sound/firewire/bebob/bebob_pcm.c                 | 451 ++++++++++++
 sound/firewire/bebob/bebob_proc.c                | 201 +++++
 sound/firewire/bebob/bebob_stream.c              | 869 ++++++++++++++++++++++
 sound/firewire/bebob/bebob_terratec.c            |  68 ++
 sound/firewire/bebob/bebob_yamaha.c              |  50 ++
 sound/firewire/cmp.c                             | 229 ++++--
 sound/firewire/cmp.h                             |  14 +-
 sound/firewire/dice.c                            |  46 +-
 sound/firewire/fcp.c                             | 160 +++-
 sound/firewire/fcp.h                             |  21 +
 sound/firewire/fireworks/Makefile                |   4 +
 sound/firewire/fireworks/fireworks.c             | 326 +++++++++
 sound/firewire/fireworks/fireworks.h             | 223 ++++++
 sound/firewire/fireworks/fireworks_command.c     | 397 ++++++++++
 sound/firewire/fireworks/fireworks_hwdep.c       | 294 ++++++++
 sound/firewire/fireworks/fireworks_midi.c        | 179 +++++
 sound/firewire/fireworks/fireworks_pcm.c         | 477 ++++++++++++
 sound/firewire/fireworks/fireworks_proc.c        | 233 ++++++
 sound/firewire/fireworks/fireworks_stream.c      | 337 +++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 327 +++++++++
 sound/firewire/lib.c                             |   6 +-
 sound/firewire/lib.h                             |   1 +
 sound/firewire/speakers.c                        |  93 +--
 37 files changed, 8307 insertions(+), 402 deletions(-)
 create mode 100644 sound/firewire/bebob/Makefile
 create mode 100644 sound/firewire/bebob/bebob.c
 create mode 100644 sound/firewire/bebob/bebob.h
 create mode 100644 sound/firewire/bebob/bebob_command.c
 create mode 100644 sound/firewire/bebob/bebob_focusrite.c
 create mode 100644 sound/firewire/bebob/bebob_hwdep.c
 create mode 100644 sound/firewire/bebob/bebob_maudio.c
 create mode 100644 sound/firewire/bebob/bebob_midi.c
 create mode 100644 sound/firewire/bebob/bebob_pcm.c
 create mode 100644 sound/firewire/bebob/bebob_proc.c
 create mode 100644 sound/firewire/bebob/bebob_stream.c
 create mode 100644 sound/firewire/bebob/bebob_terratec.c
 create mode 100644 sound/firewire/bebob/bebob_yamaha.c
 create mode 100644 sound/firewire/fireworks/Makefile
 create mode 100644 sound/firewire/fireworks/fireworks.c
 create mode 100644 sound/firewire/fireworks/fireworks.h
 create mode 100644 sound/firewire/fireworks/fireworks_command.c
 create mode 100644 sound/firewire/fireworks/fireworks_hwdep.c
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c
 create mode 100644 sound/firewire/fireworks/fireworks_pcm.c
 create mode 100644 sound/firewire/fireworks/fireworks_proc.c
 create mode 100644 sound/firewire/fireworks/fireworks_stream.c
 create mode 100644 sound/firewire/fireworks/fireworks_transaction.c
