From: mengdong.lin@intel.com
Subject: [PATCH v2 2/3] ALSA: hda - system resume may delay
	resuming a codec
Date: Tue,  9 Apr 2013 08:24:32 -0400
Message-ID: <1365510272-12325-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A1F265D57
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 07:17:30 +0200 (CEST)
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

On system resume, a codec may not be ready to resume for some external
dependency. e.g. Intel Haswell HDMI codec depends on Gfx to initialize the
display pipeline before the codec can resume.

To avoid the external dependency blocking system resume, this patch allow
system resume ops "snd_hda_resume" skip a not ready codec and mark it as
"resume delayed". So the codec resume is delayed until later codec access,
assuming the external dependency may be resolved and waiting is acceptable
at that time.

A codec that needs delaying resume shall explicitly set "support_delay_resume"
flag on initialization in its patch ops. And it's up to the codec when it's
ready and how to finish the delayed resume.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ba147d7..81e91b8 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5518,7 +5518,10 @@ int snd_hda_resume(struct hda_bus *bus)
 	struct hda_codec *codec;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
-		hda_call_codec_resume(codec);
+		if (codec->support_delay_resume)
+			codec->resume_delayed = 1;
+		else
+			hda_call_codec_resume(codec);
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 6061360..5fe7362 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -889,6 +889,8 @@ struct hda_codec {
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	unsigned int pm_down_notified:1; /* PM notified to controller */
 	unsigned int in_pm:1;		/* suspend/resume being performed */
+	unsigned int support_delay_resume:1; /* codec support delay resume */
+	unsigned int resume_delayed:1; /* resume delayed by PM */
 	int power_transition;	/* power-state in transition */
 	int power_count;	/* current (global) power refcount */
 	struct delayed_work power_work; /* delayed task for powerdown */
-- 
1.7.10.4
