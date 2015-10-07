From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: add helper functions for MIDI
	message transmission on IEEE 1394 asynchronous transaction
Date: Wed,  7 Oct 2015 09:19:34 +0900
Message-ID: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CF31260711
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 02:19:44 +0200 (CEST)
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

This patchset updates a part of my former post (patch 03-07):

[alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html

This patchset adds some helper functions for MIDI transmission via IEEE 1394
asynchronous transaction.

Changes:
 * Use workqueue instead of tasklet for better usage of system resources.
 * Use ktime_t instead of jiffies for better resolution of time counting.
 * Some minor fixes.


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
