Return-Path: <SRS0=ORgw=FU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD2C4361B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 04:19:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9182F23118
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 04:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9182F23118
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B02217EB;
	Wed, 16 Dec 2020 05:18:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B02217EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608092369;
	bh=F5Xzk5mQozb0A8QUb/M2IEu81FfRFk9eL6/JW9OQjic=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j6JmqLR67nErwQf930SNAVBfRXBJzI/E9wd/lusQw0hw/8d6a23TSFvQU6rT5Pwfc
	 PADCFJD6dCjMBf4ryxyMFu5V5bfY1DfLW2Zjy8DiYCKeMKZZ9yjJZHgjw/oS2xhhnw
	 WR7SAmQsBzbc9HMnbrfx+8Y8ZOELd4HpD/WUEK40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD62FF80168;
	Wed, 16 Dec 2020 05:18:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11A70F801F7; Wed, 16 Dec 2020 05:18:34 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0B5CF80168
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 05:18:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0B5CF80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="IaQ61Wqq"
Received: by mail-pl1-x644.google.com with SMTP id 4so12213580plk.5
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 20:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IQRIGP+PG0ZGJkN4c+NOuc/o2U0jNbHtsQVJKi1bUrA=;
 b=IaQ61WqqgZR/LZ5nzcnqn65kMZT/iS1vgHrAtwE8ZwXmgbY9wNxV619VptREtFKSZc
 apIe9BOoBBRAdXEqsw38cCXAmZooQxG3P6xADa/euQaVI5mtKueBdc7E+pl4yiS698ES
 yBq74qWOadPpsi6UIr0QZxtFnKOvwwwXdR8qFONAxnZuz5JiMBNEvspOA0rFzfh/zU9Z
 fcsszAHXXXzhvY4imvOTJnDY0xW8drcPA0/wnWtoZTmJKwZ3tSYt1pfpMZyv+QMkuhOe
 tBy22Wp0dF3hE4LIaE3ld/WlVaqE0boAV99jgdT1bxVJ1DdUpGKAkiGaz2VkroT6zr1E
 LUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IQRIGP+PG0ZGJkN4c+NOuc/o2U0jNbHtsQVJKi1bUrA=;
 b=g5kerjuwus2HGFxuH/cV90ZOofvEQEbwv+ms5CZUfuTAR8ON4s+vo9iqQCEkmub3LF
 ZlnSrAb2Xos/l07N/PrCFy0llWn5zuzl5ntaz5/I1WJxAqrmW/jZ/vRjaj+cI7g7wrfA
 2fw3rLncbSq8QBXK1jil05M8Il3A5X0h4+JQW6MxA5cIqJ/BnAi27lHnQx/xSQS/BD8m
 zIxOXN+ZdSh7RIk1d0XCTfl8FZ5dfCFeraN8eGVkcIl6c9AoHyB4ExhvkA/JKWKCFDZN
 cMLvyag7ynUDi1cDAHObPuz/EErJLBlG7U8xrWXW3hw7IHi3wyGiCE+ESR12QSecF6y8
 XfHA==
X-Gm-Message-State: AOAM533TRH2MeKoqM0qISSBqXYsE07roywq7uAyGl3Pxw5n5NaoRMsV4
 s1Zrev5/+NX/fLiYK0htkGsv4g==
X-Google-Smtp-Source: ABdhPJywXM77ofwOhEKYkaEuA6j1U7P/GCEIQi4ZkFGZ+MZBzU+URw8DsUa7qttMpW/CqoWuOipkIA==
X-Received: by 2002:a17:902:850c:b029:da:e4a6:3641 with SMTP id
 bj12-20020a170902850cb02900dae4a63641mr920477plb.57.1608092300343; 
 Tue, 15 Dec 2020 20:18:20 -0800 (PST)
Received: from localhost.localdomain (111-240-118-79.dynamic-ip.hinet.net.
 [111.240.118.79])
 by smtp.googlemail.com with ESMTPSA id 37sm442703pjz.41.2020.12.15.20.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 20:18:19 -0800 (PST)
From: Chris Chiu <chiu@endlessos.org>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 yang.jie@linux.intel.com
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
Date: Wed, 16 Dec 2020 12:16:01 +0800
Message-Id: <20201216041601.5993-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Chris Chiu <chiu@endlessos.org>,
 linux-kernel@vger.kernel.org, linux@endlessos.org
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

DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
quirks to select the correct input map, jack-detect options to enable
jack sensing and internal/headset microphones.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 688b5e0a49e3..9df09e26b05a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_SSP0_AIF1 |
 					BYT_RT5651_MONO_SPEAKER),
 	},
+	{
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
+		},
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
+	},
 	{}
 };
 
-- 
2.20.1

