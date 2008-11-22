From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 1/7] hda - minor HDMI code cleanups
Date: Sat, 22 Nov 2008 09:40:51 +0800
Message-ID: <20081122014308.828656810@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 681FB1037FF
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:00 +0100 (CET)
Content-Disposition: inline; filename=alsa-hdmi-cleanups.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Some minor code cleanups.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -431,7 +431,7 @@ static int hdmi_setup_channel_allocation
 	 * expand ELD's speaker allocation mask
 	 *
 	 * ELD tells the speaker mask in a compact(paired) form,
-	 * expand ELD's notions to match the ones used by audio infoframe.
+	 * expand ELD's notions to match the ones used by Audio InfoFrame.
 	 */
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
 		if (eld->spk_alloc & (1 << i))
@@ -592,8 +592,8 @@ static struct hda_pcm_stream intel_hdmi_
 	.channels_max = 8,
 	.nid = CVT_NID, /* NID to query formats and rates and setup streams */
 	.ops = {
-		.open = intel_hdmi_playback_pcm_open,
-		.close = intel_hdmi_playback_pcm_close,
+		.open    = intel_hdmi_playback_pcm_open,
+		.close   = intel_hdmi_playback_pcm_close,
 		.prepare = intel_hdmi_playback_pcm_prepare
 	},
 };

-- 
