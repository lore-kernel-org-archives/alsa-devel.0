Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D49AEB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jul 2023 12:27:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92AB1A4B;
	Fri, 14 Jul 2023 14:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92AB1A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689337662;
	bh=t3HZv5qJPf5xVVC8Dhp4RNscGO5uzAyDv01K9l4KYPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qazT+vLPTIfHfiW3z4zlVtFGn/Fm5sqHcv26n8uhfAkInaOMjc7YMNJhZq2gfhrYE
	 qoyooeA2mn63qlDKYfOpjzRmOcD/LK+n1/yVkuk42WnVbmOEJq0g2ovZLnXD+GKUMn
	 fqgPmxgqzxmArB4gg8RCoXNBbzGQIiml/L9Tptag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5D6FF805D5; Fri, 14 Jul 2023 14:24:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33BBCF805CB;
	Fri, 14 Jul 2023 14:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D13B7F8059F; Fri, 14 Jul 2023 14:24:31 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5F6AAF80153
	for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2023 14:24:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F6AAF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ShfPqW1t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337446; x=1720873446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3HZv5qJPf5xVVC8Dhp4RNscGO5uzAyDv01K9l4KYPQ=;
  b=ShfPqW1t/8lsZkZkEvKX2WliERPp33ekcSKyuIoG1uqpgFlU0fZjxOpE
   123YU+NfAOzawoLGjvQiL7js75ig4pwa96YHEkP8MoquyvmFTfZmUPMKX
   XUR548jgM4aWCTUboKxc0IGNuooYJ/ZVG2n37MJVw9WG0D7rEjBo714ga
   U5jrJXfo46+9XhRcfLWburLC4o5lYmrH4GR/gz4fGCJkf6quND4M8Xmfv
   jmlyzz94Va19eKh55fVzG4D9KmDalmINvzjs6OzLw5xMif1i/KwnhTPRp
   2+mtGUHYiL8EgFNXAxS11K1ZpL0pIUEJLcIcZsebc+6ogX0odkf7Zf1MW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225808"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="429225808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2023 05:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053034865"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="1053034865"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:23:48 -0700
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
Subject: [PATCH v3 03/15] ASoC: SOF: Remove unused Broxton PCI ID
Date: Fri, 14 Jul 2023 22:24:45 +0200
Message-Id: <20230714202457.423866-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 46E73D7ZYNAXTTYTB464ZPJRM4GUTS64
X-Message-ID-Hash: 46E73D7ZYNAXTTYTB464ZPJRM4GUTS64
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/46E73D7ZYNAXTTYTB464ZPJRM4GUTS64/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Current code references 0x1a98 which is BXT-M (not -T as it is
commented) and it's an RVP, BXT-M B0 to be specific. From what we know
no BXT is available on market.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/intel-dsp-config.c  | 7 -------
 sound/soc/sof/intel/pci-apl.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 317bdf6dcbef..5cee995f7a42 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -53,13 +53,6 @@ static const struct config_entry config_table[] = {
 		.device = 0x119a,
 	},
 #endif
-/* Broxton-T */
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
-	{
-		.flags = FLAG_SOF,
-		.device = 0x1a98,
-	},
-#endif
 /*
  * Apollolake (Broxton-P)
  * the legacy HDAudio driver is used except on Up Squared (SOF) and
diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
index 69cad5a6bc72..bc3ad64baec5 100644
--- a/sound/soc/sof/intel/pci-apl.c
+++ b/sound/soc/sof/intel/pci-apl.c
@@ -87,8 +87,6 @@ static const struct sof_dev_desc glk_desc = {
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE(0x8086, 0x5a98), /* BXT-P (ApolloLake) */
 		.driver_data = (unsigned long)&bxt_desc},
-	{ PCI_DEVICE(0x8086, 0x1a98),/* BXT-T */
-		.driver_data = (unsigned long)&bxt_desc},
 	{ PCI_DEVICE(0x8086, 0x3198), /* GeminiLake */
 		.driver_data = (unsigned long)&glk_desc},
 	{ 0, }
-- 
2.34.1

