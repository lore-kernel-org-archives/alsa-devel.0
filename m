From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] ALSA: firewire-lib: unify handlers for
	incoming packet
Date: Wed, 22 May 2019 23:17:02 +0900
Message-ID: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50B21F80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:15 +0200 (CEST)
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

In IR context of Linux FireWire subsystem, some quadlets of packet
payload can be handled as a part of context header. As a result context
payload can just include the rest of packet payload.

This patchset uses the mechanism to unify handlers of incoming packet
for with-CIP and without-CIP headers.

Takashi Sakamoto (6):
  ALSA: firewire-lib: use clear name for variable of CIP header
  ALSA: firewire-lib: calculate the length of packet payload in packet
    handler
  ALSA: firewire-lib: compute pointer to payload buffer in context
    handler
  ALSA: firewire-lib: split helper function to check incoming CIP header
  ALSA: firewire-lib: use 16 bytes IR context header to separate CIP
    header
  ALSA: firewire-lib: unify packet handler for IR context

 sound/firewire/amdtp-stream.c | 180 ++++++++++++++++++----------------
 sound/firewire/amdtp-stream.h |   8 +-
 2 files changed, 97 insertions(+), 91 deletions(-)

-- 
2.20.1
