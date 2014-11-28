From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib] hwdep: add OXFW driver support
Date: Sat, 29 Nov 2014 01:03:34 +0900
Message-ID: <1417190614-4558-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C932606BF
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 17:03:38 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Linux 3.19 newly support this driver. By hardware dependent interface,
userspace applications can get hardware information, lock/unlock kernel
streaming and receive lock status event.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h        | 3 ++-
 include/sound/asound.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hwdep.h b/include/hwdep.h
index ad8bb49..3d3c31b 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -73,8 +73,9 @@ typedef enum _snd_hwdep_iface {
 	SND_HWDEP_IFACE_FW_DICE,	/**< TC DICE FireWire device */
 	SND_HWDEP_IFACE_FW_FIREWORKS,	/**< Echo Audio Fireworks based device */
 	SND_HWDEP_IFACE_FW_BEBOB,	/**< BridgeCo BeBoB based device */
+	SND_HWDEP_IFACE_FW_OXFW,	/**< Oxford OXFW970/971 based device */
 
-	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_BEBOB  /**< last known hwdep interface */
+	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_OXFW	/**< last known hwdep interface */
 } snd_hwdep_iface_t;
 
 /** open for reading */
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 941d32f..1f23cd6 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -96,9 +96,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
+	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_OXFW
 };
 
 struct snd_hwdep_info {
-- 
2.1.0
