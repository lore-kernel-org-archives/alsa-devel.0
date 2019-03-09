From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - call runtime_resume after S3 and
	S4 for each codec
Date: Sat,  9 Mar 2019 23:19:47 +0800
Message-ID: <20190309151947.24663-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C6A7F80724
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2019 16:20:30 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Recently we found the audio jack detection doesn't work after suspend
on many machines with Realtek codec. Sometimes the audio selection
dialogue didn't show up after users plugged headhphone/headset into
the headset jack, sometimes after uses plugged headphone/headset, then
click the sound icon on the upper-right corner of gnome-desktop, it
also showed the speaker rather than the headphone.

The root cause is that before suspend, the codec already call the
runtime_suspend since this codec is not used by any apps, then in
resume, it will not call runtime_resume for this codec. But for some
realtek codec (so far, alc236, alc255 and alc891) with the specific
BIOS, if it doesn't run runtime_resume after suspend, all codec
functions including jack detection stop working anymore.

This problem existed for a long time, but it was not exposed, that is
because if users is playing sound or recording sound, and at the same
time they run suspend,  the runtime_suspend will be called in
pm_suspend and runtime_resume will be called in pm_resume; if audio
codec is not used by any apps and users run suspend, the
runtime_resume will not be called in pm_resume, then codec stops
working, but if users play sound or open sound-setting to check
audio device, this will trigger calling to runtime_resume (
via snd_hda_power_up), then the codec starts working again before
users notice this problem.

Since we don't know how many codec and BIOS combinations have this
problem, to fix it, let the driver call runtime_resume for all codecs
in pm_resume, maybe for some codecs, this is not needed, but it is
harmless. After a codec is runtime resumed, if it is not used by any
apps, it will be runtime suspended soon and furthermore we don't run
suspend frequently, this change will not add much power consumption.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 include/sound/hda_codec.h |  3 +++
 sound/pci/hda/hda_codec.c | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index cc7c8d42d4fd..a4e26d1d18bc 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -262,6 +262,9 @@ struct hda_codec {
 	unsigned int auto_runtime_pm:1; /* enable automatic codec runtime pm */
 	unsigned int force_pin_prefix:1; /* Add location prefix */
 	unsigned int link_down_at_suspend:1; /* link down at runtime suspend */
+#ifdef CONFIG_PM_SLEEP
+	unsigned int already_rt_suspend:1; /* already runtime suspend before sleep */
+#endif
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5f2005098a60..7c2bbe25adde 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2939,34 +2939,54 @@ static int hda_codec_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
+static int hda_codec_force_resume(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	if (codec->already_rt_suspend) {
+		int ret;
+
+		pm_runtime_get_noresume(dev);
+		ret = pm_runtime_force_resume(dev);
+		pm_runtime_put(dev);
+		return ret;
+	} else
+		return pm_runtime_force_resume(dev);
+}
 static int hda_codec_pm_suspend(struct device *dev)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
 	dev->power.power_state = PMSG_SUSPEND;
+	codec->already_rt_suspend = pm_runtime_suspended(dev);
 	return pm_runtime_force_suspend(dev);
 }
 
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
 	dev->power.power_state = PMSG_FREEZE;
+	codec->already_rt_suspend = pm_runtime_suspended(dev);
 	return pm_runtime_force_suspend(dev);
 }
 
 static int hda_codec_pm_thaw(struct device *dev)
 {
 	dev->power.power_state = PMSG_THAW;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 
 static int hda_codec_pm_restore(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESTORE;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.17.1
