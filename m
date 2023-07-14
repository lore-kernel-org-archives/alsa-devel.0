Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDF6EB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jul 2023 12:28:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EF6FE0F;
	Fri, 14 Jul 2023 14:27:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EF6FE0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689337690;
	bh=npG2m1UCZxKCtzRaw5t5Am2kMO3bj0pf6Epbexb+5Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ofyYdYkve0hJQy+mN1SmLX3xlBlxPCBkXCl5980k+NEhG8vLWbDNCSpk4elyOO7Sv
	 apamfg2CXSUOA/MjuCEHAuoKr9TfxJlIYDjvTbwNt9NyPEUnEeT8gaabTYq5P4T+Ne
	 Iv3iRAh8c2xgnBWe9hIaKJuCUu6+3FdzxvZ83PKI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB69CF805E8; Fri, 14 Jul 2023 14:24:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F30C2F80563;
	Fri, 14 Jul 2023 14:24:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8662DF805B6; Fri, 14 Jul 2023 14:24:36 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C68BFF8027B
	for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2023 14:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C68BFF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TvvTzmFv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337448; x=1720873448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=npG2m1UCZxKCtzRaw5t5Am2kMO3bj0pf6Epbexb+5Ig=;
  b=TvvTzmFvi79RmKQWZV3av2eRWL1U26OwAgemkY4/wngHVXjpB9OQTmaO
   zPMcC/oZLxOwPWBJl93AIq1Sg5h2mHWLi+a5cTVFE8IAAJYVzO4KcMDWy
   kVofi/ZX/1uODft3BlAy5R/9/6uW56orxe6yA14Ugb4NRypLhjA89oV0G
   1UGkUqq1G+Im1CWkBdI9KQ7CkjKYUQt6hawp5JsAgrVxS1D8efhvHuZe8
   bk4yvyTAIDDNMauyxg4kNITFtJaZES3JhrR8ANufaTjUDZEq1lgVIRyNj
   zZFzm+ss9lPdFk7BYREvDKovY9vWtQ5Q0Q8yaFZhiDDwOZ/c4WCEtdUDw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225830"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="429225830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2023 05:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053034885"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="1053034885"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:23:54 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 05/15] ALSA: hda: Add controller matching macros
Date: Fri, 14 Jul 2023 22:24:47 +0200
Message-Id: <20230714202457.423866-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7PNHVNVDLJDHKJK4SWPOVON4WC272WY4
X-Message-ID-Hash: 7PNHVNVDLJDHKJK4SWPOVON4WC272WY4
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7PNHVNVDLJDHKJK4SWPOVON4WC272WY4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some HDA controllers require additional handling, so there are macros to
match them, however those are spread across multiple files. Add them all
in one place, so they can be reused.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hdaudio.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 2ffdf58bd6d4..32c59053b48e 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/timecounter.h>
 #include <sound/core.h>
@@ -704,4 +705,29 @@ static inline unsigned int snd_array_index(struct snd_array *array, void *ptr)
 	for ((idx) = 0, (ptr) = (array)->list; (idx) < (array)->used; \
 	     (ptr) = snd_array_elem(array, ++(idx)))
 
+/*
+ * Device matching
+ */
+
+#define HDA_CONTROLLER_IS_HSW(pci) (pci_match_id((struct pci_device_id []){ \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_0) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_2) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_3) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_BDW) }, \
+			{ } \
+		}, pci))
+
+#define HDA_CONTROLLER_IS_APL(pci) (pci_match_id((struct pci_device_id []){ \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_APL) }, \
+			{ } \
+		}, pci))
+
+#define HDA_CONTROLLER_IN_GPU(pci) (pci_match_id((struct pci_device_id []){ \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG1) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_0) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_1) }, \
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_2) }, \
+			{ } \
+		}, pci) || HDA_CONTROLLER_IS_HSW(pci))
+
 #endif /* __SOUND_HDAUDIO_H */
-- 
2.34.1

