From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-lib: unify handlers for
	outgoing packet
Date: Fri, 24 May 2019 00:14:36 +0900
Message-ID: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 428C4F8079B
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 17:14:47 +0200 (CEST)
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

In IT context of Linux firewire subsystem, some quadlets of packet
payload can be put as a part of packet header. This enables to
use context payload for data blocks only.

This patchset uses the mechanism to unify handlers of outgoing packet
for with-CIP and without-CIP headers.

Takashi Sakamoto (4):
  ALSA: firewire-lib: split helper function to generate CIP header
  ALSA: firewire-lib: unify packet handler for IT context
  ALSA: firewire-lib: code refactoring to queueing packets
  ALSA: firewire-lib: use 8 byte packet header for IT context to
    separate CIP header from CIP payload

 sound/firewire/amdtp-stream.c | 150 ++++++++++++++++------------------
 sound/firewire/amdtp-stream.h |   3 -
 2 files changed, 69 insertions(+), 84 deletions(-)

-- 
2.20.1
