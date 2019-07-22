From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/20] ALSA: firewire-lib: use packet
	descriptor to represent sequence of packet
Date: Mon, 22 Jul 2019 12:36:50 +0900
Message-ID: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5E28F803D1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:18 +0200 (CEST)
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

This patchset is for Linux kernel v5.4.

In current implementation of ALSA IEC 61883-1/6 packet streaming
engine, one callback of isochronous context consists three steps
to process an isochronous packet:

Callback of isochronous context
 - For each of packets
  1.parse context header and decide the amount of PCM frames
  2.process data blocks (in each unit driver)
  3.queue packet

The result of step 1 affects the rest, thus the above steps can be
changed for below process:

Callback of isochronous context
 1.parse context header and decide the amount of PCM frames
  - For each of packets
 2.process data blocks (in each unit driver)
  - For each of packets
 3.queue packet
  - For each of packets

Especially it's convenient to decide the amount of PCM frames
multiplexed into each packet as batch calculation before processing
payloads of these packets.  Additionally it allows each unit driver
to process data blocks for these packet by one call.

This patchset uses list of 'struct pkt_desc' as an intermediate
representation of packet parameters between these three steps.


Here, I note my future plan for ALSA firewire stack for your motivation
to review this patchset:

 * v5.4
  * Handle several IT/IR context in one callback of IT context. This
    idea will introduce AMDTP domain structure with relationship of IRQ
    master/slave between the IT/IR contexts.
  * As a result, both of playback/capture PCM substreams run on the
    same hardware interrupt. Thus the drivers just support batch PCM
    operation and irq-based programming model[1].
 * v5.5
  * Some (p.s. not all) supported devices don't follow packet sequences
    transferred by the drivers. They require clock recovery in driver
    side to reduce playback noise.  Enhance the AMDTP domain structure
    to have clock recovery target and fill list of 'struct pkt_desc'
    according to the result of clock recovery.

My work for libhinoko[2] allows me to sniff actual packet transmission
between devices and drivers in Windows/Mac OS for long period (e.g. 1
hour). Then I can classify some cases and some devices for the
requirement of clock recovery.

(I note that no specification describes this mechanism as long as I know.
In the specification, clock recovery is one-way from transmitter to
receivers, thus recovered clock is not necessarily used for transmission
from the receiver to the transmitter.)

[1] https://git.alsa-project.org/?p=alsa-utils.git;a=blob;f=axfer/axfer-transfer.1;hb=HEAD#l675
[2] https://github.com/takaswie/libhinoko

Takashi Sakamoto (20):
  ALSA: firewire-lib: obsolete ctx_data.tx.first_dbc with
    CIP_UNALIGHED_DBC flag
  ALSA: firewire-lib: pass data block count as an argument to
    tracepoints event
  ALSA: firewire-lib: pass data block counter to data block processing
    layer
  ALSA: firewire-lib: operate data block counter in top level of
    processing for IT context
  ALSA: firewire-lib: operate data block counter in top level of
    processing for IR context
  ALSA: firewire-lib: add syt_override member for some protocols
  ALSA: firewire-lib: pass no syt information to data block processing
    layer
  ALSA: firewire-lib: add list of packet descriptor
  ALSA: firewire-lib: use packet descriptor for IT context
  ALSA: firewire-lib: use packet descriptor for IR context
  ALSA: firewire-lib: code refactoring to process PCM substream
  ALSA: firewire-lib: code refactoring to process context payloads
  ALSA: firewire-lib: pass packet descriptor to data block processing
    layer
  ALSA: firewire-lib: code refactoring for AM824 data block processing
    layer
  ALSA: firewire-digi00x: code refactoring for DOT data block processing
    layer
  ALSA: firewire-tascam: code refactoring for TASCAM data block
    processing layer
  ALSA: firewire-motu: code refactoring for MOTU data block processing
    layer
  ALSA: fireface: code refactoring for FF data block processing layer
  ALSA: firewire-lib: process payload of isoc context according to
    packet descriptors
  ALSA: firewire-motu: more code refactoring for MOTU data block
    processing layer

 sound/firewire/amdtp-am824.c                | 134 ++++++----
 sound/firewire/amdtp-stream-trace.h         |   6 +-
 sound/firewire/amdtp-stream.c               | 264 ++++++++++++--------
 sound/firewire/amdtp-stream.h               |  27 +-
 sound/firewire/digi00x/amdtp-dot.c          | 112 +++++----
 sound/firewire/fireface/amdtp-ff.c          | 105 ++++----
 sound/firewire/fireworks/fireworks_stream.c |   2 +-
 sound/firewire/motu/amdtp-motu.c            | 155 ++++++++----
 sound/firewire/tascam/amdtp-tascam.c        | 115 +++++----
 9 files changed, 570 insertions(+), 350 deletions(-)

-- 
2.20.1
