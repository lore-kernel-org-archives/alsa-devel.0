Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAEBEB64DC
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jul 2023 11:48:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2777FDEC;
	Mon, 17 Jul 2023 13:47:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2777FDEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689594505;
	bh=bg/Oeye7JlKu5M4sZceMFdhSsrroMtW9Z2UVA8ue+co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ukgxvAjW2keOCSr7+QcLeI/3y6oiAWuDBIs5wRqARWxY/LlPGMYONnbo39LENOh71
	 zGNe5ya4CEYKr7VHeFz1E9cbrlDjtFAZdIEGLnsEf4WNpPxYelCNCE0JMRZPx3QFAJ
	 WwXV6pFROMM0Adl3G8ZJYUktd0U3jervzsWGBln8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDC22F805B2; Mon, 17 Jul 2023 13:46:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12746F805BB;
	Mon, 17 Jul 2023 13:46:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B54E3F8056F; Mon, 17 Jul 2023 13:45:54 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D8820F804DA
	for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2023 13:45:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8820F804DA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=k6wrtch9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689594339; x=1721130339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bg/Oeye7JlKu5M4sZceMFdhSsrroMtW9Z2UVA8ue+co=;
  b=k6wrtch9xp59kAh0GiVzn/xg8+nHiKWVHcXDjQDoAGtSQSSCgkQL8nG0
   4GiL2ZPQY/sioBIJN24lg2uS5rhvxkz+GBn3uPnchx+w8/kQhcLWmhOWr
   WIZMxA1LWQ1NOr8/66yAgnLTqWCu0sEFU7q29BmyBsjhMWUCq/z9PBXwZ
   iTaRhHLlxZiKSz+vaQhKF/pP8KBY2JvnfB/zCyCvYljrhGIgjvIyokysM
   QiOCRP8yO+Ha90WjXP5X/imi5jyuL9u9EssyXXLPS6f5Z6GCPFLTsFibb
   GH0MTkGiJPbkgMPj0ozyhCysYiw7y2B70TAYLBXmhsyfIA+A3d3hEuF0O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363372820"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200";
   d="scan'208";a="363372820"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 04:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969856505"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200";
   d="scan'208";a="969856505"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:45:34 -0700
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 05/15] ALSA: hda: Add controller matching macros
Date: Mon, 17 Jul 2023 13:45:01 +0200
Message-Id: <20230717114511.484999-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XRUMIALF75LURROYKJRMYVXIFANYIKTB
X-Message-ID-Hash: XRUMIALF75LURROYKJRMYVXIFANYIKTB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XRUMIALF75LURROYKJRMYVXIFANYIKTB/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some HDA controllers require additional handling, so there are macros to
match them, however those are spread across multiple files. Add them all
in one place, so they can be reused.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
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

