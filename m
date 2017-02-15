From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: x86: Fix memory leak in
	had_build_channel_allocation_map()
Date: Wed, 15 Feb 2017 22:29:31 +0100
Message-ID: <20170215212936.697-4-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC55D266E50
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:42 +0100 (CET)
In-Reply-To: <20170215212936.697-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The previously allocated chmap has to be released before setting the
new one.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index a7343f2d2730..5f2445389716 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -444,11 +444,12 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	u8 eld_high, eld_high_mask = 0xF0;
 	u8 high_msb;
 
+	kfree(intelhaddata->chmap->chmap);
+	intelhaddata->chmap->chmap = NULL;
+
 	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
-	if (!chmap) {
-		intelhaddata->chmap->chmap = NULL;
+	if (!chmap)
 		return;
-	}
 
 	dev_dbg(intelhaddata->dev, "eld speaker = %x\n",
 		intelhaddata->eld[DRM_ELD_SPEAKER]);
@@ -493,10 +494,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 			break;
 		}
 	}
-	if (i >= ARRAY_SIZE(channel_allocations)) {
-		intelhaddata->chmap->chmap = NULL;
+	if (i >= ARRAY_SIZE(channel_allocations))
 		kfree(chmap);
-	}
 }
 
 /*
-- 
2.11.1
