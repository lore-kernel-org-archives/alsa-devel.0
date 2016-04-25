From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/6] ALSA: firewire: drop reusing incoming
	packet parameters for outgoing packet parameters
Date: Mon, 25 Apr 2016 21:45:57 +0900
Message-ID: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFF5265086
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 14:46:06 +0200 (CEST)
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

The purpose of this patchset is to remove a feature of firewire-lib module.
I call it as 'full duplex streaming with timestamp synchronization'.

This patchset should accumulated into my previous RFC patchset below:
[alsa-devel] [RFC][PATCH 0/3 v2] firewire-lib: support Linux tracing framework
to dump a part of packet data
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/106950.html

The feature is based on a specification of IEC 61883-6. In the specification,
an audio function block should reuse some parameters of incoming packets for
outgoing packets. Current ALSA firewire stack partly implement it. However,
actual audio and music units on IEEE 1394 bus don't expect drivers to perform
the specification.

Additionally to the fact, the feature brings inconveniences to handle payloads
of isochronous packet in software interrupts.

For these reasons, this patchset removes the feature from ALSA firewire stack.
This decision may be a help for future improvement about dynamic interrupt
interval of isochronous context, about which Clemens have mentioned[1].


[1][alsa-devel] For firewire drivers, reduce period time down to 2msec?
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075696.html

Regards

Takashi Sakamoto (6):
  ALSA: bebob: drop reusing incoming packet parameter for outgoing
    packet parameter
  ALSA: fireworks: drop reusing incoming packet parameter for ougoing
    packet parameter
  ALSA: firewire-tascam: drop reusing incoming packet parameter for
    outgoing packet parameter
  ALSA: firewire-lib: handle IT/IR contexts in each software context
  ALSA: firewire-lib: code cleanup for incoming packet handling
  ALSA: firewire-lib: code cleanup for outgoing packet handling

 sound/firewire/amdtp-stream.c               | 84 ++++++++----------------
 sound/firewire/amdtp-stream.h               | 35 ++--------
 sound/firewire/bebob/bebob.h                |  1 -
 sound/firewire/bebob/bebob_stream.c         | 99 ++++++++---------------------
 sound/firewire/fireworks/fireworks.h        |  1 -
 sound/firewire/fireworks/fireworks_stream.c | 84 +++++-------------------
 sound/firewire/tascam/tascam-stream.c       | 26 ++++----
 7 files changed, 87 insertions(+), 243 deletions(-)

-- 
2.7.4
