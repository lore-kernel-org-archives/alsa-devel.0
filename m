Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B73C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 03:34:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8539564E22
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 03:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8539564E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 067F8170A;
	Thu, 11 Mar 2021 04:33:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 067F8170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615433646;
	bh=p9QBR8FF+SMYerovRtrcPflfDpdCaoqDU/Fa3N/qOys=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1RdDTZpzab7qPz5MTx4ahrrSxLVPvNFXAMvWTVtk+8VCHTNdxopM3ySq4tJv/XLp
	 aTXwb7Vr0VO/BxMILKPYEDwRJUvCIQhOUmgqGzxdru16MlnTAjEsvPFZlarvozY8HD
	 aHn82WMt1zxnFBzvKJutDq1k5uEqN2QJCwAwgRfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B12FCF802D2;
	Thu, 11 Mar 2021 04:32:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DD74F80276; Thu, 11 Mar 2021 04:32:21 +0100 (CET)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63945F8010D
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 04:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63945F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="pKhD1S53"
Received: by mail-qk1-x749.google.com with SMTP id i11so14378663qkn.21
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 19:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ta3c37NC4IC38mag1lCTgXilpT5IXIyHlWQH4EiC/iA=;
 b=pKhD1S53tPW8xEw0EjG1zY8EqSWaFA1ZGIMnppVhynZq+48BEUkcpXvmbt2f8of5fi
 TWq/YeYdJZb+7Maj234fxi0H+q3PrbBIBJWlbXwYtYveHu7XiqUOp8fwGCB8a+4oaIil
 2gtRYuyr6qiLR3KJPJ/Rw2I3rDl51xKZ0zzkau+UpSOu0aoCTyduHInerq1ezpFE/ma2
 AjSzuplJPwyxsD2wfh/bwBqsP5Rfk2oFEc2991BGcbpdiUgwB1TnI+3hgaheRJADX8+i
 roC+95ULvIHvc3vAttWclG+jjCvpZaW0vO0ioZfmcv+bRJAmbDVaDEj23jVk1ZXXTz3A
 CxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ta3c37NC4IC38mag1lCTgXilpT5IXIyHlWQH4EiC/iA=;
 b=uWiaDww3a1rD9e6jnKGMv3L9ETsoXSCmyrIS9o3aueYNkabgqyJKIAi5ffN9OPfiL5
 1OwXS207ETfePH20iT7FpdJlSw+xr9a1X9QsostbR31rtPu+ZauiijQeDywgbV/Srfms
 9GmKJc4uBLCkyz2+8nyWcxrYkxwUzMwVQ7/C3CyPQqIrp5jnALcqMgWdCSF6nG2gnm9x
 5UuBvd89PxPWGwi00tfXgQ1F6PYR8nkp9r+9+1UsV2V1JU7pxidTPNP9eVpCYlEB6r/X
 itlsBxmJu2EQMIMYMvYGzc9iYor7NrYUs8tX0RPLcioIQrVESebmB0zkTOdI6Oan2ELO
 +oWw==
X-Gm-Message-State: AOAM533Ul3tikEu0hPLTZnBSUwJ2f6SqY+6rQtP++OxEBUwWHx+WUBSc
 VSkYvxU1Zeamlb3TFba3ZTu76io3Ud5P
X-Google-Smtp-Source: ABdhPJyjG9Eti+3Jl9cxnyfQ8irNUI+/6ZL9YuaCZo7HcpU2iTmXZS+14JL16sfSy/SFI7vcw0qFLAdT3Utv
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:d958:2f3:afb:68a3])
 (user=tzungbi job=sendgmr) by 2002:ad4:4692:: with SMTP id
 bq18mr6269467qvb.0.1615433535565; Wed, 10 Mar 2021 19:32:15 -0800 (PST)
Date: Thu, 11 Mar 2021 11:31:51 +0800
In-Reply-To: <20210311033151.1818603-1-tzungbi@google.com>
Message-Id: <20210311033151.1818603-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20210311033151.1818603-1-tzungbi@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 2/2] ASoC: mediatek: mt8183: support machine driver with
 rt1015p
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
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

Supports machine driver with rt1015p ("mt8183_mt6358_ts3a227_rt1015p").
Embeds in the existing mt8183-mt6358-ts3a227-max98357.c because they
share most of the code.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/Kconfig                    |  1 +
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index effdb76369e4..74dae4332d17 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -124,6 +124,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT1015
+	select SND_SOC_RT1015P
 	select SND_SOC_BT_SCO
 	select SND_SOC_TS3A227E
 	select SND_SOC_CROS_EC_CODEC if CROS_EC
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 271413e719e3..94dcbd36c869 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -284,6 +284,11 @@ SND_SOC_DAILINK_DEFS(i2s3_rt1015,
 			   COMP_CODEC(RT1015_DEV1_NAME, RT1015_CODEC_DAI)),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
+SND_SOC_DAILINK_DEFS(i2s3_rt1015p,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("rt1015p", "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 SND_SOC_DAILINK_DEFS(i2s5,
 	DAILINK_COMP_ARRAY(COMP_CPU("I2S5")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm")),
@@ -590,6 +595,13 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_rt1015_card = {
 	.num_configs = ARRAY_SIZE(mt8183_mt6358_ts3a227_rt1015_amp_conf),
 };
 
+static struct snd_soc_card mt8183_mt6358_ts3a227_rt1015p_card = {
+	.name = "mt8183_mt6358_ts3a227_rt1015p",
+	.owner = THIS_MODULE,
+	.dai_link = mt8183_mt6358_ts3a227_dai_links,
+	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_dai_links),
+};
+
 static int
 mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 {
@@ -686,6 +698,19 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 				dai_link->platforms = i2s3_rt1015_platforms;
 				dai_link->num_platforms =
 					ARRAY_SIZE(i2s3_rt1015_platforms);
+			} else if (card == &mt8183_mt6358_ts3a227_rt1015p_card) {
+				dai_link->be_hw_params_fixup =
+					mt8183_rt1015_i2s_hw_params_fixup;
+				dai_link->ops = &mt8183_mt6358_i2s_ops;
+				dai_link->cpus = i2s3_rt1015p_cpus;
+				dai_link->num_cpus =
+					ARRAY_SIZE(i2s3_rt1015p_cpus);
+				dai_link->codecs = i2s3_rt1015p_codecs;
+				dai_link->num_codecs =
+					ARRAY_SIZE(i2s3_rt1015p_codecs);
+				dai_link->platforms = i2s3_rt1015p_platforms;
+				dai_link->num_platforms =
+					ARRAY_SIZE(i2s3_rt1015p_platforms);
 			}
 		}
 
@@ -772,6 +797,10 @@ static const struct of_device_id mt8183_mt6358_ts3a227_max98357_dt_match[] = {
 		.compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015",
 		.data = &mt8183_mt6358_ts3a227_rt1015_card,
 	},
+	{
+		.compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p",
+		.data = &mt8183_mt6358_ts3a227_rt1015p_card,
+	},
 	{}
 };
 #endif
-- 
2.31.0.rc2.261.g7f71774620-goog

