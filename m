From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Drop useless WARN_ON()
Date: Fri, 22 Dec 2017 10:58:09 +0100
Message-ID: <20171222095809.8010-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DC19D2678E1
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 10:58:18 +0100 (CET)
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
Cc: Kouta Okamoto <kouta.okamoto@toshiba.co.jp>
List-Id: alsa-devel@alsa-project.org

Since the commit 97cc2ed27e5a ("ALSA: hda - Fix yet another i915
pointer leftover in error path") cleared hdac_acomp pointer, the
WARN_ON() non-NULL check in snd_hdac_i915_register_notifier() may give
a false-positive warning, as the function gets called no matter
whether the component is registered or not.  For fixing it, let's get
rid of the spurious WARN_ON().

Fixes: 97cc2ed27e5a ("ALSA: hda - Fix yet another i915 pointer leftover in error path")
Cc: <stable@vger.kernel.org>
Reported-by: Kouta Okamoto <kouta.okamoto@toshiba.co.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 038a180d3f81..cbe818eda336 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -325,7 +325,7 @@ static int hdac_component_master_match(struct device *dev, void *data)
  */
 int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops *aops)
 {
-	if (WARN_ON(!hdac_acomp))
+	if (!hdac_acomp)
 		return -ENODEV;
 
 	hdac_acomp->audio_ops = aops;
-- 
2.15.1
