From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 09/11] hda - get intelhdmi max channels from
	widget caps
Date: Thu, 15 Oct 2009 15:03:57 +0800
Message-ID: <20091015070918.945008325@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 56C65103940
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:16 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-dyn-channel.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:38:50.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:38:57.000000000 +0800
@@ -650,7 +650,6 @@ static int intel_hdmi_playback_pcm_clean
 static struct hda_pcm_stream intel_hdmi_pcm_playback = {
 	.substreams = 1,
 	.channels_min = 2,
-	.channels_max = 8,
 	.ops = {
 		.prepare = intel_hdmi_playback_pcm_prepare,
 		.cleanup = intel_hdmi_playback_pcm_cleanup,
@@ -667,11 +666,17 @@ static int intel_hdmi_build_pcms(struct 
 	codec->pcm_info = info;
 
 	for (i = 0; i < codec->num_pcms; i++, info++) {
+		unsigned int chans;
+
+		chans = get_wcaps(codec, spec->cvt[i]);
+		chans = get_wcaps_channels(chans);
+
 		info->name = intel_hdmi_pcm_names[i];
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
 							intel_hdmi_pcm_playback;
 		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->cvt[i];
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = chans;
 	}
 
 	return 0;
