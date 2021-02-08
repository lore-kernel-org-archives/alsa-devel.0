Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43282C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:42:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9FD64E8F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9FD64E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FA4F16AA;
	Tue,  9 Feb 2021 00:41:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FA4F16AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827763;
	bh=i6xd95hxNSMhXBRWCiqPXGFYA1XjTk5QcLCC+SPjwhU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dfVY6v3+9SZW5Fzkkrbo++WoZCi2pK4RYjtBhnMIzagyeaMdinCd6sN5OV0+Gzp5C
	 QurzGc4PXAhRpmXKwv1EgOmRLivTMTUD7XwZyA3Kj59wYBkzs+8B2/773maFOnbk+/
	 yX7rpLovSfg2YQeftdb6tkI0pYX1ASmcrvh79SA4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2764F8022B;
	Tue,  9 Feb 2021 00:41:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD1DCF8026C; Tue,  9 Feb 2021 00:41:04 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14DF6F80169
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:40:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14DF6F80169
IronPort-SDR: fRUY0AURplqudEW62adrVj/nHut+LwTi/6amtSa6F6lQwRmqOR7zKwYqaaouOkBzQh8agAX7mZ
 6qcLemU9vFrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243297907"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="243297907"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:53 -0800
IronPort-SDR: wJbBfpSQvkBP1AvebOivCQm4juo6dM6Clz2KOkXdZ77ciG5WCcNTyby+9+YABpZMr1+iUPsETC
 S1JrXrKEFx0w==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="487640915"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/2] ASoC: dapm: use component prefix when checking widget
 names
Date: Mon,  8 Feb 2021 17:40:42 -0600
Message-Id: <20210208234043.59750-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208234043.59750-1-pierre-louis.bossart@linux.intel.com>
References: <20210208234043.59750-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Shuming Fan <shumingf@realtek.com>, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Shuming Fan <shumingf@realtek.com>

On a TigerLake SoundWire platform, we see these warnings:

[   27.360086] rt5682 sdw:0:25d:5682:0: ASoC: DAPM unknown pin MICBIAS
[   27.360092] rt5682 sdw:0:25d:5682:0: ASoC: DAPM unknown pin Vref2

This is root-caused to the addition of a component prefix in the
machine driver. The tests in soc-dapm should account for a prefix
instead of reporting an invalid issue.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2b75d0139e47..b005f9eadd71 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2528,9 +2528,20 @@ static struct snd_soc_dapm_widget *dapm_find_widget(
 {
 	struct snd_soc_dapm_widget *w;
 	struct snd_soc_dapm_widget *fallback = NULL;
+	char prefixed_pin[80];
+	const char *pin_name;
+	const char *prefix = soc_dapm_prefix(dapm);
+
+	if (prefix) {
+		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
+			 prefix, pin);
+		pin_name = prefixed_pin;
+	} else {
+		pin_name = pin;
+	}
 
 	for_each_card_widgets(dapm->card, w) {
-		if (!strcmp(w->name, pin)) {
+		if (!strcmp(w->name, pin_name)) {
 			if (w->dapm == dapm)
 				return w;
 			else
-- 
2.25.1

