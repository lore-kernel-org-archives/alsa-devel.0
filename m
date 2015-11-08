From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: add an comment to Kconfig for
	TASCAM FireOne
Date: Sun,  8 Nov 2015 14:46:34 +0900
Message-ID: <1446961594-5060-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C4ED2606C2
 for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2015 06:46:44 +0100 (CET)
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

A commit to add support for this model should have added a comment
about this model to Kconfig.

Fixes: 759a2f40c9fa('ALSA: oxfw: add an entry for TASCAM FireOne')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index bee0e5f..e92a6d9 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -38,6 +38,7 @@ config SND_OXFW
 	   * Mackie(Loud) Tapco Link.Firewire
 	   * Mackie(Loud) d.2 pro/d.4 pro
 	   * Mackie(Loud) U.420/U.420d
+	   * TASCAM FireOne
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
-- 
2.5.0
