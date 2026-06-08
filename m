Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD8CD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:32:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19C766020A;
	Mon,  8 Jun 2026 13:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19C766020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918326;
	bh=W6Gy9zePv+DPxmrsDzBshc5EdBqIbiCaTZjrepBuz7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V9ZbTD3XcGCVjPkVLmZPqNswPJZLNbQfrlTTam1PQHUvgz1Fc0Vws0wrPJVZw4E2P
	 7ap5IIPwWXw1/st0Ii6cOBDQb9FhP5EwDAEOfKZ8sOAaDZuXkrhh2LMSBHZ29zSLD3
	 UigV08PvZMOtXF61gua8MttFN+HFcxKsT8hj0JGw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BF74F806C0; Mon,  8 Jun 2026 13:30:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AE9DF806C1;
	Mon,  8 Jun 2026 13:30:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07727F804F3; Mon,  8 Jun 2026 10:35:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=61.135.153.176
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907755;
	b=INXPOqQyy2bBn2Hm3l/w3ooiu7dUouTbIJoCljNzE2VpdysaYloGHisdjr3f20mDPwb6
	 4v0eXyJLkK68NQ47W5OIn2BXq3C+qxHolsxDjXxKOw5G+BODl/wPQjATBJV5ShLBVVllZ
	 +Q11sra7LWEXkTmxYyuY2R0DmmFbXEdkJZ6Fsyr24LqrK0QSoWv4GS65xc37u6v2ZjMiX
	 ErERE3ywVj79CBOmb/4NieZIPfYQ8kay1LuDz4Y7n2XHBKNQOIYYq68avsu78dJwmhhbX
	 EUhyHXD9La+1JiEPCv1rQxgF01Clcjmmyf5ZwPC7LdaJESjCkADUwu2pClPxGcxT88A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907755;
	h=From:To:Subject:Date:Message-Id;
	bh=W6Gy9zePv+DPxmrsDzBshc5EdBqIbiCaTZjrepBuz7Y=;
	b=rlMRpsieO6dG9SbWV5uaXoV5DVYUsXMibN0IDMy7oeN0X40lNtB4PTO6eC5HLolae+xf
	 cU7Y+WR8uHJvsbwqOYeiB4LGH/cafCjKu0hBlxZtbLW+34yY3eY4YGJpdhWi/QSIRfijW
	 nF1toLMI1/OwqOuJYZkkaj2JZF0rZORibStuup+tRHCCrLSKlEWDzhs2IMV7jL8buVfxV
	 QQW0soji6ggJM9H0WhMW49bvRehYP2tlMir2r6klEjT/7qtLZ2jkoBLqwSBQbYF659AL0
	 ZU/S1g6bzYiTIFKADXBLTH/VdVj8zUNTZP5MkvjOYjjhoI09PoplNDbBDFV664BRFPQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=61.135.153.176
Received: from smtp153-176.sina.com.cn (smtp153-176.sina.com.cn
 [61.135.153.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A8F17F8055B
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8F17F8055B
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:50 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: D5A3667696AC461CAFF89E5CC4B8069E
X-SMAIL-UIID: D5A3667696AC461CAFF89E5CC4B8069E-20260608-163550
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 6/7] ASoC: codecs: ES8389: Add INPUTL MUX and INPUTR MUX
Date: Mon,  8 Jun 2026 16:35:39 +0800
Message-Id: <20260608083540.12581-7-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7TW72XUIUII742XQZ4ZHH2OINVWGH3YQ
X-Message-ID-Hash: 7TW72XUIUII742XQZ4ZHH2OINVWGH3YQ
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7TW72XUIUII742XQZ4ZHH2OINVWGH3YQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Add INPUTL MUX and INPUTR MUX in route

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 743cfca2a6ab..8922fc990096 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -164,6 +164,16 @@ static const struct soc_enum alc_ramprate =
 static const struct soc_enum alc_winsize =
 	SOC_ENUM_SINGLE(ES8389_ALC_CTL, 0, 16, winsize);
 
+static const char *const es8389_adcl_mux_txt[] = {
+	"Normal",
+	"ADC2 channel to ADC1 channel",
+};
+
+static const char *const es8389_adcr_mux_txt[] = {
+	"Normal",
+	"ADC1 channel to ADC2 channel",
+};
+
 static const char *const es8389_outl_mux_txt[] = {
 	"Normal",
 	"DAC2 channel to DAC1 channel",
@@ -191,6 +201,20 @@ static const unsigned int es8389_pga_values[] = {
 	1, 5, 6
 };
 
+static const struct soc_enum es8389_adcl_mux_enum =
+	SOC_ENUM_SINGLE(ES8389_ADC_MODE, 5,
+			ARRAY_SIZE(es8389_adcl_mux_txt), es8389_adcl_mux_txt);
+
+static const struct snd_kcontrol_new es8389_adcl_mux_controls =
+	SOC_DAPM_ENUM("INPUTL MUX", es8389_adcl_mux_enum);
+
+static const struct soc_enum es8389_adcr_mux_enum =
+	SOC_ENUM_SINGLE(ES8389_ADC_MODE, 4,
+			ARRAY_SIZE(es8389_adcr_mux_txt), es8389_adcr_mux_txt);
+
+static const struct snd_kcontrol_new es8389_adcr_mux_controls =
+	SOC_DAPM_ENUM("INPUTR MUX", es8389_adcr_mux_enum);
+
 static const struct soc_enum es8389_outl_mux_enum =
 	SOC_ENUM_SINGLE(ES8389_DAC_MIX, 5,
 			ARRAY_SIZE(es8389_outl_mux_txt), es8389_outl_mux_txt);
@@ -319,6 +343,8 @@ static const struct snd_soc_dapm_widget es8389_dapm_widgets[] = {
 			   &es8389_adc_mixer_controls[0],
 			   ARRAY_SIZE(es8389_adc_mixer_controls)),
 	SND_SOC_DAPM_MUX("ADC MUX", SND_SOC_NOPM, 0, 0, &es8389_dmic_mux_controls),
+	SND_SOC_DAPM_MUX("INPUTL MUX", SND_SOC_NOPM, 0, 0, &es8389_adcl_mux_controls),
+	SND_SOC_DAPM_MUX("INPUTR MUX", SND_SOC_NOPM, 0, 0, &es8389_adcr_mux_controls),
 
 	SND_SOC_DAPM_MUX("OUTL MUX", SND_SOC_NOPM, 0, 0, &es8389_outl_mux_controls),
 	SND_SOC_DAPM_MUX("OUTR MUX", SND_SOC_NOPM, 0, 0, &es8389_outr_mux_controls),
@@ -332,10 +358,15 @@ static const struct snd_soc_dapm_route es8389_dapm_routes[] = {
 	{"ADCL", NULL, "PGAL"},
 	{"ADCR", NULL, "PGAR"},
 
+	{"INPUTL MUX", "Normal", "ADCL"},
+	{"INPUTL MUX", "ADC2 channel to ADC1 channel", "ADCR"},
+	{"INPUTR MUX", "Normal", "ADCR"},
+	{"INPUTR MUX", "ADC1 channel to ADC2 channel", "ADCL"},
+
 	{"ADC Mixer", "DACL ADCL Mixer", "DACL"},
 	{"ADC Mixer", "DACR ADCR Mixer", "DACR"},
-	{"ADC Mixer", NULL, "ADCL"},
-	{"ADC Mixer", NULL, "ADCR"},
+	{"ADC Mixer", NULL, "INPUTL MUX"},
+	{"ADC Mixer", NULL, "INPUTR MUX"},
 
 	{"ADC MUX", "AMIC", "ADC Mixer"},
 	{"ADC MUX", "DMIC", "DMIC"},
-- 
2.54.0.windows.1

