From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 v4] ALSA: add helper functions for MIDI
	message transmission on IEEE 1394 asynchronous transaction
Date: Fri,  9 Oct 2015 08:10:24 +0900
Message-ID: <1444345829-17408-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 656AA265071
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 01:10:34 +0200 (CEST)
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

This patchset updates a part of my previous post:

[alsa-devel] [PATCH 0/5] ALSA: add helper functions for MIDI message transmission on IEEE 1394 asynchronous transaction
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098536.html

(Besides, the patchset should have been version 3, thus this patchset is v4.)

This patchset adds some helper functions for MIDI transmission via IEEE 1394
asynchronous transaction.

Changes:
 * fix compile error due to missing member of structure.
 * improve comments

Takashi Sakamoto (5):
  ALSA: firewire-lib: add helper functions for asynchronous transactions
    to transfer MIDI messages
  ALSA: firewire-lib: add a restriction for a transaction at once
  ALSA: firewire-lib: schedule work again when MIDI substream has rest
    of MIDI messages
  ALSA: firewire-lib: add throttle for MIDI data rate
  ALSA: firewire-lib: avoid endless loop to transfer MIDI messages at
    fatal error

 sound/firewire/lib.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/lib.h |  56 +++++++++++++++++++++
 2 files changed, 194 insertions(+)

-- 
2.1.4
