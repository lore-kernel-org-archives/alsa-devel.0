From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib] Sync enum snd_hwdep_iface_t with
	include/asound/asound.h
Date: Sun, 17 Aug 2014 17:39:07 +0900
Message-ID: <1408264747-26357-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B2F265011
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 10:39:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some members in this enumerated type has not updated for 9 years, although
kernel-drivers added them during this period. This commit adds them following
to a commit 87df9f3 'sync include/asound/asound.h with 3.17-rc1 kernel'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hwdep.h b/include/hwdep.h
index ab12822..6ec421c 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -68,8 +68,13 @@ typedef enum _snd_hwdep_iface {
 	SND_HWDEP_IFACE_USX2Y_PCM,	/**< Tascam US122, US224 & US428 raw USB PCM */
 	SND_HWDEP_IFACE_PCXHR,		/**< Digigram PCXHR */
 	SND_HWDEP_IFACE_SB_RC,		/**< SB Extigy/Audigy2NX remote control */
-                
-	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_SB_RC  /**< last known hwdep interface */
+	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
+	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
+	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
+	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
+	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
+
+	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_BEBOB  /**< last known hwdep interface */
 } snd_hwdep_iface_t;
 
 /** open for reading */
-- 
1.9.1
