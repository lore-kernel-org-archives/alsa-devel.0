Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710DDC54E64
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Mar 2024 22:16:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC15D22A4;
	Mon, 25 Mar 2024 23:15:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC15D22A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711404963;
	bh=xXYDf5Yx8awx5/zxr4AQ4Z2qqLzUBRKjDHFB9ZaxsUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S1zYMmvSpljj5NnK5sVIBfHBeLr3mpf09NMHhGEkINdcBDJ6HQOAToqddeMPqO/ao
	 lA10Qi2Y48I7HKXPDalwEkNsf17bvcxlWx4XeR6gdmW+SuX0ZBckunvqz48Dd74NbM
	 8/NmBZRhGLBzGh3jZQ8OJCgHUif9dD2T5Q4OZ/kE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F72CF808BB; Mon, 25 Mar 2024 23:12:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84649F805E7;
	Mon, 25 Mar 2024 23:12:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBFAAF80699; Mon, 25 Mar 2024 23:11:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A5E2F805BD
	for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2024 23:11:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A5E2F805BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PuzxX94F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711404690; x=1742940690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXYDf5Yx8awx5/zxr4AQ4Z2qqLzUBRKjDHFB9ZaxsUM=;
  b=PuzxX94FeJhijmgEgCH+THeGflp751zWb6rSGw1sIAjhmZDaHuAm9b74
   V4B67OQnYMMzD9n7kDYbLSG0I+cnYSh7WrN4tqwXN5qUmrkpq4fd4RmZm
   PbGQst11ZB3IayY02iQUHArnZivTsO7xPv1rUIWcEWEexbgSAZ1cAW3gX
   saKHlGb/V2InFQMBLZULZwKlu1b5TKmwXGXOq3Lh7U2K7GDSqWz8CBCql
   2KhpUXPpqvT3e2fpxVCkIuMHFXUy1EesXcsHSb9n3BiZJLEsKa5V5fKC5
   hSayJSaxPDOpVhlkhQe1b6/iPOC+zQxR8IkOTwmRrc9rDHCWBUhMiDtk2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6643657"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="6643657"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="15722145"
Received: from jaimbres-mobl2.amr.corp.intel.com (HELO pbossart-mobl6.lan)
 ([10.212.98.109])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:11:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/21] ASoC: Intel: sof_da7219: add codec exit function
Date: Mon, 25 Mar 2024 17:10:51 -0500
Message-Id: <20240325221059.206042-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325221059.206042-1-pierre-louis.bossart@linux.intel.com>
References: <20240325221059.206042-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2FXVSGVMUQX32JMM2HZBL72AOA2ADQ6R
X-Message-ID-Hash: 2FXVSGVMUQX32JMM2HZBL72AOA2ADQ6R
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2FXVSGVMUQX32JMM2HZBL72AOA2ADQ6R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Add exit function to headphone codec dai link.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_da7219.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_da7219.c b/sound/soc/intel/boards/sof_da7219.c
index f0cb1572c6c4..3d9c48107f58 100644
--- a/sound/soc/intel/boards/sof_da7219.c
+++ b/sound/soc/intel/boards/sof_da7219.c
@@ -167,6 +167,13 @@ static int da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static void da7219_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int max98373_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
@@ -245,6 +252,7 @@ sof_card_dai_links_create(struct device *dev, struct snd_soc_card *card,
 	ctx->codec_link->codecs = da7219_component;
 	ctx->codec_link->num_codecs = ARRAY_SIZE(da7219_component);
 	ctx->codec_link->init = da7219_codec_init;
+	ctx->codec_link->exit = da7219_codec_exit;
 
 	if (ctx->amp_type == CODEC_NONE)
 		return 0;
-- 
2.40.1

