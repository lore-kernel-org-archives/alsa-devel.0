From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/4] hda - allow multi-channel HDMI audio
	playback when ELD is not present
Date: Wed, 11 Feb 2009 15:22:28 +0800
Message-ID: <20090211073402.569527628@intel.com>
References: <20090211072227.760779741@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 442A310388C
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 08:56:19 +0100 (CET)
Content-Disposition: inline; filename=intel-hdmi-8channel.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The YAMAHA AV-X1800 requires audio infoframe to include speaker-channel
mapping to play >2 channel HDMI audio. In theory that mapping should be
derived from its speaker configurations contained in its ELD. However we
currently cannot get ELD in console before the KMS functionalities are ready.
This is a more or less general issue at least in the near future. As a
workaround, we propose to allow playback of mult-channel audio when ELD
is not available.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- mm.orig/sound/pci/hda/patch_intelhdmi.c
+++ mm/sound/pci/hda/patch_intelhdmi.c
@@ -419,14 +419,18 @@ static int hdmi_setup_channel_allocation
 	/*
 	 * CA defaults to 0 for basic stereo audio
 	 */
-	if (!eld->eld_ver)
-		return 0;
-	if (!eld->spk_alloc)
-		return 0;
 	if (channels <= 2)
 		return 0;
 
 	/*
+	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
+	 * in console or for audio devices. Assume the highest speakers
+	 * configuration, to _not_ prohibit multi-channel audio playback.
+	 */
+	if (!eld->spk_alloc)
+		eld->spk_alloc = 0xffff;
+
+	/*
 	 * expand ELD's speaker allocation mask
 	 *
 	 * ELD tells the speaker mask in a compact(paired) form,

-- 
