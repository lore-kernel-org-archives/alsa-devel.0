From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-digi00x: integration to
	support console models
Date: Sun,  2 Apr 2017 23:48:23 +0900
Message-ID: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 255ED2668C0
 for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2017 16:48:32 +0200 (CEST)
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

Disidesign Digi00x series includes two types of unit; rack and console. ALSA
Digi00x driver is originally designed to handle both types.

Recently I got console model and realized that it can't handle console type,
as a result of packet sniffing.

This patchset is to add proper support for unit of the console type, with
new information from the reverse-engineering work.

Takashi Sakamoto (4):
  ALSA: firewire-digi00x: add support for console models of Digi00x
    series
  ALSA: firewire-digi00x: handle all MIDI messages on streaming packets
  ALSA: firewire-digi00x: allow user space applications to read/write
    MIDI messages for all ports
  ALSA: firewire-digi00x: remove transaction handler for unknown purpose

 sound/firewire/digi00x/amdtp-dot.c           |  55 ++++---
 sound/firewire/digi00x/digi00x-midi.c        | 208 ++++++++++-----------------
 sound/firewire/digi00x/digi00x-transaction.c |  88 ++----------
 sound/firewire/digi00x/digi00x.c             |  13 +-
 sound/firewire/digi00x/digi00x.h             |   7 +-
 5 files changed, 145 insertions(+), 226 deletions(-)

-- 
2.9.3
