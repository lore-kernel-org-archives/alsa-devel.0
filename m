From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: usb-audio: Drop superfluous ifndef
Date: Thu, 24 May 2018 11:25:45 +0200
Message-ID: <20180524092546.16910-3-tiwai@suse.de>
References: <20180524092546.16910-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CD974267623
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 11:25:56 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 31B65AE92
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 09:25:56 +0000 (UTC)
In-Reply-To: <20180524092546.16910-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Drop the superfluous #ifndef checks that had been put just for
allowing building the alsa-driver kernel modules externally.
Since the external build was discontinued years ago, let's clean up
the old kludges.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/helper.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index 4463e6d6dcb3..d338bd0e0ca6 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -18,16 +18,12 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
  * retrieve usb_interface descriptor from the host interface
  * (conditional for compatibility with the older API)
  */
-#ifndef get_iface_desc
 #define get_iface_desc(iface)	(&(iface)->desc)
 #define get_endpoint(alt,ep)	(&(alt)->endpoint[ep].desc)
 #define get_ep_desc(ep)		(&(ep)->desc)
 #define get_cfg_desc(cfg)	(&(cfg)->desc)
-#endif
 
-#ifndef snd_usb_get_speed
 #define snd_usb_get_speed(dev) ((dev)->speed)
-#endif
 
 static inline int snd_usb_ctrl_intf(struct snd_usb_audio *chip)
 {
-- 
2.16.3
