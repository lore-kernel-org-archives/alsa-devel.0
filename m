Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50DC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 14:28:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BDC60F41
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 14:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61BDC60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EECF0171E;
	Mon,  2 Aug 2021 16:27:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EECF0171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627914478;
	bh=PzLi1aXYedEF0rZqHCf4nZDnBEZIdH9pfs4y0XIpfyU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AdvmybavgbqaT0ULBiLDAuVErue4UkLuNPZtG0VgTaFYSYW0xnPHpUuVMhMvRiARz
	 2PtpLn5jzR6oBlmQSK0SRl7hHS6Yr7eyf9/jnlpT8OKiQm0V9QMRACrVVyHS1+9ZLO
	 W6DMZ1bXoSH5m6mPw3bM4KL1yYVUubEswDhpeFdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 146EFF804FA;
	Mon,  2 Aug 2021 16:25:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA25AF804FB; Mon,  2 Aug 2021 16:25:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BDB5F804EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 16:25:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BDB5F804EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="B68QHDo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627914327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8zx0N62PXn5hPQwAQkSE8171NBLf9VgKDBX4FDBGYk=;
 b=B68QHDo9YgNEQvtbgQMe2EQ2BPWKH+jMYoS5SEydLojBTO5AVnPS5FsedBHihcvui7kbHu
 uTM2RO6OUktWSWr7SqxFgPR33Pf9uTbLV0blpQO1UZV5A6GGldGo1LypDNZSVnwalbekLh
 g14TaKS7oPEOS8tWrWrFyjNL8gKJ2z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-ice7uOy_NcK3bowZYhEcag-1; Mon, 02 Aug 2021 10:25:26 -0400
X-MC-Unique: ice7uOy_NcK3bowZYhEcag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C3981934104;
 Mon,  2 Aug 2021 14:25:24 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 003FB60C82;
 Mon,  2 Aug 2021 14:25:20 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/6] ASoC: Intel: bytcr_rt5640: Add support for a second
 headphones output
Date: Mon,  2 Aug 2021 16:24:59 +0200
Message-Id: <20210802142501.991985-5-hdegoede@redhat.com>
In-Reply-To: <20210802142501.991985-1-hdegoede@redhat.com>
References: <20210802142501.991985-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Some devices (HP Elitepad 1000 G2) have a second headphones output
(1 on the dock, 2nd on the tablet itself) which is implemented through
the line-out output of the codec combined with an external hp-amp
which gets enabled through the codec's GPIO1 pin.

Add support for this through a new BYT_RT5640_LINEOUT_AS_HP2 quirk,
note users are expected to use this combined with the
BYT_RT5640_LINEOUT quirk. If that quirk is not set the new quirk is
ignored.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Only set lineout_string if BYT_RT5640_LINEOUT is set, since
  BYT_RT5640_LINEOUT_AS_HP2 only works if the lineout is enabled in
  the first place
---
 sound/soc/intel/boards/bytcr_rt5640.c | 40 +++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 70faba13450c..54302a86f8df 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -74,6 +74,7 @@ enum {
 #define BYT_RT5640_MCLK_25MHZ		BIT(23)
 #define BYT_RT5640_NO_SPEAKERS		BIT(24)
 #define BYT_RT5640_LINEOUT		BIT(25)
+#define BYT_RT5640_LINEOUT_AS_HP2	BIT(26)
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
@@ -142,6 +143,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk NO_SPEAKERS enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT)
 		dev_info(dev, "quirk LINEOUT enabled\n");
+	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
+		dev_info(dev, "quirk LINEOUT_AS_HP2 enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
 		dev_info(dev, "quirk DIFF_MIC enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) {
@@ -287,12 +290,39 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int byt_rt5640_event_lineout(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	unsigned int gpio_ctrl3_val = RT5640_GP1_PF_OUT;
+	struct snd_soc_dai *codec_dai;
+
+	if (!(byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2))
+		return 0;
+
+	/*
+	 * On devices which use line-out as a second headphones output,
+	 * the codec's GPIO1 pin is used to enable an external HP-amp.
+	 */
+
+	codec_dai = byt_rt5640_get_codec_dai(w->dapm);
+	if (!codec_dai)
+		return -EIO;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_ctrl3_val |= RT5640_GP1_OUT_HI;
+
+	snd_soc_component_update_bits(codec_dai->component, RT5640_GPIO_CTRL3,
+		RT5640_GP1_PF_MASK | RT5640_GP1_OUT_MASK, gpio_ctrl3_val);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
-	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_LINE("Line Out", byt_rt5640_event_lineout),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			    SND_SOC_DAPM_POST_PMD),
@@ -1480,8 +1510,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		spk_type = "stereo";
 	}
 
-	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT)
-		lineout_string = " cfg-lineout:1";
+	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT) {
+		if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
+			lineout_string = " cfg-hp2:lineout";
+		else
+			lineout_string = " cfg-lineout:1";
+	}
 
 	snprintf(byt_rt5640_components, sizeof(byt_rt5640_components),
 		 "cfg-spk:%d cfg-mic:%s aif:%d%s", cfg_spk,
-- 
2.31.1

