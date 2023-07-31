Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7347C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:41:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1573E868;
	Mon, 31 Jul 2023 23:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1573E868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839678;
	bh=OAI2qcEg7OqvHUBhJ2efMbqxaB8PVBmIckjGoOZBK50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GUY1sNHH4g5QSbCxGoC5JJ8z+34pZY3lbZZ4hsnVcoln0dmKkzHiJlj+Gwa46ieNY
	 C7RopqTexlY5QV+YHQ8v8iRtiqco4Sb5+LnaYrKexGpzIySvmuKBHMcqd+M6oa4u/F
	 cJfq8QjEQ6xYHWwPb3rDdsDQH2S8sExNhlh/UUUI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 055C4F805D5; Mon, 31 Jul 2023 23:38:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6350DF805CA;
	Mon, 31 Jul 2023 23:38:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A8D0F80588; Mon, 31 Jul 2023 23:38:23 +0200 (CEST)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80CA9F8056F
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80CA9F8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XgC8OyPX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839501; x=1722375501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OAI2qcEg7OqvHUBhJ2efMbqxaB8PVBmIckjGoOZBK50=;
  b=XgC8OyPXjtxxd3y5vbxijW+GVBoFiPHt3i5maXvP+KA0uBPZnaNHVllb
   bt9svEGP+lGSFLKcW5UGV2jQADsx0leCuOzGvG5EjwprMhMfB6ctna4vL
   wYO0gtIugye/fuUyJAAEzsMgg24VTso1vO/4CFVArpelHbMAkLsU4GDzu
   mTLe35KTxXEkm2nC/acFL3njM8yF886ioBhLT5CHswqtlH1Nvl5fEPcw/
   h+ajK21z2HtV/6b0nK2hl0QZR3JpqlA5m9YiUU+IiOLsoTr2bNzvjYLdf
   FMPNOo3ijW6S2Q2GE8uEU6Ec/9nfW7Oif5ll3IZLlyH7DuIcLy/0Vy78v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366604154"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="366604154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793880102"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="793880102"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Yaochun Hung <yc.hung@mediatek.com>
Subject: [PATCH 8/8] ASoC: amd: acp5x-mach:add checks to avoid static analysis
 warnings
Date: Mon, 31 Jul 2023 16:37:48 -0500
Message-Id: <20230731213748.440285-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ET26PBT6VAV5J66OAERMM42GLM7PMCLX
X-Message-ID-Hash: ET26PBT6VAV5J66OAERMM42GLM7PMCLX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ET26PBT6VAV5J66OAERMM42GLM7PMCLX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_soc_card_get_codec_dai() can return NULL, but that value is not
checked for, leading to static analysis warnings.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 125a8e93478d..eda464545866 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -170,6 +170,9 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(card, ACP5X_NAU8821_DAI_NAME);
 	int ret, bclk;
 
+	if (!dai)
+		return -EINVAL;
+
 	ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(card->dev, "can't set FS clock %d\n", ret);
-- 
2.39.2

