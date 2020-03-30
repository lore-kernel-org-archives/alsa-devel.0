Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219EAC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:44:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F9D20757
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f66un4kD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A66f6X8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F9D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F47A1674;
	Mon, 30 Mar 2020 22:44:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F47A1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585601093;
	bh=cA27puQRFgBTKbojz7exIJnEkulsBuEkNT7iyHXs+14=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f66un4kDvTewU/3bIXeZHcmw9zT2OPEuIIE+7RkqB8ZmOlED4SzwbALX0PcqqeqTm
	 iNZ5hfAc202fWCpryWD/96ZW+SO4D9v9iPAiek9i3XCucILvm89KCIxKdtmxo1Ra72
	 xiREdz5vbAQVZ881LQK/8tFrZ+6qPAIX1ehqHUMg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 252C9F8028C;
	Mon, 30 Mar 2020 22:43:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 616C5F800EB; Mon, 30 Mar 2020 22:42:56 +0200 (CEST)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E2E5F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 22:42:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E2E5F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="A66f6X8l"
Received: by mail-lj1-x244.google.com with SMTP id f20so19671041ljm.0
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9dmJd31XEhMYenYHGxi8YuYhFyxM6XMQHq+VN0FDTA=;
 b=A66f6X8lQNBIne5NO0ntEAJDEDYnNwBIz73Tdrfxf3GiMPg1AB2mXl5GB40UwzKxa7
 bZWbkxfhEKJpGG7P6OLuY8UDztGFJ/JfZAhT0FyWHnr0Ht25MLHgspwJV+wnfrWFq46j
 MpcbwYhUJXs1pWmyeW/AdT2yPjCpymvJanazaVokahWPFoh1bXLTDU6pZCuWIwNIPdYP
 v4gflHBdWxYiKfeBsyBVtAg+5+eRX7zlIclt7vDgnJCYz+VAJb4JjmgZ+2Mcc74Vd0dp
 i8Mye5k72gPGFnijorIDp3Q66t2tLmlSuSkElwpdzQ51T+ypjl+8FVNHzdHj8xucT4mj
 Xt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9dmJd31XEhMYenYHGxi8YuYhFyxM6XMQHq+VN0FDTA=;
 b=VE0+o0/tniTs6kj9HxUB9XqBonhbKKhDxROO8pKwdqr2N+i25tnCWh/q3xR5HKNSKM
 hVysov/fCXt+cc/p0SDwfa6dFjdalXBatXPR/s5pbTsJWii4X6pZz20XzanjxklmLHOW
 EtmrXDVxEhIRSlvaJI20hGpvlp8fAEOKnWbIDizjxWu/cyIXahLlFuV+mudDUNWLdTMw
 w5C1GDqcDsjPpKqqKT5HBYgiotcz3z/942zffkRH68kBjNLpnzGDOuWsPCqupJmVAnkd
 XRjFCFhu9QL51h6XjbKRsK+V97qjHZ+mbsvkUEQ3cr/zZeoItYfr/53E4zmKny3GMvBl
 g5mA==
X-Gm-Message-State: AGi0PuZJsHeH7LuP4RlGDiOUIQYxXZEECqP+yqNZ3OKsIpYe1dh8s5dB
 6kSLP9i1a5nhRoXvTq5Bc+g=
X-Google-Smtp-Source: APiQypJfqcBA7TyhBQLhNFsjLxFmFe3JYTbJlcU1IjgTFoLg6D02DeJMCMcDI1MOWqZjd6xZNkUSsw==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr8112416ljh.28.1585600964401;
 Mon, 30 Mar 2020 13:42:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru.
 [91.78.208.152])
 by smtp.gmail.com with ESMTPSA id v22sm7287988ljj.67.2020.03.30.13.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 13:42:43 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document new nvidia,
 headset property
Date: Mon, 30 Mar 2020 23:40:10 +0300
Message-Id: <20200330204011.18465-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330204011.18465-1-digetx@gmail.com>
References: <20200330204011.18465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Some devices have a 4-pin headset jack instead of 3-pin microphone jack.
The new boolean nvidia,headset property tells that the Mic Jack represents
the state of a headset microphone. This additional hardware description is
needed because microphone detection procedure differs in a case of a 4-pin
jack from a 3-pin jack.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index a8f2b0c56c79..bbd581a8c5bc 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -29,6 +29,7 @@ Optional properties:
 - nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
 - nvidia,int-mic-en-gpios : The GPIO that enables the internal microphone
 - nvidia,ext-mic-en-gpios : The GPIO that enables the external microphone
+- nvidia,headset : The Mic Jack represents state of the headset microphone pin
 
 Example:
 
-- 
2.25.1

