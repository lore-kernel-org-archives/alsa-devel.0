From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/53] ALSA: x86: Fix for CONFIG_PM=n
Date: Thu,  2 Feb 2017 18:02:41 +0100
Message-ID: <20170202170307.24484-29-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5A7267597
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
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

The direct access to power.runtime_status is taboo, let's use a helper
macro to avoid the compile error with CONFIG_PM=n.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 41105092c114..fbfbf5e2b5ad 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1453,7 +1453,7 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 	had_stream = &intelhaddata->stream_data;
 	substream = intelhaddata->stream_info.had_substream;
 
-	if (intelhaddata->dev->power.runtime_status != RPM_SUSPENDED) {
+	if (!pm_runtime_status_suspended(intelhaddata->dev)) {
 		dev_err(intelhaddata->dev, "audio stream is active\n");
 		return -EAGAIN;
 	}
-- 
2.11.0
