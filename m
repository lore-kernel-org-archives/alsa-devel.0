From: mengdong.lin@intel.com
Subject: [PATCH 1/3] ALSA: hda - add new function
	snd_hda_bus_reset() for codec communitation error
Date: Mon,  8 Apr 2013 13:53:44 -0400
Message-ID: <1365443624-15577-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D203265325
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 12:46:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

A new function snd_hda_bus_reset() is defined to suspend and resume all codecs
on the hda bus. It will be called by bus reset ops azx_bus_reset() as a rescue
of codec communitation error.

snd_hda_suspend & snd_hda_resume will no longer be called by azx_bus_reset.
So snd_hda_resume will only be used in system resume and may delay resuming a
codec.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 17286b3..a05af8b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5523,6 +5523,26 @@ int snd_hda_resume(struct hda_bus *bus)
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_resume);
+
+/**
+ * snd_hda_bus_reset - reset the codecs, i.e. suspend and resume the codecs
+ * @bus: the HDA bus
+ *
+ * Returns 0 if successful.
+ */
+int snd_hda_bus_reset(struct hda_bus *bus)
+{
+	struct hda_codec *codec;
+
+	list_for_each_entry(codec, &bus->codec_list, list) {
+		cancel_delayed_work_sync(&codec->jackpoll_work);
+		if (hda_codec_is_power_on(codec))
+			hda_call_codec_suspend(codec, false);
+		hda_call_codec_resume(codec);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_bus_reset);
 #endif /* CONFIG_PM */
 
 /*
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index c93f902..6061360 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -1076,6 +1076,7 @@ void snd_hda_unlock_devices(struct hda_bus *bus);
 #ifdef CONFIG_PM
 int snd_hda_suspend(struct hda_bus *bus);
 int snd_hda_resume(struct hda_bus *bus);
+int snd_hda_bus_reset(struct hda_bus *bus);
 #endif
 
 static inline
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 735567e..6f11c7a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1659,8 +1659,7 @@ static void azx_bus_reset(struct hda_bus *bus)
 		struct azx_pcm *p;
 		list_for_each_entry(p, &chip->pcm_list, list)
 			snd_pcm_suspend_all(p->pcm);
-		snd_hda_suspend(chip->bus);
-		snd_hda_resume(chip->bus);
+		snd_hda_bus_reset(chip->bus);
 	}
 #endif
 	bus->in_reset = 0;
-- 
1.7.10.4
