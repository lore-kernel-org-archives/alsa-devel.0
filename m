Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A5C001DF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Aug 2023 15:15:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 072E6857;
	Wed,  2 Aug 2023 17:14:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 072E6857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690989324;
	bh=AUNY4fOKGSINjHCvUnG98cy9TPxbQGOZ0uRCfqLy5bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FGi6MREdtUjwlhHPTbRsnP8fmT5zbjHAuHs6OfY7qpuIdfxwhuzH/n74EFgPdu6HQ
	 efzjYQwxNdOo3t0S2H0GTDlOJj5gtMCz3DZFAy5DlwlugusibpnSeGIos7GRtaAe+K
	 K0VW9uPixjIIGWEbky6Lgr37Ly91skrjv++NVwxQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35281F805AC; Wed,  2 Aug 2023 17:13:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86FB9F8058C;
	Wed,  2 Aug 2023 17:13:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DD4AF80563; Wed,  2 Aug 2023 17:12:53 +0200 (CEST)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7E698F8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2023 17:12:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E698F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q8bHS5Yb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989167; x=1722525167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUNY4fOKGSINjHCvUnG98cy9TPxbQGOZ0uRCfqLy5bE=;
  b=Q8bHS5YbMN6TarAiDC4X39CzftTypk8oj9qUun498adDUj5YYFmcp0Pj
   3znEVn2bsx8cXD5etp1i6yxTdedHmb3moYCci/ITXIs7C7DYr6i7xirb0
   CnwiXlG5Qos7nHM3gaHluLDsZk+8yzPiOmEw5fJQAEtr8JIlaieyrHnN6
   /mMUiIT8Rka8leczKkri5YQnCoW7MLOuOX61GNdHG/GUamV0kcTaCoato
   bmjnqWTl1nv09HcYsC8zwTRKtgZUa8eVgzZnnzLcMkAAbj/fwXxJBOiCt
   FEdY2t3lpOEnREftUPmlqoqVTnBwMMzFwl+XDcqJuc8mLX8KwSY5qb8nT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369607277"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200";
   d="scan'208";a="369607277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 08:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732428688"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200";
   d="scan'208";a="732428688"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.125.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 08:01:15 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 4/5] ALSA: hda: intel-dsp-cfg: add LunarLake support
Date: Wed,  2 Aug 2023 10:01:04 -0500
Message-Id: <20230802150105.24604-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
References: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: APSJOOXBKJQREUIISZFGURPWZDHQZWS4
X-Message-ID-Hash: APSJOOXBKJQREUIISZFGURPWZDHQZWS4
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/APSJOOXBKJQREUIISZFGURPWZDHQZWS4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

One more PCI ID for the road.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 1abe65f0ba1b..dcf2453138a5 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -465,6 +465,14 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Lunar Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_LUNARLAKE)
+	/* Lunarlake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_LNL_P,
+	},
+#endif
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.39.2

