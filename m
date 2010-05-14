From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/4] intelhdmi - add dependency on
	SND_DYNAMIC_MINORS
Date: Fri, 14 May 2010 16:36:12 +0800
Message-ID: <20100514084052.102528080@intel.com>
References: <20100514083611.624260274@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BCAA1038E5
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 10:41:20 +0200 (CEST)
Content-Disposition: inline; filename=alsa-hdmi-select-dynamic-minor.patch
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

This is necessary to support >=3 HDMI playback devices
starting from the CougarPoint codec.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- drm-intel.orig/sound/pci/hda/Kconfig	2010-05-13 09:29:13.000000000 +0800
+++ drm-intel/sound/pci/hda/Kconfig	2010-05-13 09:29:43.000000000 +0800
@@ -145,6 +145,7 @@ config SND_HDA_CODEC_NVHDMI
 
 config SND_HDA_CODEC_INTELHDMI
 	bool "Build INTEL HDMI HD-audio codec support"
+	select SND_DYNAMIC_MINORS
 	default y
 	help
 	  Say Y here to include INTEL HDMI HD-audio codec support in
