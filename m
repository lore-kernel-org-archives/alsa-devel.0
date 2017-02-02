From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/53] ALSA: x86: Drop global ELD copy
Date: Thu,  2 Feb 2017 18:02:29 +0100
Message-ID: <20170202170307.24484-17-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B2026757D
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Similarly like the previous patch, drop the global variable to keep
the ELD copy.  It can be embedded in hdmi_lpe_audio_ctx as well.

And this makes easier to code, it's just a memcpy(), after all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 775a8b947213..53864d372861 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -36,9 +36,6 @@
 #include "intel_hdmi_lpe_audio.h"
 #include "intel_hdmi_audio.h"
 
-/* globals*/
-static union otm_hdmi_eld_t hlpe_eld;
-
 struct hdmi_lpe_audio_ctx {
 	struct platform_device *pdev;
 	int irq;
@@ -51,29 +48,9 @@ struct hdmi_lpe_audio_ctx {
 	int hdmi_audio_interrupt_mask;
 	struct work_struct hdmi_audio_wq;
 	int state; /* connection state */
+	union otm_hdmi_eld_t eld; /* ELD copy */
 };
 
-static void hdmi_set_eld(void *eld)
-{
-	int size;
-
-	BUILD_BUG_ON(sizeof(hlpe_eld) > HDMI_MAX_ELD_BYTES);
-
-	size = sizeof(hlpe_eld);
-	memcpy((void *)&hlpe_eld, eld, size);
-}
-
-static int hdmi_get_eld(void *eld)
-{
-	u8 *eld_data = (u8 *)&hlpe_eld;
-
-	memcpy(eld, (void *)&hlpe_eld, sizeof(hlpe_eld));
-
-	print_hex_dump_bytes("eld: ", DUMP_PREFIX_NONE, eld_data,
-			sizeof(hlpe_eld));
-	return 0;
-}
-
 static void mid_hdmi_audio_signal_event(struct platform_device *pdev,
 					enum had_event_type event)
 {
@@ -159,7 +136,9 @@ int mid_hdmi_audio_get_caps(struct platform_device *pdev,
 
 	switch (get_element) {
 	case HAD_GET_ELD:
-		ret = hdmi_get_eld(capabilities);
+		memcpy(capabilities, &ctx->eld, sizeof(ctx->eld));
+		print_hex_dump_bytes("eld: ", DUMP_PREFIX_NONE,
+				     (u8 *)&ctx->eld, sizeof(ctx->eld));
 		break;
 	case HAD_GET_DISPLAY_RATE:
 		/* ToDo: Verify if sampling freq logic is correct */
@@ -292,7 +271,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 			break;
 		}
 
-		hdmi_set_eld(eld->eld_data);
+		memcpy(&ctx->eld, eld->eld_data, sizeof(ctx->eld));
 
 		mid_hdmi_audio_signal_event(pdev, HAD_EVENT_HOT_PLUG);
 
-- 
2.11.0
