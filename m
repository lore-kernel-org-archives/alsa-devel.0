From: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] ALSA: hda - Fix suspend/resume calls
Date: Tue, 29 Jan 2019 13:25:10 -0800
Message-ID: <20190129212510.31897-1-rodrigo.vivi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F5F2674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 22:25:11 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>
List-Id: alsa-devel@alsa-project.org

Besides the compilation issue the resume function was calling
the force_suspend.

Fixes: d81f8c6b6ced ("ALSA: hda - Record the current power state before suspend/resume calls")
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 sound/pci/hda/hda_codec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 43bcc6f1ea8c..0b86aa2b649c 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2894,6 +2894,8 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec)
  */
 static void hda_call_codec_resume(struct hda_codec *codec)
 {
+	struct device *dev = hda_codec_dev(codec);
+
 	snd_hdac_enter_pm(&codec->core);
 	if (codec->core.regmap)
 		regcache_mark_dirty(codec->core.regmap);
@@ -2955,10 +2957,16 @@ static int hda_codec_pm_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
+static int hda_codec_pm_freeze(struct device *dev)
+{
+	dev->power.power_state = PMSG_FREEZE;
+	return pm_runtime_force_suspend(dev);
+}
+
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return pm_runtime_force_suspend(dev);
+	return pm_runtime_force_resume(dev);
 }
 
 static int hda_codec_pm_thaw(struct device *dev)
-- 
2.20.1
