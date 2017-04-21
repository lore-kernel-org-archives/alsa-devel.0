From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 2/3] hwdep: add support for MOTU
	FireWire series and RME Fireface series
Date: Sat, 22 Apr 2017 00:08:19 +0900
Message-ID: <20170421150820.18199-3-o-takashi@sakamocchi.jp>
References: <20170421150820.18199-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 40AC8267107
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:08:25 +0200 (CEST)
In-Reply-To: <20170421150820.18199-1-o-takashi@sakamocchi.jp>
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

Drivers for MOTU FireWire series and RME Fireface series are going to be
added newly to v4.12 kernel. Like the other drivers in ALSA firewire stack,
they also support HwDep interface.

This commit add entries for the drivers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h        | 4 +++-
 include/sound/asound.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hwdep.h b/include/hwdep.h
index e09703c..ac71368 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -77,8 +77,10 @@ typedef enum _snd_hwdep_iface {
 	SND_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SND_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 	SND_HWDEP_IFACE_LINE6,		/* Line6 USB processors */
+	SND_HWDEP_IFACE_FW_MOTU,	/* MOTU FireWire series */
+	SND_HWDEP_IFACE_FW_FIREFACE,	/* RME Fireface series */
 
-	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_LINE6,	/**< last known hwdep interface */
+	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_FIREFACE,	/**< last known hwdep interface */
 } snd_hwdep_iface_t;
 
 /** open for reading */
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 344a3ea..9887361 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -107,9 +107,11 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 	SNDRV_HWDEP_IFACE_LINE6,	/* Line6 USB processors */
+	SNDRV_HWDEP_IFACE_FW_MOTU,	/* MOTU FireWire series */
+	SNDRV_HWDEP_IFACE_FW_FIREFACE,	/* RME Fireface series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_LINE6,
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREFACE,
 };
 
 struct snd_hwdep_info {
-- 
2.9.3
