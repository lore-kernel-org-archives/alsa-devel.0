Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD79C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74C760FE8
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C74C760FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8F6316D8;
	Mon, 25 Oct 2021 21:01:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8F6316D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635188510;
	bh=IOmXWbPhhviwwagnxkw8CrRT8OyOmSWF1iELZAjZMx4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idfrh3oSdOtUxspXITkIC7me0WLsZ3qu53mFEzZw3XmgNy6k7dzk1Clgi+ZK0SR4H
	 17renSoy59KL88y1a5X1a+nNsqTxWEkkP4/8XwqeQA5yHmK6ZTEvSpePYOkW3DFgy6
	 8ne3X8hdbX99wi1lXSJiIzQzEXWiHEIKOnEhr5h4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6487F804E3;
	Mon, 25 Oct 2021 21:00:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26D83F80271; Mon, 25 Oct 2021 21:00:11 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E65CF80153
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 21:00:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E65CF80153
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216908154"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; d="scan'208";a="216908154"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 11:59:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; d="scan'208";a="554318460"
Received: from ssubbar1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.118.197])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 11:59:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/8] ASoC: rt5682s: use 'static' qualifier
Date: Mon, 25 Oct 2021 13:59:27 -0500
Message-Id: <20211025185933.144327-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025185933.144327-1-pierre-louis.bossart@linux.intel.com>
References: <20211025185933.144327-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Sparse reports the following warnings:

sound/soc/codecs/rt5682s.c:44:12: error: symbol 'rt5682s_supply_names'
was not declared. Should it be static?

sound/soc/codecs/rt5682s.c:74:26: error: symbol 'rt5682s_reg' was not
declared. Should it be static?

sound/soc/codecs/rt5682s.c:2841:30: error: symbol
'rt5682s_aif1_dai_ops' was not declared. Should it be static?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5682s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index f6435b233a51..470957fcad6b 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -41,7 +41,7 @@ static const struct rt5682s_platform_data i2s_default_platform_data = {
 	.dai_clk_names[RT5682S_DAI_BCLK_IDX] = "rt5682-dai-bclk",
 };
 
-const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
+static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
 	"AVDD",
 	"MICVDD",
 };
@@ -71,7 +71,7 @@ static void rt5682s_apply_patch_list(struct rt5682s_priv *rt5682s,
 		dev_warn(dev, "Failed to apply regmap patch: %d\n", ret);
 }
 
-const struct reg_default rt5682s_reg[] = {
+static const struct reg_default rt5682s_reg[] = {
 	{0x0002, 0x8080},
 	{0x0003, 0x0001},
 	{0x0005, 0x0000},
@@ -2838,7 +2838,7 @@ static int rt5682s_resume(struct snd_soc_component *component)
 #define rt5682s_resume NULL
 #endif
 
-const struct snd_soc_dai_ops rt5682s_aif1_dai_ops = {
+static const struct snd_soc_dai_ops rt5682s_aif1_dai_ops = {
 	.hw_params = rt5682s_hw_params,
 	.set_fmt = rt5682s_set_dai_fmt,
 	.set_tdm_slot = rt5682s_set_tdm_slot,
-- 
2.25.1

