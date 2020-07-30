Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C052CC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6B120809
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HGoGgA3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6B120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC4E8176B;
	Thu, 30 Jul 2020 10:19:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC4E8176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596097240;
	bh=CyJ0Xsmhq/iB6sLmlnOWDOpEeUlTFnjHlr2D9JGNuvs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HGoGgA3oneMvOx10RxhNPqYwcoKaA/+0+9ge0Sk+tke5A0IzynQE8g+l2e1Ye2G8X
	 Bn5L7xuUsiLzw4aHqlWCtOLCOM0SPVjpXqxRYMulqEOyEeUWgYBBGoaTSh+X3JDbca
	 JpswDTPhbYgf40M2v/bs0WPcF9I72lKhrvxZP1OA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A78DF802DB;
	Thu, 30 Jul 2020 10:18:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB6CFF802DC; Thu, 30 Jul 2020 10:18:40 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD992F802C2
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 10:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD992F802C2
IronPort-SDR: pJj3gkq1YmLDjODkNYngFyEEKwHsqHEOg4vL1YMQeRCswxYD7qEk6O8kmN4CaNNqHQfG1K5V9C
 sYulpY4ATG9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="131117820"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="131117820"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 01:18:25 -0700
IronPort-SDR: 1fVS2jg0dgV/a8QpBMPaWqGS1VfFv14PttNzgl6lt8t/13HJslfgDb43NLnV9KyKTuywB3y7nw
 aZMAT4cvVGVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="272863448"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 01:18:21 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] ASoC: Intel: Add period size constraint on strago board
Date: Thu, 30 Jul 2020 16:13:35 +0800
Message-Id: <1596096815-32043-3-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Daniel Stuart <daniel.stuart14@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Brent Lu <brent.lu@intel.com>, Damian van Soelen <dj.vsoelen@gmail.com>
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

From: Yu-Hsuan Hsu <yuhsuan@chromium.org>

The CRAS server does not set the period size in hw_param so ALSA will
calculate a value for period size which is based on the buffer size
and other parameters. The value may not always be aligned with Atom's
dsp design so a constraint is added to make sure the board always has
a good value.

Cyan uses chtmax98090 and others(banon, celes, edgar, kefka...) use
rt5650.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 835e9bd..bf67254 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -283,8 +283,20 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static int cht_aif1_startup(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_hw_constraint_single(substream->runtime,
+	int err;
+
+	/* Set period size to 240 to align with Atom design */
+	err = snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_single(substream->runtime,
 			SNDRV_PCM_HW_PARAM_RATE, 48000);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static int cht_max98090_headset_init(struct snd_soc_component *component)
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b53c024..6e62f0d 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -414,8 +414,20 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static int cht_aif1_startup(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_hw_constraint_single(substream->runtime,
+	int err;
+
+	/* Set period size to 240 to align with Atom design */
+	err = snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_single(substream->runtime,
 			SNDRV_PCM_HW_PARAM_RATE, 48000);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static const struct snd_soc_ops cht_aif1_ops = {
-- 
2.7.4

