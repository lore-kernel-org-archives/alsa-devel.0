From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix typos in snd_hdac_regmap_*()
	documents
Date: Mon, 28 Sep 2015 14:32:40 +0200
Message-ID: <1443443560-4875-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F239264F07
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 14:32:42 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 135A2ABCC
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 12:32:41 +0000 (UTC)
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

Fixes the wrong reference names to regmap amp functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/hda_regmap.h b/include/sound/hda_regmap.h
index df705908480a..2767c55a641e 100644
--- a/include/sound/hda_regmap.h
+++ b/include/sound/hda_regmap.h
@@ -67,7 +67,7 @@ int snd_hdac_regmap_update_raw(struct hdac_device *codec, unsigned int reg,
  * @reg: verb to write
  * @val: value to write
  *
- * For writing an amp value, use snd_hda_regmap_amp_update().
+ * For writing an amp value, use snd_hdac_regmap_update_amp().
  */
 static inline int
 snd_hdac_regmap_write(struct hdac_device *codec, hda_nid_t nid,
@@ -85,7 +85,7 @@ snd_hdac_regmap_write(struct hdac_device *codec, hda_nid_t nid,
  * @mask: bit mask to update
  * @val: value to update
  *
- * For updating an amp value, use snd_hda_regmap_amp_update().
+ * For updating an amp value, use snd_hdac_regmap_update_amp().
  */
 static inline int
 snd_hdac_regmap_update(struct hdac_device *codec, hda_nid_t nid,
-- 
2.5.3
