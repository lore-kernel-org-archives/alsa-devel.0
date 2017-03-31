From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/14] ALSA: fireface: new driver for RME
	Fireface series
Date: Fri, 31 Mar 2017 22:05:58 +0900
Message-ID: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 7E61926722C
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:21 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous RFCv3, and go for ALSA upstream.

[alsa-devel] [RFC v3][PATCH 00/13] ALSA: fireface: new driver for RME Fireface series
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-February/117811.html

This patchset newly adds a driver into ALSA firewire stack, to support for
Fireface 400 in RME FireWire series.

Unfortunately, units on this series are completely against IEC 61883-1/6.
This brings much commits and descriptions into this patchset. I'd ask you
to review much amount of codes, as well as MOTU FireWire series, to finish
my work for AMDTP variants[0].

As I noted to my former patchset, units of the series have unique feature;
resampling between packet/data block processing layer and sample
processing layer. This patchset relies on this layer, in short the driver
doesn't handle sampling clock frequency, just handle sampling transmission
frequency and expects units to generates audio from resampled data. Users
should use proper application to configure sampling clock frequency when
they want to match the frequency and sampling transmission frequency.

Changes from RFCv3:
 * Add function pointer to AMDTP structure to reduce branching on
   packet processing.
 * Improve commit description.

[0]: [alsa-devel] [RFC][PATCH 00/37] ALSA: firewire: support AMDTP variants
[alsa-devel] [RFC][PATCH 00/37] ALSA: firewire: support AMDTP variants

Takashi Sakamoto (14):
  ALSA: fireface: add skeleton for RME Fireface series
  ALSA: fireface: postpone sound card registration
  ALSA: fireface: add model specific structure
  ALSA: fireface: add an abstraction layer for model-specific protocols
  ALSA: fireface: add transaction support
  ALSA: fireface: add support for MIDI functionality
  ALSA: fireface: add proc node to help debugging
  ALSA: firewire-lib: use the same prototype for functions to handle
    packet
  ALSA: firewire-lib: add no-header packet processing
  ALSA: fireface: add unique data processing layer
  ALSA: fireface: add stream management functionality
  ALSA: fireface: add support for PCM functionality
  ALSA: fireface: add hwdep interface
  ALSA: fireface: add support for Fireface 400

 include/uapi/sound/asound.h                 |   3 +-
 include/uapi/sound/firewire.h               |   2 +-
 sound/firewire/Kconfig                      |   8 +
 sound/firewire/Makefile                     |   1 +
 sound/firewire/amdtp-stream-trace.h         |   6 +-
 sound/firewire/amdtp-stream.c               | 107 ++++++--
 sound/firewire/amdtp-stream.h               |   6 +
 sound/firewire/fireface/Makefile            |   3 +
 sound/firewire/fireface/amdtp-ff.c          | 155 +++++++++++
 sound/firewire/fireface/ff-hwdep.c          | 191 +++++++++++++
 sound/firewire/fireface/ff-midi.c           | 131 +++++++++
 sound/firewire/fireface/ff-pcm.c            | 409 ++++++++++++++++++++++++++++
 sound/firewire/fireface/ff-proc.c           |  63 +++++
 sound/firewire/fireface/ff-protocol-ff400.c | 371 +++++++++++++++++++++++++
 sound/firewire/fireface/ff-stream.c         | 282 +++++++++++++++++++
 sound/firewire/fireface/ff-transaction.c    | 295 ++++++++++++++++++++
 sound/firewire/fireface/ff.c                | 209 ++++++++++++++
 sound/firewire/fireface/ff.h                | 146 ++++++++++
 18 files changed, 2365 insertions(+), 23 deletions(-)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/amdtp-ff.c
 create mode 100644 sound/firewire/fireface/ff-hwdep.c
 create mode 100644 sound/firewire/fireface/ff-midi.c
 create mode 100644 sound/firewire/fireface/ff-pcm.c
 create mode 100644 sound/firewire/fireface/ff-proc.c
 create mode 100644 sound/firewire/fireface/ff-protocol-ff400.c
 create mode 100644 sound/firewire/fireface/ff-stream.c
 create mode 100644 sound/firewire/fireface/ff-transaction.c
 create mode 100644 sound/firewire/fireface/ff.c
 create mode 100644 sound/firewire/fireface/ff.h

-- 
2.9.3
