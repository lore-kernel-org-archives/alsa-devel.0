Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF5C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE24120720
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="owVhi8Mn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CNGVSJ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE24120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2540E1663;
	Fri, 10 Jul 2020 07:27:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2540E1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594358886;
	bh=P2/4doVFwZYtfy2p7HkahOZXUbpYZUR1eNTwZUSvM6o=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owVhi8MnCvPbA2j6JC4t/deYxj23OyqNX2M77KFvYJ87WO7ZObNOQoLKZo/aCplhK
	 cxmMXoMEEYQw9PvO7AgO2v0K+7lE0UShuqfoXXKOD1vARXKUq6iOo0O/rwfRPs1/Ax
	 HlZyda3PZDnbWyIN1PyayaAZL8Iq3kohRU8eennI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81491F802A0;
	Fri, 10 Jul 2020 07:25:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C33BF8015C; Fri, 10 Jul 2020 07:25:33 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74A76F80150
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 07:25:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74A76F80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CNGVSJ/w"
Received: by mail-pf1-x44a.google.com with SMTP id g85so2925268pfb.11
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2020 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Y3EnggORWF57ZGrCyAOh8m6NEpj3i0woYDKiuIiNxkM=;
 b=CNGVSJ/w2CjjKVrEYvQCv4OOefV+Hd1i3GxaKDWstjvFqwC2HnTNtl0+7zDdhc/KJm
 OE17u3CuJ5Ezxcznzbr/ocM8CDKE5N/1c/XmO48OP+zGI1YzFe2jKzZYW/TihiOhr/6h
 crnexX0iC8SQ2FS4OWLkf7MlSWjddZDZ31NDz2sGywrqCdAxvoy47S+ztfcpzr//DlOi
 Zv1oUq1obOyVQv0eqUFDa/5Nxd5xGX5h0YClMJ4MlOODK3yGRoVPrdINUb9mgdxnSSfQ
 SUmy8Yc1LWLuKfy0XzJdAlPk7L2VdwXqGx/2Ysrd4w58N+2n/8gyf5aUWAJgEigafIJM
 g7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Y3EnggORWF57ZGrCyAOh8m6NEpj3i0woYDKiuIiNxkM=;
 b=uFmtbjGSQTLsc77BDMc1BTw5fP2AcrE8abUGEJV/4+Mjf1Csw3Gma7M2qhJRbmGABi
 uC/q3dqSDAc0OCuD/OjGHmAxhb9fPKiEi8uHAh2DoSD/trwNRDPRAmfCroLOHM65Br2e
 u9AFRh1w+poD09psMZllO5frZoq4ZVxmqtK6M4zv/v7YMgcolhX4IUwU/Q4eG4K2MgYG
 smuGi6+nnDxSqjKnbeta8KtLhURZnGW2CQqUS4PrI4pZu3jM9dWHNDt2OO1Ou3YB845W
 867kg/r04pEvjV+SYYdHU/reIzLRDzzOrj9UlMG+WhQKdsk93yvF3kzN/8s79CS4s66N
 fTcA==
X-Gm-Message-State: AOAM531Y+0505PgsHeNXsZHupeggUFcP6oZDekpjl0xksBIzsrLyJLsj
 sHgw1P2FC3J4jXStOyhqxKXOdJLw4xgC
X-Google-Smtp-Source: ABdhPJx7Q4sBEZvytM2P7Fdfv06kQBXfBYR8li9S1VV5buJUiQWhcdM4KNipGKo3SyEuxPkBzRNSi0NV3qOW
X-Received: by 2002:a17:902:b287:: with SMTP id
 u7mr47682560plr.107.1594358717464; 
 Thu, 09 Jul 2020 22:25:17 -0700 (PDT)
Date: Fri, 10 Jul 2020 13:25:00 +0800
In-Reply-To: <20200710052505.3664118-1-tzungbi@google.com>
Message-Id: <20200710052505.3664118-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20200710052505.3664118-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 1/6] ASoC: dt-bindings: mt8183: add a property "mediatek,
 hdmi-codec"
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, tzungbi@google.com
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

Adds an optional property "mediatek,hdmi-codec".

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../bindings/sound/mt8183-mt6358-ts3a227-max98357.txt           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
index 5afd3d8dab84..5e455129eb96 100644
--- a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
+++ b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
@@ -9,6 +9,7 @@ Optional properties:
 - mediatek,headset-codec: the phandles of ts3a227 codecs
 - mediatek,ec-codec: the phandle of EC codecs.
                      See google,cros-ec-codec.txt for more details.
+- mediatek,hdmi-codec: the phandles of HDMI codec
 
 Example:
 
@@ -16,6 +17,7 @@ Example:
 		compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
 		mediatek,headset-codec = <&ts3a227>;
 		mediatek,ec-codec = <&ec_codec>;
+		mediatek,hdmi-codec = <&it6505dptx>;
 		mediatek,platform = <&afe>;
 	};
 
-- 
2.27.0.383.g050319c2ae-goog

