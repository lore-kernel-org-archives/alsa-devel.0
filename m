From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: firewire: fix minor bugs
Date: Tue,  3 Jan 2017 11:58:31 +0900
Message-ID: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C045F266C94
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 03:58:40 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset fixes some minor regressions and mis-programming. These bugs
has quite less influences, thus they're not worth for stable maintenance.

I'd like to apply them into kernel 4.10 or later.

Takashi Sakamoto (3):
  ALSA: fireworks: fix asymmetric API call at unit removal
  ALSA: firewire-tascam: Fix to handle error from initialization of
    stream data
  ALSA: firewire-lib: change structure member with proper type

 sound/firewire/amdtp-stream.c               | 2 +-
 sound/firewire/amdtp-stream.h               | 4 ++--
 sound/firewire/fireworks/fireworks_stream.c | 2 +-
 sound/firewire/tascam/tascam-stream.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.9.3
