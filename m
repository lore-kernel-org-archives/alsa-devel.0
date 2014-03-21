From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/44 v3] Enhancement of support for Firewire devices
Date: Fri, 21 Mar 2014 20:09:45 +0900
Message-ID: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This series is an update for my previous series:
[alsa-devel] [GIT PULL][PATCH 00/39 v2] Enhancement of support for Firewire
devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073868.html

Updates since previous pull-request:
firewire-lib:
 - remove packet sorting
 - remove adding transfer delay to out-packets
 - fix a bug of MIDI capturing for several ports
 - add detecting discontinuity of packets
 - add a support for deferred transaction
 - add some flags for device's quirk related to AMDTP packets
 - improve return value of some AV/C general commands
fireworks:
 - add a workaround for out-of-specification dbc meaning
 - add a workaround for AudioFire9 firmware
 - add a workaround for firmware version 5.5
bebob:
 - add some flags for device's quirk related to AMDTP packets
 - add a workaround for discontinuity of packets at bus reset
 - add workarounds for M-Audio spefial Firewire series

This time I intentionally add no restriction of version for Fireworks because
I confirmed that my model doesn't always transmit packets with disorder. I
expect users to retry starging streams several times till detecting no
discontinuity of packets.
[alsa-devel] [PATCH 09/39] firewire-lib: Add sort function for transmitted packet
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074157.html

I note that a workaround for M-Audio special Firewire series at [44/44] relates
to Linux Firewire subsystem. Please follow:
Generating bus-reset by kernel module in the other subsystem
http://sourceforge.net/p/linux1394/mailman/linux1394-devel/thread/5326B651.4070309%40sakamocchi.jp/

----------------------------------------------------------------

The following changes since commit 2df6742f613840a0b0a1590fb28f7af5b058a673:

  ALSA: hda - verify pin:cvt connection on preparing a stream for Intel HDMI codec (2014-03-20 07:36:17 +0100)

are available in the git repository at:

  https://github.com/takaswie/sound.git request

for you to fetch changes up to aa0564fdd013e5754b73ba89b50c722bbedbc4ac:

  firewire/bebob: Add a workaround for M-Audio special Firewire series (2014-03-21 19:35:04 +0900)

----------------------------------------------------------------
Takashi Sakamoto (44):
  firewire-lib: Add macros instead of fixed value for AMDTP
  firewire-lib: Add 'direction' member to 'amdtp_stream' structure
  firewire-lib: Split some codes into functions to reuse for both
    streams
  firewire-lib: Add support for AMDTP in-stream and PCM capture
  firewire-lib: Add support for MIDI capture/playback
  firewire-lib: Give syt value as parameter to handle_out_packet()
  firewire-lib: Add support for duplex streams synchronization in
    blocking mode
  firewire-lib: Add support for channel mapping
  firewire-lib: Restrict calling flush_context_completion() when context
    exists
  firewire-lib: Rename macros, variables and functions for CMP
  firewire-lib: Add 'direction' member to 'cmp_connection' structure
  firewire-lib: Add handling output connection by CMP
  firewire-lib: Add a new function to check others' connection
  firewire-lib: Add support for deferred transaction
  firewire-lib: Add some AV/C general commands
  fireworks: Add skelton for Fireworks based devices
  fireworks: Add transaction and some commands
  fireworks: Add connection and stream management
  fireworks/firewire-lib: Add a quirk for empty packet with TAG0
  fireworks/firewire-lib: Add a quirk for the meaning of dbc
  fireworks/firewire-lib: Add a quirk for wrong dbs in tx packets
  fireworks/firewire-libs: Add a quirk for fixed interval of reported
    dbc
  fireworks: Add proc interface for debugging purpose
  fireworks: Add MIDI interface
  fireworks/firewire-lib: Add a quirk for data blocks for MIDI in
    out-stream
  fireworks: Add PCM interface
  fireworks: Add hwdep interface
  fireworks: Add command/response functionality into hwdep interface
  bebob: Add skelton for BeBoB based devices
  bebob: Add commands and connections/streams management
  bebob/firewire-lib: Add a quirk for discontinuity at bus reset
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
  bebob/firewire-lib: Add a quirk of wrong dbc in empty packet for
    M-Audio special Firewire series
  bebob: Send a cue to load firmware for M-Audio Firewire series
  firewire/bebob: Add a workaround for M-Audio special Firewire series

 drivers/firewire/core.h                          |   1 -
 include/linux/firewire.h                         |   3 +
 include/uapi/sound/asound.h                      |   4 +-
 include/uapi/sound/firewire.h                    |  22 +-
 sound/firewire/Kconfig                           |  59 ++
 sound/firewire/Makefile                          |   2 +
 sound/firewire/amdtp.c                           | 668 ++++++++++++----
 sound/firewire/amdtp.h                           | 124 ++-
 sound/firewire/bebob/Makefile                    |   4 +
 sound/firewire/bebob/bebob.c                     | 470 ++++++++++++
 sound/firewire/bebob/bebob.h                     | 257 +++++++
 sound/firewire/bebob/bebob_command.c             | 311 ++++++++
 sound/firewire/bebob/bebob_focusrite.c           | 287 +++++++
 sound/firewire/bebob/bebob_hwdep.c               | 197 +++++
 sound/firewire/bebob/bebob_maudio.c              | 832 ++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c                | 168 ++++
 sound/firewire/bebob/bebob_pcm.c                 | 451 +++++++++++
 sound/firewire/bebob/bebob_proc.c                | 201 +++++
 sound/firewire/bebob/bebob_stream.c              | 929 +++++++++++++++++++++++
 sound/firewire/bebob/bebob_terratec.c            |  75 ++
 sound/firewire/bebob/bebob_yamaha.c              |  54 ++
 sound/firewire/cmp.c                             | 203 +++--
 sound/firewire/cmp.h                             |  14 +-
 sound/firewire/dice.c                            |   2 +-
 sound/firewire/fcp.c                             | 192 ++++-
 sound/firewire/fcp.h                             |  21 +
 sound/firewire/fireworks/Makefile                |   4 +
 sound/firewire/fireworks/fireworks.c             | 331 ++++++++
 sound/firewire/fireworks/fireworks.h             | 227 ++++++
 sound/firewire/fireworks/fireworks_command.c     | 397 ++++++++++
 sound/firewire/fireworks/fireworks_hwdep.c       | 294 +++++++
 sound/firewire/fireworks/fireworks_midi.c        | 179 +++++
 sound/firewire/fireworks/fireworks_pcm.c         | 477 ++++++++++++
 sound/firewire/fireworks/fireworks_proc.c        | 233 ++++++
 sound/firewire/fireworks/fireworks_stream.c      | 347 +++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 327 ++++++++
 sound/firewire/speakers.c                        |  48 +-
 37 files changed, 8157 insertions(+), 258 deletions(-)
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

-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
