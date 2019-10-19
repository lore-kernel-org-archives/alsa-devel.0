Return-Path: <SRS0=7dhW=YM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A1CA9EAC
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Oct 2019 07:06:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC12520872
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Oct 2019 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j13ZYr4T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Zj28yV8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC12520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 132001672;
	Sat, 19 Oct 2019 09:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 132001672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571468806;
	bh=cqnSHhKuI7UPwhr1YI28I6hqZxOIAlVpQFcNrwSkgKc=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j13ZYr4Tcyh6ihM+JfyY/NsZk5n+5hkDLTYe5XTE2soI13CpjdAwVQQhdwUGhodAc
	 R8c42brVTKBbL0/8HQAc56gsBqVycn+uItJ79y2m9fMyqOAoWqvi+F19aOfWj1cOpG
	 NgdHLPSirY8jUZaX+tz0NZ0a+vZFP0fl2QvSjT9M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84079F80635;
	Sat, 19 Oct 2019 09:03:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 480AAF8063A; Sat, 19 Oct 2019 09:03:29 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D30C7F80635
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2019 09:03:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D30C7F80635
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Zj28yV8M"
Received: by mail-pf1-x44a.google.com with SMTP id b17so6356516pfo.23
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2019 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jlOtWXCNhHtlDG+k17B3fk8K3J30slAGte+uW0UmF+E=;
 b=Zj28yV8MdULZozKF/ciYqHOiJNUsZuYg6lzBq/c7cRDga/k0ZyF94c3VRnllYQzJFN
 WvooI71td9MPxNhl0g++L3A1QdERbBBpet5NvI30B7vkdpVEy/nfXMWuVvrjgRFYGia+
 wv8n437eF9DwM6eG5+cn/fWxfSH7hGmYmYt9zzFc+bfO37Cor3XbweS8a5wOm/sBr3/c
 8ia0J85/f6knnD3ReK3N2qSqHyfh/+6xlqd5ko1TpsHtv2PDXHT9VUw4RWuo5FCrkFWR
 QPi0YY/zRUM2eONtUgKQnuclfMlqIaXJeCb6uvdS1WLNQL4vvdSpA2Lsj1kuwGMYmDFP
 aMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jlOtWXCNhHtlDG+k17B3fk8K3J30slAGte+uW0UmF+E=;
 b=gMYYiBRjNQrlwVHzGBtsPQNkUjUp8Sd7LXW0quVg9ABAXQDF5G1+RAqWIjfQBtGV6z
 FgTeilmUUjsWL0BRm+h5z5EqbOdiv0aVE/3m90RVsFH+CxFEqpp1w+bPRzBgccQ/T1Ul
 58iVQf3XM4BhKFswAstz710qg3Makqslan1SGJ/QIPKjNWLGmZ9v/OF9Hnc0tKvojLnA
 2XRG1v8UusYor2TnE6Npws12G5lXOeJFcOahrTHVFdqNybO7a8gUUG8ic0QVcN92dN3Q
 WzpSJWg3wF8taPhzOXjiIeNUZfXAL/En5ZQ9kRZ1MMLdASdVUXsPh1GZejUJqDZx87zO
 ihig==
X-Gm-Message-State: APjAAAWmctTuFpA215FS7rHcZxw7Ymy+cs/KBOTmsZqJHf+2N7P9m568
 adiabYaiRWlW7GoMjSDMnGl6r9XKUz7Z
X-Google-Smtp-Source: APXvYqx3MAr9bPPwbRL5AclIQKxFR+7nucK3CkegVw1UL1Ev5Bs31ronYhQEQ5GPP5Uoceu3Rg3QMDMUu9wx
X-Received: by 2002:a63:f810:: with SMTP id n16mr14032502pgh.176.1571468604085; 
 Sat, 19 Oct 2019 00:03:24 -0700 (PDT)
Date: Sat, 19 Oct 2019 15:02:53 +0800
In-Reply-To: <20191019070254.23870-1-tzungbi@google.com>
Message-Id: <20191019143504.3.Iec97a3f137148cdf316056612590b3e0b302f5f3@changeid>
Mime-Version: 1.0
References: <20191019070254.23870-1-tzungbi@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, tzungbi@google.com,
 robh+dt@kernel.org, enric.balletbo@collabora.com, bleung@google.com,
 dgreid@google.com, Rob Herring <robh@kernel.org>
Subject: [alsa-devel] [PATCH v5 3/4] ASoC: dt-bindings: mt8183: add ec-codec
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add an optional property "ec-codec".  If specified, mt8183 could use the
"wake on voice" feature offered by EC codec.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../bindings/sound/mt8183-mt6358-ts3a227-max98357.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
index 17ff3892f439..decaa013a07e 100644
--- a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
+++ b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
@@ -6,12 +6,15 @@ Required properties:
 
 Optional properties:
 - mediatek,headset-codec: the phandles of ts3a227 codecs
+- mediatek,ec-codec: the phandle of EC codecs.
+                     See google,cros-ec-codec.txt for more details.
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
 		mediatek,headset-codec = <&ts3a227>;
+		mediatek,ec-codec = <&ec_codec>;
 		mediatek,platform = <&afe>;
 	};
 
-- 
2.23.0.866.gb869b98d4c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
