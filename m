From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/10] ALSA: firewire-motu: reserve/release
	isochronous resources in pcm.hw_params/hw_free callbacks
Date: Mon, 17 Jun 2019 17:15:00 +0900
Message-ID: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73194F80764
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:18 +0200 (CEST)
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

This patchset is the last part of patches for all of drivers in ALSA
firewire stack to reserve/release isochronous resources in
pcm.hw_params/hw_free callbacks, like the other patchsets:

https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150118.html
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150863.html

In current implementation, the resources are reserved at the same time
to start packet streaming, and released at the same time to stop packet
streaming. However, once allocated, the resources are available
independent of lifetime of each of packet streaming.

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

Takashi Sakamoto (10):
  ALSA: firewire-motu: unify the count of subscriber for packet
    streaming
  ALSA: firewire-motu: unify midi callback function
  ALSA: firewire-motu: add helper function to keep isochronous resources
  ALSA: firewire-motu: code refactoring for condition to stop streaming
  ALSA: firewire-motu: rename helper functions to begin/finish streaming
    session
  ALSA: firewire-motu: minor code refactoring to stop isochronous
    context
  ALSA: firewire-motu: code refactoring to finish streaming session
  ALSA: firewire-motu: reserve/release isochronous resources in
    pcm.hw_params/hw_free callbacks
  ALSA: firewire-motu: update isochronous resources when starting packet
    streaming after bus-reset
  ALSA: firewire-motu: code refactoring for pcm.hw_params/hw_free
    callbacks

 sound/firewire/motu/motu-midi.c   |  59 ++-------
 sound/firewire/motu/motu-pcm.c    |  62 +++------
 sound/firewire/motu/motu-stream.c | 203 +++++++++++++++---------------
 sound/firewire/motu/motu.h        |   7 +-
 4 files changed, 135 insertions(+), 196 deletions(-)

-- 
2.20.1
