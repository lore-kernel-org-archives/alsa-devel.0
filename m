From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/15] ALSA: firewire-tascam/fireface:
	reserve/release isochronous resources in
	pcm.hw_params/hw_free callbacks
Date: Sun,  2 Jun 2019 16:12:44 +0900
Message-ID: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B28EF80C06
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:06 +0200 (CEST)
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

This patchset is a part of series of patches for all of drivers in
ALSA firewire stack to reserve/release isochronous resources in
pcm.hw_params/hw_free callbacks.

In current implementation, the resources are reserved at the same time
to start packet streaming, and released at the same time to stop packet
streaming. However, once allocated, the resources are available
independent of lifetime of packet streaming.

The isochronous resources are the resources of IEEE 1394 bus. On the
other side of view, it's a kind of resources of hardware to maintain
the bus (isochronous resource manager). For this kind of reservation and
release, hw_params and hw_free operations are suitable in ALSA PCM
interface.

Ideally, the operation to reserve/release isochronous resource should
be separated from the operation to start/stop packet streaming. However,
IEEE 1394 bus has reset event. Once reset occurs, isochronous resource
manager releases allocated resources. The resources should be
reallocated by requesters themselves. For this reason, in this patchset,
bus generation is checked before starting packet streaming. If
generation is updated, reallocation is requested to isochronous
resource manager, then packet streaming starts.

Takashi Sakamoto (15):
  ALSA: firewire-tascam: code refactoring for registration of
    isochronous channels
  ALSA: firewire-tascam: code refactoring for reservation of isochronous
    resources
  ALSA: firewire-tascam: code refactoring for release of isochronous
    resources
  ALSA: firewire-tascam: reserve/release isochronous resources in
    pcm.hw_params/hw_free callbacks
  ALSA: firewire-tascam: update isochronous resources when starting
    packet streaming after bus reset
  ALSA: firewire-tascam: minor code refactoring to finish streaming
    session
  ALSA: firewire-tascam: code refactoring for pcm.hw_params/hw_free
    callbacks
  ALSA: fireface: add protocol-specific operation to allocate
    isochronous resources
  ALSA: fireface: support allocate_resources operation in ff800 protocol
  ALSA: fireface: support allocate_resources operation in ff400 protocol
  ALSA: fireface: support allocate_resources operation in latter
    protocol
  ALSA: fireface: reserve/release isochronous resources in
    pcm.hw_params/hw_free callbacks
  ALSA: fireface: update isochronous resources when starting packet
    streaming after bus-reset
  ALSA: fireface: minor code refactoring to finish streaming session
  ALSA: fireface: code refactoring for pcm.hw_params/hw_free callbacks

 sound/firewire/fireface/ff-pcm.c             |  57 ++---
 sound/firewire/fireface/ff-protocol-former.c | 112 +++++-----
 sound/firewire/fireface/ff-protocol-latter.c | 114 +++++-----
 sound/firewire/fireface/ff-stream.c          |  85 ++++----
 sound/firewire/fireface/ff.h                 |   3 +
 sound/firewire/tascam/tascam-pcm.c           |  59 ++----
 sound/firewire/tascam/tascam-stream.c        | 209 ++++++++++---------
 sound/firewire/tascam/tascam.h               |   2 +
 8 files changed, 306 insertions(+), 335 deletions(-)

-- 
2.20.1
