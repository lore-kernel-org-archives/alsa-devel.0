From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: remove a meaningless entry from
	firewire Makefile
Date: Sun, 18 Oct 2015 13:46:48 +0900
Message-ID: <1445143608-23297-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1445143608-23297-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5BB26148F
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 06:46:53 +0200 (CEST)
In-Reply-To: <1445143608-23297-1-git-send-email-o-takashi@sakamocchi.jp>
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

A former commit moves oxfw-related codes to a sub-directory, while it
forgot to remove an entry from Makefile in parent directory.

Fixes: 1a4e39c2e5ca('ALSA: oxfw: Move to its own directory')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 6ae50f5..f5fb625 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,6 +1,5 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp-stream.o amdtp-am824.o
-snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
 
-- 
2.1.4
