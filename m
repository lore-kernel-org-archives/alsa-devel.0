Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8693C3600E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:11:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA12660194;
	Wed, 26 Mar 2025 10:11:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA12660194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742980316;
	bh=xdUAEPlkjdFnId0CwibWv0kfo4J1OSdEA+5uuQwXCdI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qvhtIhofyuU2pdWVXpsp/LXw/KkA9EkDpoQH3wQ1k/k26zCxd62NOTdr/9n081Xdr
	 Ow8r0uYhZmTdVWmRPAKekXHuK5V+3K/PXW/dH6THm3KWtkkETGei5A1RYWTVppsGcx
	 6ruM++yRuKm2R5yfNhkYdUS6EGpaxTmThdl8RY3s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 956AFF805B4; Wed, 26 Mar 2025 10:11:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F032F805C3;
	Wed, 26 Mar 2025 10:11:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3A61F80424; Tue, 25 Mar 2025 22:16:04 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 12992F800D0
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2025 22:16:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12992F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=lmGisFaR
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c5e39d1e0eso56002385a.1
        for <alsa-devel@alsa-project.org>;
 Tue, 25 Mar 2025 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742937361; x=1743542161;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40K5pq7mYVh4VrEl8AnjijJbn+gIm8U/aSBOA3s0pZQ=;
        b=lmGisFaR3QC6k5BTEUMknFnXJyaojarEPvNheGFGTqLYhVEXgVQ+X5o/9y6ZNW4i2h
         Fd6wchU12Kd6blQNbXx9DckDvz+uJN/1fNUYj7Q6/fTMFgahXTU1hxvrpiKO0fW4DAH7
         0QswErD91riJJ5R/6XASFoxKm5pIBNziFmVYULQJcU62OCp8Kk5Wa3u6Rrp+SPeXrolh
         jCrBF8XeXVH6qLVsvzGDtTVUdI33tKw2aHA0MRUetN8oImfoTnyM8Hsksxw+RYYQyDK5
         8UMQgDfoEJKeDBo8gYAx49kISphxBkjv+byvRyIMw+b1okdPS/pv3a4CsvEQEronspFA
         3U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742937361; x=1743542161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40K5pq7mYVh4VrEl8AnjijJbn+gIm8U/aSBOA3s0pZQ=;
        b=soceO8eFT8Rvm+3FC2LJ7cAggqyevJJaaiVZI5/0bl2s/PEouc2VvU5UxXlWIocYQZ
         8BaWiHaHrQ1Tv89vD6qpyka7yWDz81i8v44hoAVfrVtJQ4UgnFombOaZaMYD31B5ADsz
         V+SRMNPkRE8dvuKWAbXaJ6hxDfblNfX7w+MU58xAHJ3vAkxeaSe+5McHfQMiaZkt3UaS
         9XoB/sKYEtXz/Z10PLMPsZBAOua9KcqINZeXc1U2BOSU9sGiniKrCXsjm++w90No/3HX
         ZkKOnkcoVjG2Q5eKbAkOVocibGZevy26hYro04roNMSQlwLWqXAWFZvi5o+nzFCPtYwD
         fv6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXajq0yYxZMwmSXkPkuETqx1+hBtflAPrUNsfYHpHLULeSDZC1+Rk2iSp/UBvzKdf3KO9MskqFVbmU0@alsa-project.org
X-Gm-Message-State: AOJu0YzJyMVF+5pG6adqbVcoPWx+QRTf+n7UlH5+fJK1CTvuq4xEp7XI
	8orX/KOSNVMQmG8HK+GoIQFJOS01sRO3rj1ZrtwOmc87RsTbkRPb
X-Gm-Gg: ASbGncsZiEqtD+afttIULHVS9Bxw+M7JVim+2krQXsN08zf7oRt9ySJdhEiOH+/XQEP
	0Hj9hbUaILZ47xzAv8+Przew/zs4kDsRNt/s7TvkihXUuEp28RmqR1zOswvuP1Exq2b38U4q60y
	gVm6iXOVLCaBLZJgdpLXuA8YL9Kz97SI+wyDrjLMghS+14e+3aytOM6FpdQ/YFXf/byWvlR2/I2
	R3rwkTwdNAvpFFhfUBtcnzTPqRpSS+o7vg9tCv3XfPlGUU/wbyp17SVyfRWBrQwXsGEmTPZUqVo
	kbWynfSmx4PbnvD5UKBjRKsX95eyI+ildjj8v72VLHi3DVg5HD4buQnvcHeYiCkEpnwOJvhQYUq
	U90DetYOHStFzNLq4vDM=
X-Google-Smtp-Source: 
 AGHT+IHZN0DvqR3zf6bcLPm5iIDPZ4bv5imEYKlo5WLdo3X0XPq9mZKrg6GEYfXA8J0c5SD86F7baA==
X-Received: by 2002:ad4:5d42:0:b0:6d8:b115:76a6 with SMTP id
 6a1803df08f44-6eb3f1a7037mr239109526d6.0.1742937360994;
        Tue, 25 Mar 2025 14:16:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-55-107-1.hsd1.mi.comcast.net.
 [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3efc5944sm59648256d6.75.2025.03.25.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:16:00 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH 2/3] ASoC: amd: use new ACP dev names for DAI links
Date: Tue, 25 Mar 2025 17:15:45 -0400
Message-ID: <20250325211545.2099169-1-bradynorander@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: bradynorander@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3I5WIDGTJ2QGQQGN7SJXAHRYLRC7M5OH
X-Message-ID-Hash: 3I5WIDGTJ2QGQQGN7SJXAHRYLRC7M5OH
X-Mailman-Approved-At: Wed, 26 Mar 2025 09:11:31 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3I5WIDGTJ2QGQQGN7SJXAHRYLRC7M5OH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The old names used automatic platform device ids, which means they could
change. Use the new device names which will never change.

Depends on patch: drm/amdgpu: use static ids for ACP platform devs [1]

[1] https://lore.kernel.org/all/20250325210517.2097188-1-bradynorander@gmail.com/

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 8 ++++----
 sound/soc/amd/acp-es8336.c           | 4 ++--
 sound/soc/amd/acp-rt5645.c           | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 02b04f355ca6..42aa009c4e13 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -517,11 +517,11 @@ static const struct snd_soc_ops cz_rt5682_dmic1_cap_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(designware2,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2")));
 SND_SOC_DAILINK_DEF(designware3,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.3.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.3")));
 
 SND_SOC_DAILINK_DEF(dlgs,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-DLGS7219:00", "da7219-hifi")));
@@ -533,7 +533,7 @@ SND_SOC_DAILINK_DEF(adau,
 	DAILINK_COMP_ARRAY(COMP_CODEC("ADAU7002:00", "adau7002-hifi")));
 
 SND_SOC_DAILINK_DEF(platform,
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index 0193b3eae7a6..b16dde0e2987 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -137,11 +137,11 @@ static const struct snd_soc_ops st_es8336_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-		    DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+		    DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(codec,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ESSX8336:00", "ES8316 HiFi")));
 SND_SOC_DAILINK_DEF(platform,
-		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.1.auto")));
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link st_dai_es8336[] = {
 	{
diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index 72ddad24dbda..11d373169380 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -108,15 +108,15 @@ static const struct snd_soc_ops cz_aif1_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(designware2,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2")));
 
 SND_SOC_DAILINK_DEF(codec,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5650:00", "rt5645-aif1")));
 
 SND_SOC_DAILINK_DEF(platform,
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link cz_dai_rt5650[] = {
 	{
-- 
2.49.0

