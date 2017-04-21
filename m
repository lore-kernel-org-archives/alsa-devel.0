From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH v2 2/3] hwdep: add Line6 USB series
	support
Date: Sat, 22 Apr 2017 00:28:00 +0900
Message-ID: <20170421152801.19649-3-o-takashi@sakamocchi.jp>
References: <20170421152801.19649-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D97BF267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:28:07 +0200 (CEST)
In-Reply-To: <20170421152801.19649-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Drivers for Line6 USB series was firstly added to staging directory at
development period of v2.6.30 kernel. At v4.9 kernel development, they
were moved to sound directory. The drivers include HwDep interface, while
header in user space library has never been updated for an entry
corresponding to the drivers.

This commit adds the entry.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h        | 3 ++-
 include/sound/asound.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hwdep.h b/include/hwdep.h
index 2fe78cd..e09703c 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -76,8 +76,9 @@ typedef enum _snd_hwdep_iface {
 	SND_HWDEP_IFACE_FW_OXFW,	/**< Oxford OXFW970/971 based device */
 	SND_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SND_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
+	SND_HWDEP_IFACE_LINE6,		/* Line6 USB processors */
 
-	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_TASCAM	/**< last known hwdep interface */
+	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_LINE6,	/**< last known hwdep interface */
 } snd_hwdep_iface_t;
 
 /** open for reading */
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 609cadb..36d1681 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -106,9 +106,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
+	SNDRV_HWDEP_IFACE_LINE6,	/* Line6 USB processors */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_LINE6,
 };
 
 struct snd_hwdep_info {
-- 
2.9.3
