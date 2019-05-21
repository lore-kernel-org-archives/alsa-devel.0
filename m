From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-lib: use IT context header
	to compute cycle count
Date: Tue, 21 May 2019 23:57:33 +0900
Message-ID: <20190521145737.11809-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35F22F89707
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 16:57:46 +0200 (CEST)
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

In Linux firewire subsystem, the series of timestamp for each packets is
passed as argument to callback of IT context. The timestamp comes from
descriptor of 1394 OHCI IT context and represents the cycle to process
queued packet.

In current implementation of ALSA IEC 61883-1/6 packet streaming engine,
the timestamp comes from calculation with the last packet to generate
the callback, thus it's not per-packet information.

For simplicity, this patchset uses the header to compute the cycle for
packet to be going to be queued. Additionally, this patchset adds some
minor refactoring.

Takashi Sakamoto (4):
  ALSA: firewire-lib: use union for directional parameters
  ALSA: firewire-lib: add helper function to cancel context inner
    callback handler
  ALSA: firewire-lib: obsolete macro for header of IT context
  ALSA: firewire-lib: use IT context header to compute cycle count for
    scheduling packet

 sound/firewire/amdtp-am824.c                |   2 +-
 sound/firewire/amdtp-stream.c               | 181 +++++++++++---------
 sound/firewire/amdtp-stream.h               |  35 ++--
 sound/firewire/digi00x/amdtp-dot.c          |   2 +-
 sound/firewire/fireworks/fireworks_stream.c |   4 +-
 sound/firewire/motu/amdtp-motu.c            |   2 +-
 sound/firewire/tascam/amdtp-tascam.c        |   2 +-
 7 files changed, 135 insertions(+), 93 deletions(-)

-- 
2.20.1
