From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC v2][PATCH 00/38] Enhancement for support of some firewire devices
Date: Fri, 20 Dec 2013 22:13:51 +0900
Message-ID: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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

This series of patch is to update patches which I've posted below:

[RFC][PATCH 00/17] Enhancement for firewire-lib
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069163.html

[RFC][PATCH 00/13] a new driver for BridgeCo BeBoB based device
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069183.html

[PATCH v2 0/8][RFC] a driver for Fireworks based devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070043.html

In this time, I'll post all patches because now they have dependency each other.
Each driver has lines in asound.h/firewire.h.

Changes since previous RFC version of my patches:
[firewire-lib]
 - support 32bit sample for capturing (remove 16bit sample support)
 - limit the number of MIDI conformant data channel by 1
 - change the way to trigger MIDI messages
 - fix some bugs to playback/capture samples in 'dual wire' mode
 - fix wrong mappling of channels in 'dual wire' mode
 - add unit/subunit support for PLUG INFO command
 - add limit for dev_err()
  
[fireworks]
 - improve return value for hwdep interface

[bebob]
 - reconfirm supported devices
 - read root directory in config rom to get vendor name charactors
 - add a new way to detect clock source
 - remove model specific operations for PreSonus
 - split codes for M-Audio to three patches
 - remove control interface except for M-Audio special devices

Best regards,
Takashi Sakamoto

Takashi Sakamoto (38):
  firewire-lib: Rename functions, structure, member for AMDTP
  firewire-lib: Add macros instead of fixed value for AMDTP
  firewire-lib: Add 'direction' member to 'amdtp_stream' structure
  firewire-lib: Split some codes into functions to reuse for both
    streams
  firewire-lib: Add support for AMDTP in-stream and PCM capture
  firewire-lib: Add support for MIDI capture/playback
  firewire-lib: Give syt value as parameter to handle_out_packet()
  firewire-lib: Add support for duplex streams synchronization in
    blocking mode
  firewire-lib: Add sort function for transmitted packet
  firewire-lib: Add transfer delay to synchronized duplex streams
  firewire-lib: Add support for channel mapping
  firewire-lib: Rename macros, variables and functions for CMP
  firewire-lib: Add 'direction' member to 'cmp_connection' structure
  firewire-lib: Add handling output connection by CMP
  firewire-lib: Add a new function to check others' connection
  firewire-lib: Add some AV/C general commands
  firewire-lib: Add quirks for Fireworks
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
 include/uapi/sound/firewire.h                    |  20 +
 sound/firewire/Kconfig                           |  55 ++
 sound/firewire/Makefile                          |   2 +
 sound/firewire/amdtp.c                           | 917 +++++++++++++++++------
 sound/firewire/amdtp.h                           | 163 +++-
 sound/firewire/bebob/Makefile                    |   4 +
 sound/firewire/bebob/bebob.c                     | 430 +++++++++++
 sound/firewire/bebob/bebob.h                     | 268 +++++++
 sound/firewire/bebob/bebob_command.c             | 352 +++++++++
 sound/firewire/bebob/bebob_focusrite.c           | 289 +++++++
 sound/firewire/bebob/bebob_hwdep.c               | 197 +++++
 sound/firewire/bebob/bebob_maudio.c              | 852 +++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c                | 156 ++++
 sound/firewire/bebob/bebob_pcm.c                 | 430 +++++++++++
 sound/firewire/bebob/bebob_proc.c                | 185 +++++
 sound/firewire/bebob/bebob_stream.c              | 853 +++++++++++++++++++++
 sound/firewire/bebob/bebob_terratec.c            |  68 ++
 sound/firewire/bebob/bebob_yamaha.c              |  50 ++
 sound/firewire/cmp.c                             | 217 ++++--
 sound/firewire/cmp.h                             |  14 +-
 sound/firewire/dice.c                            |  46 +-
 sound/firewire/fcp.c                             | 151 ++++
 sound/firewire/fcp.h                             |  21 +
 sound/firewire/fireworks/Makefile                |   4 +
 sound/firewire/fireworks/fireworks.c             | 330 ++++++++
 sound/firewire/fireworks/fireworks.h             | 222 ++++++
 sound/firewire/fireworks/fireworks_command.c     | 397 ++++++++++
 sound/firewire/fireworks/fireworks_hwdep.c       | 299 ++++++++
 sound/firewire/fireworks/fireworks_midi.c        | 166 ++++
 sound/firewire/fireworks/fireworks_pcm.c         | 449 +++++++++++
 sound/firewire/fireworks/fireworks_proc.c        | 206 +++++
 sound/firewire/fireworks/fireworks_stream.c      | 354 +++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 327 ++++++++
 sound/firewire/speakers.c                        |  94 +--
 35 files changed, 8196 insertions(+), 396 deletions(-)
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
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
