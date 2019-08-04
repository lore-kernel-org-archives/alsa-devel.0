From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/19] ALSA: firewire: introduce AMDTP domain
Date: Sun,  4 Aug 2019 15:21:19 +0900
Message-ID: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09BD8F800F3
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:45 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to implement AMDTP domain I addressed in my previous
patchset:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/152430.html

My work for libhinoko[1][2] allows me to sniff actual packet transmission
between devices and drivers in Windows/Mac OS for long period (e.g. 1
hour). As a result, some supported devices don't follow packet sequences
transferred by the drivers. They expect drivers to parse isoc packets
in tx stream and recover frequency of data block then transfer isoc packets
as rx stream.

(I note that no specification describes this mechanism as long as I know.
In the specification, clock recovery is one-way from transmitter to
receivers, thus recovered clock is not necessarily used for transmission
from the receiver to the transmitter.)

For the clock recovery in driver side, several isoc contexts should be
handled in one time to parse packets in incoming stream and to build
packets in outgoing stream. The AMDTP domain is designed for this purpose.

In this time, the AMDTP domain implements the functionalities to
start/stop a couple of isoc contexts for some AMDTP streams. Each
context still runs in own handler for scheduled hardware IRQs. I'll post
further work after merged.

[1] https://mailman.alsa-project.org/pipermail/alsa-devel/2019-April/147862.html
[2] https://github.com/takaswie/libhinoko

Takashi Sakamoto (19):
  ALSA: firewire-lib: add AMDTP domain structure to handle several isoc
    context in one interrupt callback
  ALSA: firewire-lib: add a kernel API to stop a couple of AMDTP streams
    in AMDTP domain
  ALSA: firewire-lib: add a kernel API to add AMDTP stream into AMDTP
    domain
  ALSA: firewire-lib: add a kernel API to start AMDTP streams in AMDTP
    domain
  ALSA: fireworks: code refactoring for initialization/destruction of
    AMDTP streams
  ALSA: fireworks: code refactoring for bus reset handler
  ALSA: firewire-digi00x: code refactoring for
    initialization/destruction of AMDTP stream
  ALSA: firewire-tascam: code refactoring for initialization/destruction
    of AMDTP stream
  ALSA: firewire-motu: code refactoring for initialization/destruction
    of AMDTP stream
  ALSA: fireface: code refactoring for initialization/destruction of
    AMDTP stream
  ALSA: bebob: support AMDTP domain
  ALSA: fireworks: support AMDTP domain
  ALSA: oxfw: support AMDTP domain
  ALSA: dice: support AMDTP domain
  ALSA: firewire-digi00x: support AMDTP domain
  ALSA: firewire-tascam: support AMDTP domain
  ALSA: firewire-motu: support AMDTP domain
  ALSA: fireface: support AMDTP domain
  ALSA: firewire-lib: localize kernel APIs to start/stop each AMDTP
    stream

 sound/firewire/amdtp-stream.c               |  94 ++++++++++-
 sound/firewire/amdtp-stream.h               |  20 ++-
 sound/firewire/bebob/bebob.h                |   2 +
 sound/firewire/bebob/bebob_stream.c         |  62 +++----
 sound/firewire/dice/dice-stream.c           |  32 +++-
 sound/firewire/dice/dice.h                  |   2 +
 sound/firewire/digi00x/digi00x-stream.c     | 106 +++++++-----
 sound/firewire/digi00x/digi00x.h            |   2 +
 sound/firewire/fireface/ff-stream.c         |  96 ++++++-----
 sound/firewire/fireface/ff.h                |   2 +
 sound/firewire/fireworks/fireworks.h        |   2 +
 sound/firewire/fireworks/fireworks_stream.c | 176 ++++++++++----------
 sound/firewire/motu/motu-stream.c           | 131 +++++++--------
 sound/firewire/motu/motu.h                  |   2 +
 sound/firewire/oxfw/oxfw-stream.c           |  72 ++++----
 sound/firewire/oxfw/oxfw.h                  |   2 +
 sound/firewire/tascam/tascam-stream.c       | 123 ++++++++------
 sound/firewire/tascam/tascam.h              |   2 +
 18 files changed, 558 insertions(+), 370 deletions(-)

-- 
2.20.1
