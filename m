From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-lib: bug fix and code
	cleanup for packet streaming engine
Date: Fri, 24 May 2019 18:03:38 +0900
Message-ID: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0737F80C0F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 11:03:50 +0200 (CEST)
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

This patchset is the last part of refactoring for ALSA IEC 61883-1/6
packet streaming engine. It includes two fixes and two refactoring.

Takashi Sakamoto (4):
  ALSA: firewire-lib: fix data block counter for incoming packet without
    CIP header
  ALSA: firewire-lib: fix inverted node IDs for amdtp_packet events
  ALSA: firewire-lib: refactoring to obsolete IT packet handler
  ALSA: firewire-lib: refactoring to obsolete IR packet handler

 sound/firewire/amdtp-stream-trace.h |   6 +-
 sound/firewire/amdtp-stream.c       | 138 ++++++++++++++--------------
 2 files changed, 74 insertions(+), 70 deletions(-)

-- 
2.20.1
