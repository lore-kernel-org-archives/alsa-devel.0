From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 06/11] hda - use pcm prepare/cleanup callbacks
	for intelhdmi
Date: Thu, 15 Oct 2009 15:03:54 +0800
Message-ID: <20091015070918.563529121@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D0A410393B
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:15 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-pcm-prepare-cleanup.patch
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

Remove pcm callbacks open/close in favor of the prepare/cleanup.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:33:18.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:35:36.000000000 +0800
@@ -543,16 +543,9 @@ static void intel_hdmi_unsol_event(struc
  * Callbacks
  */
 
-static int intel_hdmi_playback_pcm_open(struct hda_pcm_stream *hinfo,
-					struct hda_codec *codec,
-					struct snd_pcm_substream *substream)
-{
-	return 0;
-}
-
-static int intel_hdmi_playback_pcm_close(struct hda_pcm_stream *hinfo,
-					 struct hda_codec *codec,
-					 struct snd_pcm_substream *substream)
+static int intel_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+					   struct hda_codec *codec,
+					   struct snd_pcm_substream *substream)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 
@@ -582,9 +575,8 @@ static struct hda_pcm_stream intel_hdmi_
 	.channels_min = 2,
 	.channels_max = 8,
 	.ops = {
-		.open    = intel_hdmi_playback_pcm_open,
-		.close   = intel_hdmi_playback_pcm_close,
-		.prepare = intel_hdmi_playback_pcm_prepare
+		.prepare = intel_hdmi_playback_pcm_prepare,
+		.cleanup = intel_hdmi_playback_pcm_cleanup,
 	},
 };
