Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89247E77360
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:18:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D590B14A5;
	Sat, 30 Sep 2023 10:17:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D590B14A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061879;
	bh=u2Z5LqkjMyoVBdlcTSHSEUmyVqo7HwaJ0MCj50wy3D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G+ClOvKb9ej9CPSfR13ZxtpGYD/MaH+/qHcVvo1/RkpGiDW+L2DlTiZU62PcJ+Boz
	 gfaX1dsj1eJaLMXeP7PdzIcQ8/IFFq/oyKLQbyvevBoNtUgOhlwaWIlfQgkT60aqcG
	 QgCZ0NeYhB9oiA93w3OZYUCxs5XTZXlVldHigMNA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFBDBF805A8; Sat, 30 Sep 2023 10:12:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5617BF8065A;
	Sat, 30 Sep 2023 10:12:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 356E9F80549; Fri, 29 Sep 2023 16:51:47 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4FBD4F80290;
	Fri, 29 Sep 2023 16:51:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FBD4F80290
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH v5 05/12] ALSA: hda/i915: Allow override of gpu binding.
Date: Fri, 29 Sep 2023 16:51:19 +0200
Message-Id: <20230929145123.233838-6-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: EIVRSWMP5DUOOOPTT3JDGPAKAFGXYVC2
X-Message-ID-Hash: EIVRSWMP5DUOOOPTT3JDGPAKAFGXYVC2
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:12:28 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EIVRSWMP5DUOOOPTT3JDGPAKAFGXYVC2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
video_firmware_drivers_only(). This can be used as a first
approximation on whether i915 will be available. It's safe to use as
this is only built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.

It's not completely fool proof, as you can boot with "nomodeset
i915.modeset=1" to make i915 load regardless, or use
"i915.force_probe=!*" to never load i915, but the common case of
booting with nomodeset to disable all GPU drivers this will work as
intended.

Because of this, we add an extra module parameter,
snd_hda_core.gpu_bind that can be used to signal users intent.
-1 follows nomodeset, 0 disables binding, 1 forces wait/-EPROBE_DEFER
on binding.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/hdac_i915.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index b428537f284c7..a4a712c795c3d 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -10,6 +10,12 @@
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
 #include <sound/hda_register.h>
+#include <video/nomodeset.h>
+
+static int gpu_bind = -1;
+module_param(gpu_bind, int, 0644);
+MODULE_PARM_DESC(gpu_bind, "Whether to bind sound component to GPU "
+			   "(1=always, 0=never, -1=on nomodeset(default))");
 
 /**
  * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
@@ -122,6 +128,9 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
 {
 	struct pci_dev *display_dev = NULL;
 
+	if (!gpu_bind || (gpu_bind < 0 && video_firmware_drivers_only()))
+		return false;
+
 	for_each_pci_dev(display_dev) {
 		if (display_dev->vendor == PCI_VENDOR_ID_INTEL &&
 		    (display_dev->class >> 16) == PCI_BASE_CLASS_DISPLAY &&
-- 
2.39.2

