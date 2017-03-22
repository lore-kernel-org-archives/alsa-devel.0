From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/18] ALSA: firewire-motu: new driver for MOTU
	FireWire series
Date: Wed, 22 Mar 2017 21:30:10 +0900
Message-ID: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 445FE2673BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:39 +0100 (CET)
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

This patchset updates my previous RFCv2, and go for ALSA upstream.
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/117211.html

This patchset newly adds a driver into ALSA firewire stack, to support for
some models in MOTU FireWire series:
 - 828mk2
 - 828mk3 (FireWire only)
 - 828mk3 (Hybrid)

The driver supports playbacking/capturing PCM frames and MIDI messages for any
sampling transfer frequencies, with current ALSA IEC 61883-1/6 packet streaming
engine.

Unfortunately, units on MOTU FireWire series have many quirks against
IEC 61883-1/6. This brings much commits and descriptions on this patchset.
Sorry for reviewers but I'm glad to get your assist for this patchset.

As I note in 8th commit, at sampling transfer frequency based on 44.1kHz, the
driver handles the units with choppy noises every few seconds. This is an issue
which is not resolved yet.

Changes from RFCv2:
 - drop trial support for 828. If you have interests in development, please
   refer to one commit of my previous RFC. It describes v1 protocol.
  - http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/117226.html
 - improve commit messages.

Takashi Sakamoto (18):
  ALSA: firewire-motu: add skeleton for Mark of the unicorn (MOTU)
    FireWire series
  ALSA: firewire-motu: postpone sound card registration
  ALSA: firewire-motu: add a structure for model-dependent parameters.
  ALSA: firewire-motu: add an abstraction layer for three types of
    protocols
  ALSA: firewire-lib: record cycle count for the first packet
  ALSA: firewire-lib: add support for source packet header field in CIP
    header
  ALSA: firewire-lib: enable CIP_DBC_IS_END_EVENT for both directions of
    stream
  ALSA: firewire-motu: add MOTU specific protocol layer
  ALSA: firewire-motu: handle transactions specific for MOTU FireWire
    models
  ALSA: firewire-motu: add stream management functionality
  ALSA: firewire-motu: add proc node to show current statuc of clock and
    packet formats
  ALSA: firewire-motu: add PCM functionality
  ALSA: firewire-motu: add MIDI functionality
  ALSA: firewire-motu: add hwdep interface
  ALSA: firewire-motu: enable to read transaction cache via hwdep
    interface
  ALSA: firewire-motu: add support for MOTU 828mk2 as a model with
    protocol version 2
  ALSA: firewire-lib: add a quirk of packet without valid EOH in CIP
    format
  ALSA: firewire-motu: add support for MOTU 828mk3 (FireWire/Hybrid) as
    a model with protocol version 3

 include/uapi/sound/asound.h            |   3 +-
 include/uapi/sound/firewire.h          |  10 +-
 sound/firewire/Kconfig                 |  12 +
 sound/firewire/Makefile                |   1 +
 sound/firewire/amdtp-stream.c          |  36 ++-
 sound/firewire/amdtp-stream.h          |   9 +-
 sound/firewire/motu/Makefile           |   4 +
 sound/firewire/motu/amdtp-motu.c       | 388 ++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-hwdep.c       | 198 ++++++++++++++++
 sound/firewire/motu/motu-midi.c        | 169 ++++++++++++++
 sound/firewire/motu/motu-pcm.c         | 398 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-proc.c        | 118 ++++++++++
 sound/firewire/motu/motu-protocol-v2.c | 237 ++++++++++++++++++++
 sound/firewire/motu/motu-protocol-v3.c | 312 ++++++++++++++++++++++++++
 sound/firewire/motu/motu-stream.c      | 381 +++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-transaction.c | 137 ++++++++++++
 sound/firewire/motu/motu.c             | 264 ++++++++++++++++++++++
 sound/firewire/motu/motu.h             | 161 +++++++++++++
 18 files changed, 2827 insertions(+), 11 deletions(-)
 create mode 100644 sound/firewire/motu/Makefile
 create mode 100644 sound/firewire/motu/amdtp-motu.c
 create mode 100644 sound/firewire/motu/motu-hwdep.c
 create mode 100644 sound/firewire/motu/motu-midi.c
 create mode 100644 sound/firewire/motu/motu-pcm.c
 create mode 100644 sound/firewire/motu/motu-proc.c
 create mode 100644 sound/firewire/motu/motu-protocol-v2.c
 create mode 100644 sound/firewire/motu/motu-protocol-v3.c
 create mode 100644 sound/firewire/motu/motu-stream.c
 create mode 100644 sound/firewire/motu/motu-transaction.c
 create mode 100644 sound/firewire/motu/motu.c
 create mode 100644 sound/firewire/motu/motu.h

-- 
2.9.3
