From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] ALSA: firewire-lib: split allocation of
	isochronous resources from establishment of connection
Date: Sat, 15 Jun 2019 18:10:55 +0900
Message-ID: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F8A9F896F1
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:12 +0200 (CEST)
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

In IEC 61883-1/6, CMP is depicted with operations of isochronous
resources. The ALSA firewire-lib module implements some kernel API
for CMP according to it. However, once the isochronous resources
are allocated, several packet streaming can run consecutively.
Deallocation of isochronous resources for each of packet streaming
is not needless.

In this patchset, allocation of isochronous resources is split from
establishment of connection so that CMP runs with allocated isochronous
resources.

Takashi Sakamoto (6):
  ALSA: bebob: code rafactoring for callback functions to PCM interface
  ALSA: bebob: code refactoring for callback function to rawmidi
    interface
  ALSA: bebob: change the range of critical section for stream data in
    PCM.hw_free callback
  ALSA: bebob: code refactoring for error path to start duplex stream
  ALSA: fireworks: change the range of critical section for stream data
    in PCM.hw_free callback
  ALSA: firewire-lib: split allocation of isochronous resources from
    establishment of connection

 sound/firewire/bebob/bebob_midi.c           | 47 ++-----------
 sound/firewire/bebob/bebob_pcm.c            | 62 +++--------------
 sound/firewire/bebob/bebob_stream.c         | 32 ++++++---
 sound/firewire/cmp.c                        | 74 ++++++++++++---------
 sound/firewire/cmp.h                        |  7 +-
 sound/firewire/fireworks/fireworks_pcm.c    |  9 +--
 sound/firewire/fireworks/fireworks_stream.c | 22 ++++--
 sound/firewire/oxfw/oxfw-stream.c           | 18 +++--
 8 files changed, 122 insertions(+), 149 deletions(-)

-- 
2.20.1
