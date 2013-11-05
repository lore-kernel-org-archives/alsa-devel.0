From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: ps3: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:10:40 +0100
Message-ID: <1383671443-13707-3-git-send-email-tiwai@suse.de>
References: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 303A826519F
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E165CA67E9
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
In-Reply-To: <1383671443-13707-1-git-send-email-tiwai@suse.de>
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

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/snd_ps3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 8c7dcbe0118d..ebb76f2d90d7 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -933,8 +933,10 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	int i, ret;
 	u64 lpar_addr, lpar_size;
 
-	BUG_ON(!firmware_has_feature(FW_FEATURE_PS3_LV1));
-	BUG_ON(dev->match_id != PS3_MATCH_ID_SOUND);
+	if (WARN_ON(!firmware_has_feature(FW_FEATURE_PS3_LV1)))
+		return -ENODEV;
+	if (WARN_ON(dev->match_id != PS3_MATCH_ID_SOUND))
+		return -ENODEV;
 
 	the_card.ps3_dev = dev;
 
-- 
1.8.4.2
