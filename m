From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/19][RFC v2] ALSA: firewire-motu: new driver
	for MOTU FireWire series
Date: Sun, 29 Jan 2017 12:53:58 +0900
Message-ID: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id B42472669F3
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 04:54:23 +0100 (CET)
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

This patchset updates a part of my previous RFC, just for MOTU FireWire series.

[RFC][PATCH 00/37] ALSA: firewire: support AMDTP variants
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094789.html

This patchset adds support for a part of MOTU FireWire series with their
functionality of packet streaming. Below models are newly supported:
 - 828
 - 828mk2
 - 828mk3 (FireWire/Hybrid)

However, this module cannot handle 828 correctly to generate sound. The reason
is not clear yet. On the other hand, 828mk2 and 828mk3 can be handled most
properly via ALSA PCM/MIDI/HwDep interfaces.

Currently, I have a plan to post this patchset to merge into Linux 4.12.
Corresponding merge window will be estimated to open this April. If you're
willing to test this module, please report the result till then.

For testers, I prepared for backport modules in my repository. Please follow
instructions in README.
https://github.com/takaswie/snd-firewire-improve/tree/topic/motu

As user land tools, I added some stuffs to libhinawa and hinawa-utils. Please
refer to 'topic/motu' branch of these repositories. You can use
'hinawa-motu-common-cui' to configure some streaming-related features of the
above units:
 * https://github.com/takaswie/libhinawa/tree/topic/motu
 * https://github.com/takaswie/hinawa-utils/tree/topic/motu

Takashi Sakamoto (19):
  firewire-motu: add skeleton for Mark of the unicorn (MOTU) FireWire
    series
  firewire-motu: postpone sound card registration
  firewire-motu: add a structure for model-dependent parameters.
  firewire-motu: add an abstraction layer for three types of protocols
  firewire-lib: record cycle count for the first packet
  firewire-lib: add support for source packet header field in CIP header
  firewire-lib: enable CIP_DBC_IS_END_EVENT for both directions of
    stream
  firewire-motu: add MOTU specific protocol layer
  firewire-motu: handle transactions specific for MOTU FireWire models
  firewire-motu: add stream management functionality
  firewire-motu: add proc node to show current statuc of clock and
    packet formats
  firewire-motu: add PCM functionality
  firewire-motu: add MIDI functionality
  firewire-motu: add hwdep interface
  firewire-motu: enable to read transaction cache via hwdep interface
  firewire-motu: add support for MOTU 828 as a model with protocol
    version 1
  firewire-motu: add support for MOTU 828mk2 as a model with protocol
    version 2
  firewire-lib: add a quirk of packet without valid EOH in CIP format
  firewire-motu: add support for MOTU 828mk3 (FireWire/Hybrid) as a
    model with protocol version 3

 include/uapi/sound/asound.h            |   3 +-
 include/uapi/sound/firewire.h          |  10 +-
 sound/firewire/Kconfig                 |  13 ++
 sound/firewire/Makefile                |   1 +
 sound/firewire/amdtp-stream.c          |  36 ++-
 sound/firewire/amdtp-stream.h          |   9 +-
 sound/firewire/motu/Makefile           |   5 +
 sound/firewire/motu/amdtp-motu.c       | 388 ++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-hwdep.c       | 198 ++++++++++++++++
 sound/firewire/motu/motu-midi.c        | 169 ++++++++++++++
 sound/firewire/motu/motu-pcm.c         | 398 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-proc.c        | 118 ++++++++++
 sound/firewire/motu/motu-protocol-v1.c | 204 +++++++++++++++++
 sound/firewire/motu/motu-protocol-v2.c | 237 ++++++++++++++++++++
 sound/firewire/motu/motu-protocol-v3.c | 312 ++++++++++++++++++++++++++
 sound/firewire/motu/motu-stream.c      | 381 +++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-transaction.c | 137 ++++++++++++
 sound/firewire/motu/motu.c             | 273 ++++++++++++++++++++++
 sound/firewire/motu/motu.h             | 161 +++++++++++++
 19 files changed, 3042 insertions(+), 11 deletions(-)
 create mode 100644 sound/firewire/motu/Makefile
 create mode 100644 sound/firewire/motu/amdtp-motu.c
 create mode 100644 sound/firewire/motu/motu-hwdep.c
 create mode 100644 sound/firewire/motu/motu-midi.c
 create mode 100644 sound/firewire/motu/motu-pcm.c
 create mode 100644 sound/firewire/motu/motu-proc.c
 create mode 100644 sound/firewire/motu/motu-protocol-v1.c
 create mode 100644 sound/firewire/motu/motu-protocol-v2.c
 create mode 100644 sound/firewire/motu/motu-protocol-v3.c
 create mode 100644 sound/firewire/motu/motu-stream.c
 create mode 100644 sound/firewire/motu/motu-transaction.c
 create mode 100644 sound/firewire/motu/motu.c
 create mode 100644 sound/firewire/motu/motu.h

-- 
2.9.3
