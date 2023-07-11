Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC4EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jul 2023 13:01:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B8FDDF2;
	Tue, 11 Jul 2023 15:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B8FDDF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689080502;
	bh=olsksZzndWsPrzCK5znSpaeExI0MYdc1YrpF7vHeiR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Oi4yiRutmCc+PVBe4RSILcJx0ic53EkfPW9Rs/Np7lkiqw/BsMcaub61TQVwlv91y
	 a1z4EY4sIByKWHeopy1EiZzxlYbyBKPgjlJ3mmOzs67zmTZ3EY2rEGRuTL14bcN2Oa
	 GGejPthXz5XMdt8JPsFQFxUsBDizQk0B0/5dJJKA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDE65F80557; Tue, 11 Jul 2023 14:59:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E14FAF800E4;
	Tue, 11 Jul 2023 14:59:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C8C2F8047D; Tue, 11 Jul 2023 14:59:03 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0466CF80093
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2023 14:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0466CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CrVKcjC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080243; x=1720616243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=olsksZzndWsPrzCK5znSpaeExI0MYdc1YrpF7vHeiR4=;
  b=CrVKcjC5eUq2OitAN0TcA/LCOytB+V3ufxmbg5mP8NtW+3hiiziT+X88
   4+Jnu3HBqKzgW22qzmXfwzTTICgjaMVtLKrnBqdESzzOZr4IFaJ1r/aKQ
   fIT6eNrXkm9X26dd+2cv7VQvlRFALMshfmJIHMziH6slqP3GzozF/d2ta
   zBB72CpPrc0Vt8YEMp/rGEhJ2An3H7e9cOGx4Ew6kS6XtJMeseXknGGgZ
   0l/KtXyE8ODSBM3vFT4tkDksuiFB09os3GDwdaTQHkSi+WLbxglZioTu/
   sq8loBpI0a+KX8WQGfbPPj5WaFAhZvdkIiMuSeTJ4bQdIKj9IjFZcQZOc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187428"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200";
   d="scan'208";a="367187428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2023 05:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666603"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200";
   d="scan'208";a="834666603"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:18 -0700
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
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 05/13] ALSA: hda/i915:  Use global PCI match macro
Date: Tue, 11 Jul 2023 14:57:18 +0200
Message-Id: <20230711125726.3509391-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SAGFRV5VO23RUM2QJWPLNLG46RBW2Z3X
X-Message-ID-Hash: SAGFRV5VO23RUM2QJWPLNLG46RBW2Z3X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SAGFRV5VO23RUM2QJWPLNLG46RBW2Z3X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Instead of using local macro to match PCI device, use global one.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/hdac_i915.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 161a9711cd63..2a451ff4fe6a 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -11,11 +11,6 @@
 #include <sound/hda_i915.h>
 #include <sound/hda_register.h>
 
-#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
-				((pci)->device == 0x0c0c) || \
-				((pci)->device == 0x0d0c) || \
-				((pci)->device == 0x160c))
-
 /**
  * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
  * @bus: HDA core bus
@@ -39,7 +34,7 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 
 	if (!acomp || !acomp->ops || !acomp->ops->get_cdclk_freq)
 		return; /* only for i915 binding */
-	if (!IS_HSW_CONTROLLER(pci))
+	if (!HDA_CONTROLLER_IS_HSW(pci))
 		return; /* only HSW/BDW */
 
 	cdclk_freq = acomp->ops->get_cdclk_freq(acomp->dev);
-- 
2.34.1

