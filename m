Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C245EC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478336056C
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 478336056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A61D916AC;
	Thu, 19 Aug 2021 21:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A61D916AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629400120;
	bh=/evmyv27BD+3GpzdpvO58epAxbCnBLr2E5cuPDGF8XE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=No/dJE2fWm9isLhZl/AEdcw4belItLphfr2XDCVxWcFC+GysjP38Q/OZKeLZYPHEb
	 HVT/s62akle/nISAlgncBYqohtqmqBXoM2GZsrv2pKSkW3wX4Xza1ttt2nhCf27zLi
	 UPKE8Nb+oFq13y0gU2xVufOiVwNWhEa0zp7EcyOo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C6BAF804FB;
	Thu, 19 Aug 2021 21:06:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7249F804F3; Thu, 19 Aug 2021 21:06:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50331F80302
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 21:06:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50331F80302
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="gegewp5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629399959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPmtEQsuEg8FNOpx5iJCNu2rENF9mz+jF10rVnnVLAs=;
 b=gegewp5yK6IwiGyfEjTmbtGK0sK6vbGnaXLU791psTig6HARmdwy5j75twzJUPtSb/SyYq
 c6kjXDnEh2JDtCJomKcYhErtRYGzr2PBhi2SYiHoN0+742fmBraUQSDDSwMDW+QV9S/fl5
 HuaQ1Vqa6AyWrgrsKNfoLcpcfo5ePgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Zku_LVEjN_6K8_KmpvQ38w-1; Thu, 19 Aug 2021 15:05:58 -0400
X-MC-Unique: Zku_LVEjN_6K8_KmpvQ38w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F70F93920;
 Thu, 19 Aug 2021 19:05:57 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83C4F1A26A;
 Thu, 19 Aug 2021 19:05:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 5/6] ASoC: Intel: bytct_rt5640: Add a separate "Headset Mic
 2" DAPM pin for the mic on the 2nd jack
Date: Thu, 19 Aug 2021 21:05:42 +0200
Message-Id: <20210819190543.784415-6-hdegoede@redhat.com>
In-Reply-To: <20210819190543.784415-1-hdegoede@redhat.com>
References: <20210819190543.784415-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Bard Liao <bard.liao@intel.com>
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

In order to be able to do jack-detection reporting for the
mic contact on the 2nd jack found on some devices, the
DAPM topology needs to have a separate DAPM pin/input for that
microphone, instead of re-using the "Internal Mic" pin which is
normally used together with the IN1P input of the codec.

Using the "Internal Mic" dapm-pin-switch for this in a snd_soc_jack_pin to
report hotplug events causes the "Internal Mic" pin to get deactivated
when unplugging a headset from the 2nd jack, thus turning off the actual
Internal Mic (typically a pair of digital mics on devices with 2 jacks).

Fixes: 79c1123bac3b ("ASoC: Intel: bytcr_rt5640: Add support for a second headset mic input")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index d9e23c793f96..3c5ca97f22a9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -324,6 +324,7 @@ static int byt_rt5640_event_lineout(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic 2", NULL),
 	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_LINE("Line Out", byt_rt5640_event_lineout),
@@ -363,6 +364,12 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in3_map[] = {
 	{"IN3P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_hsmic2_in1_map[] = {
+	{"Headset Mic 2", NULL, "Platform Clock"},
+	{"Headset Mic 2", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "Headset Mic 2"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif1_map[] = {
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
@@ -422,6 +429,7 @@ static const struct snd_soc_dapm_route byt_rt5640_lineout_map[] = {
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic 2"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 	SOC_DAPM_PIN_SWITCH("Line Out"),
@@ -1086,8 +1094,8 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 
 	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1) {
 		ret = snd_soc_dapm_add_routes(&card->dapm,
-					byt_rt5640_intmic_in1_map,
-					ARRAY_SIZE(byt_rt5640_intmic_in1_map));
+					byt_rt5640_hsmic2_in1_map,
+					ARRAY_SIZE(byt_rt5640_hsmic2_in1_map));
 		if (ret)
 			return ret;
 	}
-- 
2.31.1

