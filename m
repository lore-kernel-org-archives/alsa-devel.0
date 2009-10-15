From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 03/11] hda - allow up to 4 HDMI devices
Date: Thu, 15 Oct 2009 15:03:51 +0800
Message-ID: <20091015070918.178920732@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id F3F7D103926
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:11 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-allow-more-devices.patch
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

The new Intel HDMI codec supports 2 independant HDMI/DisplayPort pipes.
We'll be exporting them as 2 pcm devices. So bump up the allowed number
of HDMI devices.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c	2009-10-15 10:17:00.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.c	2009-10-15 10:17:02.000000000 +0800
@@ -2889,7 +2889,7 @@ static int get_empty_pcm_device(struct h
 	static int audio_idx[HDA_PCM_NTYPES][5] = {
 		[HDA_PCM_TYPE_AUDIO] = { 0, 2, 4, 5, -1 },
 		[HDA_PCM_TYPE_SPDIF] = { 1, -1 },
-		[HDA_PCM_TYPE_HDMI]  = { 3, -1 },
+		[HDA_PCM_TYPE_HDMI]  = { 3, 7, 8, 9, -1 },
 		[HDA_PCM_TYPE_MODEM] = { 6, -1 },
 	};
 	int i;
