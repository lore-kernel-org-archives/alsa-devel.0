From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-tascam: add Kconfig entry
	for TASCAM FW-1804
Date: Sun, 27 Mar 2016 16:09:09 +0900
Message-ID: <1459062549-18721-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C3B260591
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 09:09:14 +0200 (CEST)
In-Reply-To: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
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

I forgot it.

Fixes: 3e78e1518e12('ALSA: firewire-tascam: add support for FW-1804')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 2a779c2..ab894ed 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -134,6 +134,7 @@ config SND_FIREWIRE_TASCAM
 	 Say Y here to include support for TASCAM.
 	  * FW-1884
 	  * FW-1082
+	  * FW-1804
 
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-tascam.
-- 
2.7.3
