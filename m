Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CC6C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 17:33:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED54D64E05
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 17:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED54D64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E636B1654;
	Fri, 29 Jan 2021 18:33:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E636B1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611941634;
	bh=HhHHWvWMn31ZnD0zFrN+PhrzQGUCfMDcdsOIHQ/Yv9c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aKSSF5hXsahDydjIR+xCo1yWb+AWo5y0X1Uo/I0nqRw9pLElL+DCpfNU/KEswtC4d
	 1BJEmUTSnR4vgN+NbYtM5mkssEsHOxOsmmrkHx0veCXTYQjYN1fXTZDNiJV63AC6MF
	 5flqln6sb0H/5VcT2U5Vs+Bat2FlNFRJ3Xy57cW0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50E90F80218;
	Fri, 29 Jan 2021 18:33:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D231FF8025F; Fri, 29 Jan 2021 18:33:01 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7063AF80130
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 18:32:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7063AF80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="q31UQwg+"
Received: by mail-wm1-x32e.google.com with SMTP id 190so7443268wmz.0
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aez8PVObRInISJ18DKfgcQIQqvuy67+Y7a5HFxY8OU8=;
 b=q31UQwg+6sm7u+A6JNafUr/fYxe0Gf76aDsTPUG312pq+ILyrsJ+6A1dmC8ce4giMo
 Va5+A5WUZEA4AR1hRSGUkngBHBFzs+e4GkCi0VJKzSXKf7eK/ZT6kcS3AxrbsUY+DYcZ
 WI2hJ3WV6FZ8iHk2jCgEoK1Z4o8b2w7gUcbAMTM9udjcsEi4WEueNEmfgwMHmqhkO0bn
 XzaLnqfPKQtN5ED9PUAfFkPZIn1URMjNPn3iBuOW2YvmMnfrfnWWzwGgeskjItfgSguD
 Sf0Ylue9pfE3sCBqlH6qtj0qybVg8X/cp66iFSuoIcAGEcARWLgrC8+Rl9wN1EvNg9RC
 WrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aez8PVObRInISJ18DKfgcQIQqvuy67+Y7a5HFxY8OU8=;
 b=geHMSaPNwcOIyCzDk0AwfgptMhPnsp5MekZaBFDs/JG4YBBurQ+5aL/ad2iGYUXqjS
 zLQA5sabG0fVLjdTjGfXn6OvgP8gwQ7mAq7l1967nLj+vDOa2xrF+Pag5XCisHIBHH7f
 4alYoMfhvrKS0DBKyTJGmf1grfyi5MeXfAjvrAsvMc0DBLxGDIaNaVCtEUbL+j3TP5Qd
 aNUiwixiFiprb0pSAraOZk4GlSxxvA5OhZAdS4uLpPqowmMd2gurAAZmYdGMxk17MBvK
 H++mgj9BJ3oMdCCsh6riay6no3aXAnq+gElh3VUSb8PU5rfYIYOyN8fBDGtsK/lbrb0G
 BWQQ==
X-Gm-Message-State: AOAM531HhF0Admyo1P102i59w1nxgMyz4pRDyN85JJAGrLrKnWxV7zvv
 Q6KQhQl6FWvqdBZ6G6pvsa107Q==
X-Google-Smtp-Source: ABdhPJwvt027/229+3L3Oa99agF/XUe7Ir5dIww1gH0PGuykMQJVIuF4H4uqchf2EyNEh76OgYUC/g==
X-Received: by 2002:a1c:5456:: with SMTP id p22mr4835322wmi.81.1611941573612; 
 Fri, 29 Jan 2021 09:32:53 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 09:32:52 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH 0/6] soundwire: qcom: various improvements
Date: Fri, 29 Jan 2021 17:32:42 +0000
Message-Id: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

During testing SoundWire controller on SM8250 MTP, we found
few issues like all the interrupts are not handled,
all transport parameters are not read from device tree.

Other major issue was register read/writes which was interrupt based
was an overhead and puts lot of limitation on context it can be used from.

So this patchset add various improvements to the existing driver
to address above issues.

Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Srinivas Kandagatla (6):
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: extract version field
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts

 drivers/soundwire/qcom.c | 471 ++++++++++++++++++++++++++++++---------
 1 file changed, 366 insertions(+), 105 deletions(-)

-- 
2.21.0

