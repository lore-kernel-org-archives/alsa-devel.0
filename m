From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 7/7] ALSA: hda/hdmi: Always set
	display_power_control for Intel HSW+ codecs
Date: Tue, 11 Dec 2018 14:53:41 +0100
Message-ID: <20181211135341.11383-8-tiwai@suse.de>
References: <20181211135341.11383-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A50C267BBD
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 14:53:51 +0100 (CET)
In-Reply-To: <20181211135341.11383-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We've excluded the display_power_control flag for Intel HSW and BDW
codecs as the HD-audio controllers of the corresponding platforms take
care of the display power as well.  But the recent refactoring
separates the controller and the codec power accounting, so it's fine
to call the display PM even for HSW/BDW codecs.  This is less
confusing since we can avoid this well-hidden condition.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 30fe4dbdb0ae..15290e4706e0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2616,11 +2616,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 	intel_haswell_enable_all_pins(codec, true);
 	intel_haswell_fixup_enable_dp12(codec);
 
-	/* For Haswell/Broadwell, the controller is also in the power well and
-	 * can cover the codec power request, and so need not set this flag.
-	 */
-	if (!is_haswell(codec) && !is_broadwell(codec))
-		codec->display_power_control = 1;
+	codec->display_power_control = 1;
 
 	codec->patch_ops.set_power_state = haswell_set_power_state;
 	codec->depop_delay = 0;
-- 
2.19.2
