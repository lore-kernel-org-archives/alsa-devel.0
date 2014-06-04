From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] Fix some minor issues for Fireworks/BeBoB
	drivers
Date: Wed,  4 Jun 2014 15:25:31 +0900
Message-ID: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2470D2625DB
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove some unused or meaningless functions and improve some codes and comments.

Takashi Sakamoto (6):
  fireworks/bebob: Shorten critical section for stream_stop_duplex()
  fireworks: Use safer way to arrange ring buffer pointer
  fireworks: Improve comments about Fireworks transaction
  fireworks: Remove a constant over width to which it's applied
  fireworks: Remove meaningless mutex_unlock()
  bebob: Remove unused function prototype

 sound/firewire/bebob/bebob.h                     |  2 --
 sound/firewire/bebob/bebob_stream.c              |  4 ++--
 sound/firewire/fireworks/fireworks.c             |  1 -
 sound/firewire/fireworks/fireworks.h             |  1 -
 sound/firewire/fireworks/fireworks_hwdep.c       |  2 +-
 sound/firewire/fireworks/fireworks_stream.c      |  4 ++--
 sound/firewire/fireworks/fireworks_transaction.c | 18 +++++++++---------
 7 files changed, 14 insertions(+), 18 deletions(-)

-- 
1.8.3.2
