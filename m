From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/7] ALSA: drop reuse of incoming packet
	parameter for outgoing packet parameter
Date: Mon,  9 May 2016 23:15:49 +0900
Message-ID: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id F16C3265593
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:16:01 +0200 (CEST)
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

This patchset updates my former RFC, and go for merging to Linux 4.7.

[alsa-devel] [RFC][PATCH 0/6] ALSA: firewire: drop reusing incoming packet
parameters for outgoing packet parameters
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/107290.html

The aim of this patchset is to remove a feature from firewire-lib module.
I call it as 'full duplex streaming with timestamp synchronization'.

The feature is based on our understanding of IEC 61883-6. In the specification,
a function block should reuse some parameters of incoming packets for
outgoing packets. Current ALSA firewire stack partly implement it. However,
actual audio and music units on IEEE 1394 bus don't expect corresponding drivers
to satisfy the feature.

On the other hand, the feature brings inconveniences to this module. When this
feature is enabled, a software IRQ context processes packets for both of IR/IT
contexts. This consumes more time over local CPUs than handling one context.
Furthermore, cycle count for outgoing packets becomes improper because they're
for incoming packets.

For these reasons, this patchset removes the feature from ALSA firewire stack.

Changes:
 - The last patch is newly added.

Regards

Takashi Sakamoto (7):
  ALSA: bebob: drop reuse of incoming packet parameter for outgoing
    packet parameter
  ALSA: fireworks: drop reuse of incoming packet parameter for ougoing
    packet parameter
  ALSA: firewire-tascam: drop reuse of incoming packet parameter for
    outgoing packet parameter
  ALSA: firewire-lib: handle IT/IR contexts in each software interrupt
    context
  ALSA: firewire-lib: code cleanup for incoming packet handling
  ALSA: firewire-lib: code cleanup for outgoing packet handling
  ALSA: firewire-lib: enable the same feature as CIP_SKIP_INIT_DBC_CHECK
    flag

 sound/firewire/amdtp-stream.c               |  98 +++++++++------------------
 sound/firewire/amdtp-stream.h               |  36 ++--------
 sound/firewire/bebob/bebob.h                |   1 -
 sound/firewire/bebob/bebob_stream.c         | 101 +++++++---------------------
 sound/firewire/digi00x/amdtp-dot.c          |   2 +-
 sound/firewire/fireworks/fireworks.h        |   1 -
 sound/firewire/fireworks/fireworks_stream.c |  84 +++++------------------
 sound/firewire/oxfw/oxfw-stream.c           |   3 +-
 sound/firewire/tascam/tascam-stream.c       |  26 ++++---
 9 files changed, 94 insertions(+), 258 deletions(-)

-- 
2.7.4
