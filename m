Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F484C432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:47:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B7220721
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UXCtVqdy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agg5pZrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B7220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EF9F1868;
	Fri, 22 Nov 2019 22:47:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EF9F1868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574459277;
	bh=XtELjYunLUOptI0BvHLDBC9JeRD1xUVmUH2TI/4rEOY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXCtVqdyqyrWF64bvhiXLs6ttLiBM9ScyzAZoPgcD/NCDPFrgNtHrGVNMdbE7SW3x
	 SAALDJRwJ3Erqgh1HKzGuHPd489q2CZwiWtpd/ognumdEx110LosxDPtjWbSlE6obD
	 jQ7/wU5mD8pRZMG+0Mh5+Q9EqvgMJXk4IHYdA8AY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 627A2F801EC;
	Fri, 22 Nov 2019 22:44:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70C78F8015A; Fri, 22 Nov 2019 22:44:12 +0100 (CET)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB21BF8014A
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 22:44:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB21BF8014A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="agg5pZrS"
Received: by mail-yw1-xc44.google.com with SMTP id m196so2948166ywd.5
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=agg5pZrSlcJgWUKMUO9YgPvy3DMz7lk+8H61AuEseYg69n9R427w3WJdUiT5ihflAZ
 aEHhZ3Kk/DzjXnEIHubHfFgchBRaYLESD8u4MAWvvR1D1IhxAJcyD6J3IVlyq7T6OG/Y
 HL0z7c+zAk8JgpYUyL02wfA0ndAuZ6SeXs6jGIA7hAfhMtbljpElVtip+EjefdZIWtWk
 AyCckcCDAH1w0cb9sz5zqvpGLz5VRtaEHhqGC7gKmQU12xDc9Uhdy90q19PyDTfDAjMz
 0/B3YnQSia7BRP3TKKVrzC0cpFf+VQvHUBIU9bUKHmHaWrPly4yijwQ34qU62WO1yG/y
 G5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=ecMxMXcZnJiswsPkaX9DzNU4aNjkRnW8bNL4fmkA88JHE9rEGjezLwmSLAkjweY8Z6
 CLhVFxqa3t6minRhhkWDv0vsYAQzOBsSL7CyYVoKWM1PafKjvk6uo8e14H2WemSSA5X9
 wMtAcxeXaA7ujDHCsOU37Mx5UbSiPsNS1rkK4OZ/sI1D16IR8xtS3YYnL0YCq4ZMeEzn
 nvaSXjucIQB0IXX61yTCiNjOxoUzOPZ3P3SGpSi2fTCKmBO0opZmu7MyNg/Vgqc4Rnk5
 IYXulqqIvupjhI7dOQHzCAiM+9NLVCzAAijo2B28IGljZH4eNz4oLVvBW9oIRlKAT647
 79dQ==
X-Gm-Message-State: APjAAAXp7gUVCTowuvS8dx3VVn5lKEmCumWnhMhcJLJCF+Zacofqg90g
 AezYNI/YKK8q9jW+Rmb27vU=
X-Google-Smtp-Source: APXvYqwA3Yic3yjGiXJeV9UndcS0Q4L8RqTFvnw5cbDHTe+9NPKTOJCzm1LenWZATmekFOjxvrwydQ==
X-Received: by 2002:a81:f005:: with SMTP id p5mr11474085ywm.147.1574459045432; 
 Fri, 22 Nov 2019 13:44:05 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Date: Fri, 22 Nov 2019 16:43:53 -0500
Message-Id: <20191122214353.582899-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122214353.582899-1-alexander.deucher@amd.com>
References: <20191122214353.582899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 4/4] ALSA: hda/hdmi - enable automatic runtime
	pm for AMD HDMI codecs by default
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

So that we can power down the GPU and audio to save power.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 795cbda32cbb..8785fcc850b9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3961,6 +3961,7 @@ static int atihdmi_init(struct hda_codec *codec)
 					    ATI_VERB_SET_MULTICHANNEL_MODE,
 					    ATI_MULTICHANNEL_MODE_SINGLE);
 	}
+	codec->auto_runtime_pm = 1;
 
 	return 0;
 }
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
