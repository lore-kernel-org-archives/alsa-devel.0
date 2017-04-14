From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/8] ALSA: firewire-lib/firewire-tascam:
	localize async midi port
Date: Fri, 14 Apr 2017 16:46:24 +0900
Message-ID: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 36860266707
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:46:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, dev@andree.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is a revised version of my previous one:
[alsa-devel] [PATCH 0/8] ALSA: firewire-lib/firewire-tascam: localize async midi port
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119748.html

A bug of this feature was reported:
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119775.html

And I posted a fix:
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119782.html

The fix brought conflict to the previous patchset and this is a revised
version.

Takashi Sakamoto (8):
  ALSA: firewire-lib/firewire-tascam: localize async midi port
  ALSA: firewire-tascam: remove callback function from async midi port
  ALSA: firewire-tascam: send fixed-length transaction for async midi
    port
  ALSA: firewire-tascam: use the same address for asynchronous
    transaction for MIDI message
  ALSA: firewire-tascam: use fixed-length array for message cache to
    async midi port
  ALSA: firewire-tascam: initialize parameters at open of rawmidi
    character devices
  ALSA: firewire-tascam: move message parameters for async midi port
  ALSA: firewire-tascam: support drain callback for MIDI playback
    substream

 sound/firewire/lib.c                       | 141 ----------------------------
 sound/firewire/lib.h                       |  54 -----------
 sound/firewire/tascam/tascam-midi.c        |  13 ++-
 sound/firewire/tascam/tascam-transaction.c | 142 ++++++++++++++++++++++++-----
 sound/firewire/tascam/tascam.h             |  39 +++++++-
 5 files changed, 162 insertions(+), 227 deletions(-)

-- 
2.9.3
