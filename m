Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2348C54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:55:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E58206D4
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vM39ikpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E58206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1FB2167E;
	Mon, 27 Apr 2020 18:54:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1FB2167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588006536;
	bh=o7NKlDkSZDhJnRe1zo3IfhVbK7cN5ZN7C18UbIEGD5M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM39ikpIaABbK4Omjh2t20NBUMevQLcyXC02vTYC1/Pqlog/MyyFqYsrl5ZLOJt3h
	 p6kbWCd6nzRtUd5zpqQ2qEVyZhqGhqHUn/C4MSqpwjjdZZHOoaTETPAguLAclakZhA
	 F+QzWwHIWl3sQesJqNGLJJvrA01RfdPIYJTCnEs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F340F8029A;
	Mon, 27 Apr 2020 18:52:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F692F80292; Mon, 27 Apr 2020 18:52:28 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2810F80247
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 18:52:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2810F80247
IronPort-SDR: Dt/c+sOPePBMKggsKSQI94N/Xik5MtMXSX81wWpBu8lv3lsSOzUf3MIpDtX5o9nYIfMWI25VCI
 k5Rx0xWkIPmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 09:52:11 -0700
IronPort-SDR: vxbFXYqNgzsMpuy0R+ADSE7VGQ4b5hMID4ZpwnpHsIu162kDQAHshdXhIcXvAbCWf7feWcRu6z
 16+ccdtEBNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="248925569"
Received: from dbombien-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.51.189])
 by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 09:52:11 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ASoC: sof_pcm512x: remove CONFIG_SND_HDA_CODEC_HDMI
 condition
Date: Mon, 27 Apr 2020 09:52:11 -0700
Message-Id: <20200427165211.23463-5-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427165211.23463-1-ranjani.sridharan@linux.intel.com>
References: <20200427165211.23463-1-ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, Libin Yang <libin.yang@linux.intel.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
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

From: Libin Yang <libin.yang@linux.intel.com>

As CONFIG_SND_HDA_CODEC_HDMI is always enabled in sof_pcm512x,
let's remove the test of CONFIG_SND_HDA_CODEC_HDMI in the
sof_pcm512x driver.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/boards/sof_pcm512x.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/intel/boards/sof_pcm512x.c b/sound/soc/intel/boards/sof_pcm512x.c
index fb7811899999..068b3f3dcf11 100644
--- a/sound/soc/intel/boards/sof_pcm512x.c
+++ b/sound/soc/intel/boards/sof_pcm512x.c
@@ -126,7 +126,6 @@ static struct snd_soc_dai_link_component platform_component[] = {
 	}
 };
 
-#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 static int sof_card_late_probe(struct snd_soc_card *card)
 {
 	struct sof_card_private *ctx = snd_soc_card_get_drvdata(card);
@@ -146,12 +145,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 
 	return hda_dsp_hdmi_build_controls(card, pcm->codec_dai->component);
 }
-#else
-static int sof_card_late_probe(struct snd_soc_card *card)
-{
-	return 0;
-}
-#endif
 
 static const struct snd_kcontrol_new sof_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
@@ -374,14 +367,12 @@ static int sof_audio_probe(struct platform_device *pdev)
 		sof_pcm512x_quirk = SOF_PCM512X_SSP_CODEC(2);
 	} else {
 		dmic_be_num = 2;
-#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 		if (mach->mach_params.common_hdmi_codec_drv &&
 		    (mach->mach_params.codec_mask & IDISP_CODEC_MASK))
 			ctx->idisp_codec = true;
 
 		/* links are always present in topology */
 		hdmi_num = 3;
-#endif
 	}
 
 	dmi_check_system(sof_pcm512x_quirk_table);
-- 
2.17.1

