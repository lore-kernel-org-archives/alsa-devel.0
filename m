From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/19] ALSA: bebob/fireworks/oxfw: code
	refactoring toward rework for reservation of isochronous resources
Date: Wed, 12 Jun 2019 17:44:03 +0900
Message-ID: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40D8FF806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:30 +0200 (CEST)
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

This patchset is a part of patches to reserve/release isochronous
resources in pcm.hw_params/hw_free callbacks, like posted patchsets
below:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150118.html
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150863.html

However, in this patchset, I focus on code refactoring, due to kernel
API implementation in firewire-lib.

The target devices supported by ALSA bebob, fireworks and oxfw drivers
implements Connection Management Procedure (CMP) in IEC 61883-1. For
CMP, the drivers use kernel API in firewire-lib. This API has private
data including the data for isochronous resources, and its
implementation is tightly-coupled to maintenance of isochronous
resources.

This patchset is a preparation for future work to change the CMP
implementation.

Takashi Sakamoto (19):
  ALSA: bebob: configure sampling transfer frequency in pcm.hw_params
    callback
  ALSA: bebob: don't set XRUN in stop streaming
  ALSA: bebob: obsolete useless member of private structure
  ALSA: bebob: code refactoring to initialize/destroy stream data
  ALSA: fireworks: unify substream counter
  ALSA: fireworks: code refactoring for rawmidi.open/close
  ALSA: fireworks: code refactoring for pcm.hw_params/hw_free
  ALSA: fireworks: configure sampling transfer frequency in
    pcm.hw_params callback
  ALSA: fireworks: configure stream parameters in pcm.hw_params callback
  ALSA: fireworks: don't set XRUN in stop streaming
  ALSA: oxfw: code refactoring for stop condition of packet streaming
  ALSA: oxfw: set packet parameter according to current configuration
  ALSA: oxfw: start duplex streams if supported
  ALSA: oxfw: break packet streaming at bus-reset handler
  ALSA: oxfw: expand stop procedure for packet streaming
  ALSA: oxfw: rename helper functions for duplex streams
  ALSA: oxfw: unify substreams counter
  ALSA: oxfw: configure packet format in pcm.hw_params callback
  ALSA: oxfw: configure stream parameter in pcm.hw_params callback

 sound/firewire/bebob/bebob.h                |   5 +-
 sound/firewire/bebob/bebob_midi.c           |  22 +-
 sound/firewire/bebob/bebob_pcm.c            |  22 +-
 sound/firewire/bebob/bebob_stream.c         | 339 ++++++++++----------
 sound/firewire/fireworks/fireworks.h        |   6 +-
 sound/firewire/fireworks/fireworks_midi.c   |  54 +---
 sound/firewire/fireworks/fireworks_pcm.c    |  59 +---
 sound/firewire/fireworks/fireworks_stream.c | 159 +++++----
 sound/firewire/oxfw/oxfw-midi.c             |  22 +-
 sound/firewire/oxfw/oxfw-pcm.c              |  34 +-
 sound/firewire/oxfw/oxfw-stream.c           | 335 ++++++++++---------
 sound/firewire/oxfw/oxfw.c                  |  17 +-
 sound/firewire/oxfw/oxfw.h                  |  22 +-
 13 files changed, 553 insertions(+), 543 deletions(-)

-- 
2.20.1
