From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC v3] [PATCH 00/52] Enhancement for support of
	firewire devices
Date: Wed, 29 Jan 2014 22:44:07 +0900
Message-ID: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 78C832617AA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 14:45:15 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This series of patch is to update patches which I've posted below.

[RFC v2][PATCH 00/38] Enhancement for support of some firewire devices 
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070424.html 

[RFC][PATCH v2 00/13] speakers: Add support for capture/playback of PCM/MIDI
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071071.html

This series may be last RFC.

Repository:
https://github.com/takaswie/sound

For backport to Linux kernel 3.11 or later:
https://github.com/takaswie/snd-firewire-improve


For maintainers:
I have 4 items.

1.expected impacts to user-land
Refer to my last message.

2. Address allocation for Fireworks drivers
Related to this suggestion:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071120.html

The alternative way is to implement:
 1.'AV/C SIGNAL FORMAT' commanids defined in 'AV/C Digital Interface Command Set General Specification Version 4.2 (Sep 2004, 1394TA)' - 'snd-firewire-lib' has these commands
 2.'AV/C DESCRIPTOR' mechanism defined in 'Enhancements to the AV/C General Specification 3.0 Version 1.1 (Oct 2000, 1394TA)'
 3.'AV/C SIGNAL SOURCE' commands defined in 'AV/C Music Subunit 1.0' - I don't have this specification.

They cost higher than actual effects. Especially, 2 is a bit complicated and need much codes.

Actually FFADO has all of them. And snd-fireworks gives hwdep interface for application to command/response.
There is currently several ways in user-land so I think it good to keep the address non-relocatable yet.

3.Support for devices with fatal quirk
M-Audio 'Firewire 1814' and 'ProjectMix I/O' has BeBoB firmware which is heavily customized. See last patch.
They have a time not to respond transaction. As long as I experienced, the time may be 300 msec per 1 sec.

As a result, snd-bebob often fail to handle them. Especially, they can ignore transactions for
resource management of connection/channel/bandwidth. This is a fatal for host system.

But there is no user-land driver for these devices and I received some requests from FFADO users to support them.

I hope to get your opinion about this support.

4.Rest of my work
I've finished almost work for them. If I receive no big problems from developers and testers, I have a plan to post merge-request.


Updates since previous patches:
snd-firewire-lib:
 - remove wrong line to regain 'stream_running' member to 'struct fwspk'
 - allow drivers to indicate timeout value
 - remove 'amdtp_stream_midi_running'
snd-bebob:
 - add reference counter for MIDI substreams
 - improve 'mutex_lock()/mutex_unlock()' for streaming
 - remove 'device' member fron 'struct snd_bebob'
 - update device entry
snd-fireworks:
 - add reference counter for MIDI substreams
 - improve 'mutex_lock()/mutex_unlock()' for streaming
 - remove 'device' member from 'struct snd_fireworks'
snd-firewire-speakers:
 - rename to snd-oxfw and obsolete
snd-oxfw:
 - add reference counter for MIDI substreams
 - improve 'mutex_lock()/mutex_unlock()' for streaming
 - fix lock mechanism of streaming by hwdep
 - fix wrong formation for Lacie FWSpeaker and Griffin Firewave
 - remove 'fw_unit_get()/fw_unit_put()' because helper function do this


Confirm to work with:
snd-fireworks:
 - Echo Audio AudioFire4
 - Echo Audio AudioFire8 (by tester)
 - Echo Audio AudioFirePre8
 - Echo Audio AudioFire12
snd-bebob:
 - Edirol FA-66 (by tester)
 - M-Audio Ozonic
 - M-Audio Firewire Solo
 - M-Audio Firewire Audiophile
 - M-Audio Firewire 410
 - M-Audio Firewire 1814 (by tester)
 - PreSonus FIREBOX
 - PreSonus FP10 (former known as FIREPOD, by tester)
 - Yamaha GO44
 - Yamaha GO46
snd-oxfw:
 - Behringer F-Control Audio 202

Takashi Sakamoto (52):
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
  bebob: Send a cue to load firmware for M-Audio Firewire series
  speakers: Rename to oxfw
  oxfw: Move to its own directory
  oxfw: Split stream functionality to a new file and add a header file
  oxfw: Split PCM functionality to a new file
  oxfw: Split control functionality to a new file
  oxfw: Change the way to name card
  oxfw: Change the way to make PCM rules/constraints
  oxfw: Add proc interface for debugging purpose
  oxfw: Change the way to start stream
  oxfw: Add some AV/C commands to get stream formation and supported
    sample rate
  oxfw: Add support for Behringer/Mackie devices
  oxfw: Add support AMDTP in-stream and PCM capture
  oxfw: Add support for capture/playback MIDI messages
  oxfw: Add hwdep interface
  bebob: Add support for M-Audio special Firewire series

 include/uapi/sound/asound.h                      |   5 +-
 include/uapi/sound/firewire.h                    |  23 +-
 sound/firewire/Kconfig                           |  76 +-
 sound/firewire/Makefile                          |   5 +-
 sound/firewire/amdtp.c                           | 905 ++++++++++++++++------
 sound/firewire/amdtp.h                           | 161 +++-
 sound/firewire/bebob/Makefile                    |   4 +
 sound/firewire/bebob/bebob.c                     | 453 +++++++++++
 sound/firewire/bebob/bebob.h                     | 262 +++++++
 sound/firewire/bebob/bebob_command.c             | 354 +++++++++
 sound/firewire/bebob/bebob_focusrite.c           | 289 +++++++
 sound/firewire/bebob/bebob_hwdep.c               | 197 +++++
 sound/firewire/bebob/bebob_maudio.c              | 922 +++++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c                | 178 +++++
 sound/firewire/bebob/bebob_pcm.c                 | 419 ++++++++++
 sound/firewire/bebob/bebob_proc.c                | 185 +++++
 sound/firewire/bebob/bebob_stream.c              | 873 +++++++++++++++++++++
 sound/firewire/bebob/bebob_terratec.c            |  68 ++
 sound/firewire/bebob/bebob_yamaha.c              |  50 ++
 sound/firewire/cmp.c                             | 217 ++++--
 sound/firewire/cmp.h                             |  14 +-
 sound/firewire/dice.c                            |  46 +-
 sound/firewire/fcp.c                             | 151 ++++
 sound/firewire/fcp.h                             |  21 +
 sound/firewire/fireworks/Makefile                |   4 +
 sound/firewire/fireworks/fireworks.c             | 330 ++++++++
 sound/firewire/fireworks/fireworks.h             | 223 ++++++
 sound/firewire/fireworks/fireworks_command.c     | 397 ++++++++++
 sound/firewire/fireworks/fireworks_hwdep.c       | 299 ++++++++
 sound/firewire/fireworks/fireworks_midi.c        | 186 +++++
 sound/firewire/fireworks/fireworks_pcm.c         | 443 +++++++++++
 sound/firewire/fireworks/fireworks_proc.c        | 206 +++++
 sound/firewire/fireworks/fireworks_stream.c      | 356 +++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 327 ++++++++
 sound/firewire/oxfw/Makefile                     |   3 +
 sound/firewire/oxfw/oxfw.c                       | 264 +++++++
 sound/firewire/oxfw/oxfw.h                       | 146 ++++
 sound/firewire/oxfw/oxfw_command.c               | 162 ++++
 sound/firewire/oxfw/oxfw_control.c               | 283 +++++++
 sound/firewire/oxfw/oxfw_hwdep.c                 | 195 +++++
 sound/firewire/oxfw/oxfw_midi.c                  | 176 +++++
 sound/firewire/oxfw/oxfw_pcm.c                   | 399 ++++++++++
 sound/firewire/oxfw/oxfw_proc.c                  |  60 ++
 sound/firewire/oxfw/oxfw_stream.c                | 582 ++++++++++++++
 sound/firewire/speakers.c                        | 830 --------------------
 45 files changed, 10576 insertions(+), 1173 deletions(-)
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
 create mode 100644 sound/firewire/oxfw/Makefile
 create mode 100644 sound/firewire/oxfw/oxfw.c
 create mode 100644 sound/firewire/oxfw/oxfw.h
 create mode 100644 sound/firewire/oxfw/oxfw_command.c
 create mode 100644 sound/firewire/oxfw/oxfw_control.c
 create mode 100644 sound/firewire/oxfw/oxfw_hwdep.c
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c
 create mode 100644 sound/firewire/oxfw/oxfw_pcm.c
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c
 create mode 100644 sound/firewire/oxfw/oxfw_stream.c
 delete mode 100644 sound/firewire/speakers.c

-- 
1.8.3.2


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
