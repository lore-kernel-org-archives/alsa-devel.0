Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94AEC4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:36:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC230206BE
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f/Ftszl2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXN0SmqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC230206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E31831885;
	Fri, 25 Sep 2020 18:36:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E31831885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601051815;
	bh=plHtH+v8QHkwQK6+KlTjSRBtXt3QxWXVn0MTJPzPmXc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f/Ftszl2+Q/NiyOPueh0xemNJ3rnOakH6PN+hYeT1BvOmXV5tk17RY6wngc2G2RaD
	 AU4dhn/edUcs9DBNSIkqq1O1kNKQpp0fELMPZZHyrj5jUWXdg3ov1EEKsunJuFFhvZ
	 qpv9yjYLBEY3Mt0xuLvu7/q9ez0XuFJrIw39ZiMg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68DE1F801EB;
	Fri, 25 Sep 2020 18:36:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE723F801EB; Fri, 25 Sep 2020 18:36:01 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9362F80162
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 18:35:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9362F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="QXN0SmqS"
Received: by mail-wm1-x343.google.com with SMTP id e11so2251708wme.0
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rmounVMbkghHgQw2uLZEbV9nHVzbf0HPhUzVBFiceS8=;
 b=QXN0SmqSBLpJhF4hEknAPQ8enuiO8VPjiS9tRN9ap8b0aNsnIQWw3AhnnoAdsBdu0x
 2fymvW2WlHnWBNg0KykMkwPIRAGEdKGoroMfJ4P97tWY4og9k7YvybCGsaHL8g3w0UC3
 m3YeLXrjZAIHJ0Yr1aiY4YNjBOXyC2dN15/kjAfScHxlM5qy3Ovt4Agu8M3xM8me/TGA
 GllxG2ldZJ7UGrAsza6vVtW25uCYOYo2RvZHmnl3Zc6aFCWc0XH2pYgsgo/T/36pUSFu
 hxZFuJ/2B4W/xZDG3Ux52ZQfC0anhTeDCroW8GkbHU9SrKwYGW4jDldJkzPD5D3Ik6CA
 /O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rmounVMbkghHgQw2uLZEbV9nHVzbf0HPhUzVBFiceS8=;
 b=ODnDFpxLdpIhFXWQoBvashZO4BPUcjnuFzlSNhSb0DhMASf2YKtHUcaKCrkH3ATA6u
 1wBiACxEh6lZ172FQRocA0dTxARhJZ5GUNCe0JdT7NLdi57tyWu9zF3DZl9iCTVaFy3U
 bLC3z6b1LA8LfzmDHRzyOjeexAGXkr3bVne+4tQgOMPiUcVk3jzrNSsS8sZPYpLqoVbA
 VIV2Go3QJk3C6RVlKUqJHnBom8zeT7uqIeiqqLaAR6IXdyBPm8kXgmA6qJ/zlSeIgB4r
 OIrURbZ0n9EbRy6aSeqApqqs38iol/yjaDDCFJcs+vchEKYPGUzzf71R6sjkyuw63uXR
 aj0A==
X-Gm-Message-State: AOAM533pgBuY2zHFRgixIEiomdqaor+MRynSfdny3T1F89/XTuqMBzo4
 pz3NA/pjRlvRC4cs+2h3R83KCw==
X-Google-Smtp-Source: ABdhPJxAXyw/Uff+CZFsPVEwnxt5gil9qvEfqgid+fiQzJHexwNZxXuvWrEkPU+tiETs5WCKuWMbdQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3968205wml.176.1601051755421; 
 Fri, 25 Sep 2020 09:35:55 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m4sm3733883wro.18.2020.09.25.09.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:35:54 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 0/2] ASoC: qdsp6: fix some warnings when build without
 CONFIG_OF
Date: Fri, 25 Sep 2020 17:35:50 +0100
Message-Id: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
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

Here are fixes for two warnings types discovered while building qdsp6 drivers
without CONFIG_OF and with W=1

One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
equally applies to rest of the qdsp6 drivers.

changes since v1:
	- added ifdef CONFIG_OF instead of removing of_match_ptr

Srinivas Kandagatla (2):
  ASoC: qdsp6: add ifdef CONFIG_OF around of_device_id
  ASoC: q6asm: fix kernel doc warnings

 sound/soc/qcom/qdsp6/q6adm.c        | 2 ++
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6afe.c        | 2 ++
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6asm.c        | 6 ++++++
 sound/soc/qcom/qdsp6/q6core.c       | 2 ++
 sound/soc/qcom/qdsp6/q6routing.c    | 2 ++
 8 files changed, 20 insertions(+)

-- 
2.21.0

