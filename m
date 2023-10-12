Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B11BCDB482
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Oct 2023 19:11:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C21E7DFA;
	Thu, 12 Oct 2023 21:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C21E7DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697137910;
	bh=La/ibYT5/Ro73acjJ7rSnT5FOHXhSbEe9/YIqenUIY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F/DMfMefgfMgWOCUFMfKkPxYzIVfS1X6MI4FQ9m/MpipBWhDEYwGs3rEhu3KE0wv5
	 3yLLwRpE19EyUXMRhcHUiCXwB+O+uGanDn9OSfIDAcECPZG/YNO51JwqGJfuO72Lwg
	 0P1E0tpoCey/3xn1cxO2Pv3r78/zsVsr10kahUYY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54506F805D5; Thu, 12 Oct 2023 21:09:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74672F805D3;
	Thu, 12 Oct 2023 21:09:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20412F805C4; Thu, 12 Oct 2023 21:09:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4FFEF80553
	for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2023 21:09:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4FFEF80553
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jG/lUqwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697137742; x=1728673742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La/ibYT5/Ro73acjJ7rSnT5FOHXhSbEe9/YIqenUIY4=;
  b=jG/lUqwALFy3tSF8MD3JNdFtn9jrs52vu1bvtp0qvpNnN3F4+LCEA1BT
   urJbWSrEN/x6A0Ne8r3p8FB2i++fEjgOu0BqFD4hl6EexJJszi9AtQVHM
   IPfAaL/yCmlgi+pFZVlTdSB76AEa1J3BUXpsyyWDyGt8jR23NP7XNo5cc
   uCpB6pnhWQ1S5yTEZCaMfr/zJCfQU7UYddifoDlIRZeMC5DvcdsRWaxnn
   I7fiE5uqYcyOp3oN/Mj91wZf4ri/0ct5xaOfD8c+7H1njIuXqHHT8uqt6
   O52w4ZKRclmJFiUT2ibmYvw5AJJncG28sMoIIji1IGXBGYhRhPrrhzeEF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416060195"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="416060195"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845108071"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="845108071"
Received: from gchoudha-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.hsd1.md.comcast.net) ([10.212.114.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:44 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/23] ASoC: Intel: sof_da7219: remove hdac-hdmi support
Date: Thu, 12 Oct 2023 15:08:11 -0400
Message-Id: <20231012190826.142619-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
References: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LDQTQCP3BOZTKM7H3VUXPEPLLJNCJIG4
X-Message-ID-Hash: LDQTQCP3BOZTKM7H3VUXPEPLLJNCJIG4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LDQTQCP3BOZTKM7H3VUXPEPLLJNCJIG4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Remove hdac-hdmi support code since we are now using
snd-hda-codec-hdmi codec driver for hdmi.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_da7219.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/sof_da7219.c b/sound/soc/intel/boards/sof_da7219.c
index f21482c42667..03131cb495d1 100644
--- a/sound/soc/intel/boards/sof_da7219.c
+++ b/sound/soc/intel/boards/sof_da7219.c
@@ -27,13 +27,11 @@
 struct hdmi_pcm {
 	struct list_head head;
 	struct snd_soc_dai *codec_dai;
-	int device;
 };
 
 struct card_private {
 	struct snd_soc_jack headset_jack;
 	struct list_head hdmi_pcm_list;
-	struct snd_soc_jack hdmi[3];
 	enum sof_ssp_codec codec_type;
 	enum sof_ssp_codec amp_type;
 
@@ -238,7 +236,6 @@ static int hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	if (!pcm)
 		return -ENOMEM;
 
-	pcm->device = dai->id;
 	pcm->codec_dai = dai;
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
@@ -249,17 +246,10 @@ static int hdmi_init(struct snd_soc_pcm_runtime *rtd)
 static int card_late_probe(struct snd_soc_card *card)
 {
 	struct card_private *ctx = snd_soc_card_get_drvdata(card);
-	struct snd_soc_acpi_mach *mach = (card->dev)->platform_data;
 	struct hdmi_pcm *pcm;
 
-	if (mach->mach_params.common_hdmi_codec_drv) {
-		pcm = list_first_entry(&ctx->hdmi_pcm_list, struct hdmi_pcm,
-				       head);
-		return hda_dsp_hdmi_build_controls(card,
-						   pcm->codec_dai->component);
-	}
-
-	return -EINVAL;
+	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct hdmi_pcm, head);
+	return hda_dsp_hdmi_build_controls(card, pcm->codec_dai->component);
 }
 
 SND_SOC_DAILINK_DEF(ssp0_pin,
-- 
2.39.2

