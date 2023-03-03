Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C93C64EC4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Mar 2023 13:53:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486B9DF6;
	Fri,  3 Mar 2023 14:52:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486B9DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677851592;
	bh=sanC6Jt1tjQPITAda83dPQ89Fu2XuJu8kW31jwXgN24=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Oq6RdRvWpPB3kkL30eqD7Nemhe+ua8n+Za+5ev7Otc3c7gsXQJbvbsBueknIbil1t
	 IDmv4JHIVBiUXloRPMdOv3FcaXbdnvLdLQQ2X23XF+b0M+VLVFHlzeHF1mKe+6iTc2
	 u9BfQWLjb8hrxZ36jOJtuXgJGPbejbMeTvZeGSv8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 468CFF80567;
	Fri,  3 Mar 2023 14:50:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37428F80542; Fri,  3 Mar 2023 14:50:48 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A8B34F80520
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2023 14:50:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8B34F80520
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WtuNa7hx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677851439; x=1709387439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sanC6Jt1tjQPITAda83dPQ89Fu2XuJu8kW31jwXgN24=;
  b=WtuNa7hxA/7EOJZTyaVNsUdQTH4nYMUKY8piyV4R7ZuiMldSJmHRZUC+
   Mz9SFzQP+dgbwuIYzMX3WwPLJ9JwbwvWpovCl8jnFQvkDg5wtDbyHIpLT
   XxIm81WGljQCKc29cXuvLKyxPEsJL++UM9kOLNuQpXcLndZ/nKtmyRubb
   1Agd2JORCI87LeVAIFui9CAPVsEhJfZOTNZpIrT/EZMaAqfkx91r1OSMF
   yjUxr6NCTZ61CYmC8C7/zZePGMBxGiEM55EHfICGM+NsWTKK7dyTdsaVy
   WzflnDoONuJ7WJ3TJIV+tTIx4C+8mUj6kZCOH06lfhj2PMcrV4arNkvQZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="336564485"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400";
   d="scan'208";a="336564485"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2023 05:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668660757"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400";
   d="scan'208";a="668660757"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2023 05:49:30 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: Intel: avs: nau8825: Adjust clock control
Date: Fri,  3 Mar 2023 14:48:54 +0100
Message-Id: <20230303134854.2277146-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303134854.2277146-1-amadeuszx.slawinski@linux.intel.com>
References: <20230303134854.2277146-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2T7GSDRUPGJCVV2V6T4MVLMYCOCOOIL7
X-Message-ID-Hash: 2T7GSDRUPGJCVV2V6T4MVLMYCOCOOIL7
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2T7GSDRUPGJCVV2V6T4MVLMYCOCOOIL7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Cezary Rojewski <cezary.rojewski@intel.com>

Internal clock shall be adjusted also in cases when DAPM event other
than 'ON' is triggered.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/boards/nau8825.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index b31fa931ba8b..b69fc5567135 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -33,15 +33,15 @@ avs_nau8825_clock_control(struct snd_soc_dapm_widget *w, struct snd_kcontrol *co
 		return -EINVAL;
 	}
 
-	if (!SND_SOC_DAPM_EVENT_ON(event)) {
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_MCLK, 24000000,
+					     SND_SOC_CLOCK_IN);
+	else
 		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "set sysclk err = %d\n", ret);
-			return ret;
-		}
-	}
+	if (ret < 0)
+		dev_err(card->dev, "Set sysclk failed: %d\n", ret);
 
-	return 0;
+	return ret;
 }
 
 static const struct snd_kcontrol_new card_controls[] = {
-- 
2.34.1

