From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: firewire-lib/firewire-tascam:
	localize async midi port
Date: Thu, 13 Apr 2017 14:15:19 +0900
Message-ID: <20170413051527.21396-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6DF1F266A76
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 07:15:32 +0200 (CEST)
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

At a development period for Linux v4.4, firewire-lib module got an
abstraction of asynchronous transaction for transmission of MIDI message.
I did this with an assumption that this is required for Digi00x series, as
well as TASCAM FireWire series. However, my recent work reveal it's
actually not[0].

This patchset localizes the abstraction just for TASCAM FireWire series.

[0] [alsa-devel] [PATCH 0/4] ALSA: firewire-digi00x: integration to support console models
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119397.html

Takashi Sakamoto (8):
  firewire-lib/firewire-tascam: localize async midi port
  firewire-tascam: remove callback function from async midi port
  firewire-tascam: send fixed-length transaction for async midi port
  firewire-tascam: use the same address for asynchronous transaction for
    MIDI message
  firewire-tascam: use fixed-length array for message cache to async
    midi port
  firewire-tascam: initialize parameters at open of rawmidi character
    devices
  firewire-tascam: move message parameters for async midi port
  firewire-tascam: support drain callback for MIDI playback substream

 sound/firewire/lib.c                       | 141 ----------------------------
 sound/firewire/lib.h                       |  54 -----------
 sound/firewire/tascam/tascam-midi.c        |  13 ++-
 sound/firewire/tascam/tascam-transaction.c | 142 ++++++++++++++++++++++++-----
 sound/firewire/tascam/tascam.h             |  39 +++++++-
 5 files changed, 162 insertions(+), 227 deletions(-)

-- 
2.9.3
