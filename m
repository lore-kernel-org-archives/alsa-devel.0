From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2 RFC] control core refactoring
Date: Thu,  9 Apr 2015 01:55:06 +0900
Message-ID: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BB88265626
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:55:13 +0200 (CEST)
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

This patchset is for refactoring control core code.

The first patch is re-send
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087700.html

The second patch is new. As long as I investigated, the changed code
was written in 1999 and its basic design have never been changed. In
my opinion, the design is a bit complicated and refactoring it is
better to decrease maintaining cost.

Takashi Sakamoto (2):
  ALSA: ctl: evaluate macro instead of numerical value
  ALSA: ctl: refactoring for read operation

 sound/core/control.c | 87 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

-- 
2.1.0
