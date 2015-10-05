From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib] hwdep: add FireWire digi00x/tascam
	driver support
Date: Tue,  6 Oct 2015 01:08:59 +0900
Message-ID: <1444061339-27519-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A21B2606E5
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 18:09:03 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Linux 4.4 newly support these drivers. Their hardware dependent interfaces
give functionalities to get hardware information, to lock/unlock kernel
streaming and to receive lock status event.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h        | 4 +++-
 include/sound/asound.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hwdep.h b/include/hwdep.h
index 3d3c31b..2fe78cd 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -74,8 +74,10 @@ typedef enum _snd_hwdep_iface {
 	SND_HWDEP_IFACE_FW_FIREWORKS,	/**< Echo Audio Fireworks based device */
 	SND_HWDEP_IFACE_FW_BEBOB,	/**< BridgeCo BeBoB based device */
 	SND_HWDEP_IFACE_FW_OXFW,	/**< Oxford OXFW970/971 based device */
+	SND_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
+	SND_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 
-	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_OXFW	/**< last known hwdep interface */
+	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_TASCAM	/**< last known hwdep interface */
 } snd_hwdep_iface_t;
 
 /** open for reading */
diff --git a/include/sound/asound.h b/include/sound/asound.h
index a45be6b..a82108e 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -100,9 +100,11 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
+	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
+	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_OXFW
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
 };
 
 struct snd_hwdep_info {
-- 
2.1.4
